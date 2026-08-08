using System;
using System.Threading;

public sealed class ManualResetTaskSchedule : TaskScheduleBase
{
	private ManualResetEvent mResetEvent;

	public ManualResetTaskSchedule(Action<TaskScheduleBase> workerCallback, string name, ManualResetEvent resetEvent)
		: base(workerCallback, name)
	{
		mResetEvent = resetEvent;
	}

	protected override void DoTerminate(int millisecondTimeout)
	{
		mResetEvent.Set();
	}

	protected override void RunThreadBlocker()
	{
		mResetEvent.WaitOne();
		mResetEvent.Reset();
	}
}
