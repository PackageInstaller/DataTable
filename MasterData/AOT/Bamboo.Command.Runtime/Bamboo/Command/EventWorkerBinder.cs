namespace Bamboo.Command;

public class EventWorkerBinder
{
	private readonly EventStation _eventStation;

	private readonly Worker _worker;

	public EventWorkerBinder(EventStation eventStation, Worker worker)
	{
		_eventStation = eventStation;
		_worker = worker;
	}

	public void AddPeek(int eventID, int assignmentID, int order = 0, bool nowExecute = false, bool isBreak = false)
	{
		_eventStation.AddPeek(eventID, () =>
		{
			_worker.Accept(assignmentID, nowExecute);
			return !isBreak;
		}, order);
	}

	public void AddPeek<T>(int eventID, int assignmentID, int order = 0, bool nowExecute = false, bool isBreak = false)
	{
		_eventStation.AddPeek(eventID, (T arg) =>
		{
			_worker.Accept(assignmentID, arg, nowExecute);
			return !isBreak;
		}, order);
	}

	public void AddPeek<T1, T2>(int eventID, int assignmentID, int order = 0, bool nowExecute = false, bool isBreak = false)
	{
		_eventStation.AddPeek(eventID, (T1 arg1, T2 arg2) =>
		{
			_worker.Accept(assignmentID, arg1, arg2, nowExecute);
			return !isBreak;
		}, order);
	}

	public void AddPeek<T1, T2, T3>(int eventID, int assignmentID, int order = 0, bool nowExecute = false, bool isBreak = false)
	{
		_eventStation.AddPeek(eventID, (T1 arg1, T2 arg2, T3 arg3) =>
		{
			_worker.Accept(assignmentID, arg1, arg2, arg3, nowExecute);
			return !isBreak;
		}, order);
	}
}
