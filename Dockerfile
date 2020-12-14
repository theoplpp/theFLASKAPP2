FROM python:latest

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

EXPOSE 5000

COPY . . 

ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

RUN wget http://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -P /scripts

RUN chmod +x /scripts/wait-for-it.sh
ENTRYPOINT ["/scripts/wait-for-it.sh", "db:5432", "--"]
CMD ["python app.py runserver --host=0.0.0.0 --threaded"]