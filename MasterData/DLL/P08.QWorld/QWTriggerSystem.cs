using System.Collections.Generic;

public class QWTriggerSystem
{
	public static QWTriggerSystem Instance;

	private HashSet<QWSphereTriggerArea> triggers;

	private Queue<QueueTask> queueOpr;

	public void Init()
	{
		queueOpr = new Queue<QueueTask>();
		triggers = new HashSet<QWSphereTriggerArea>();
		Instance = this;
	}

	public void Tick()
	{
		while (queueOpr.Count > 0)
		{
			QueueTask queueTask = queueOpr.Dequeue();
			if (queueTask.isAdd)
			{
				triggers.Add(queueTask.trigger);
			}
			else
			{
				triggers.Remove(queueTask.trigger);
			}
		}
		foreach (QWSphereTriggerArea trigger in triggers)
		{
			trigger.Tick();
		}
		while (queueOpr.Count > 0)
		{
			QueueTask queueTask2 = queueOpr.Dequeue();
			if (queueTask2.isAdd)
			{
				triggers.Add(queueTask2.trigger);
			}
			else
			{
				triggers.Remove(queueTask2.trigger);
			}
		}
	}

	public void Register(QWSphereTriggerArea component)
	{
		queueOpr.Enqueue(new QueueTask
		{
			isAdd = true,
			trigger = component
		});
	}

	public void UnRegister(QWSphereTriggerArea component)
	{
		queueOpr.Enqueue(new QueueTask
		{
			isAdd = false,
			trigger = component
		});
	}

	public void Dispose()
	{
		queueOpr.Clear();
		triggers.Clear();
		Instance = null;
	}
}
