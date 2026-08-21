using GameFramework.Runtime;

namespace Ase;

public class NewsTipItemViewModel : OptionBase
{
	private long id;

	private string content;

	private long startTime;

	private long endTime;

	private long countdown;

	private long duration;

	private bool isDelete;

	private Timer startTimer;

	private Timer repeatTimer;

	private Timer endTimer;

	public long ID => id;

	public string Content => content;

	public long StartTime => startTime;

	public long EndTime => endTime;

	public bool IsDelete => isDelete;

	public NewsTipItemViewModel(long id, string content, long startTime, long endTime, long duration, bool isDelete)
	{
		this.id = id;
		this.content = content;
		this.startTime = startTime;
		this.endTime = endTime;
		this.duration = duration;
		this.isDelete = isDelete;
	}

	private void Add()
	{
		Context.GetApplicationContext().GetService<IMessenger>()?.Publish(new GameNewsMessage(this, NewsTipMsgEnum.Add, this));
	}

	private void Remove()
	{
		Context.GetApplicationContext().GetService<IMessenger>()?.Publish(new GameNewsMessage(this, NewsTipMsgEnum.Remove, this));
	}

	public void OpenStartEndTimer(long serverTime)
	{
		CancelTimers();
		if (endTime <= serverTime)
		{
			Remove();
		}
		else if (startTime > serverTime)
		{
			countdown = startTime - serverTime;
			startTimer = Timer.Register(countdown, AwaitStartTimer, null, isLooped: false, useRealTime: true);
		}
		else
		{
			AwaitStartTimer();
		}
	}

	private void AwaitStartTimer()
	{
		if (startTimer != null)
		{
			Timer.Cancel(startTimer);
			startTimer = null;
		}
		long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
		countdown = endTime - curServerTime;
		if (countdown <= 0)
		{
			Remove();
			return;
		}
		endTimer = Timer.Register(countdown, StartEndTime, null, isLooped: false, useRealTime: true);
		if (duration > 0)
		{
			repeatTimer = Timer.Register(duration, Add, null, isLooped: true, useRealTime: true);
		}
		Add();
	}

	private void CancelTimers()
	{
		if (startTimer != null)
		{
			Timer.Cancel(startTimer);
			startTimer = null;
		}
		if (endTimer != null)
		{
			Timer.Cancel(endTimer);
			endTimer = null;
		}
		if (repeatTimer != null)
		{
			Timer.Cancel(repeatTimer);
			repeatTimer = null;
		}
	}

	private void StartEndTime()
	{
		CancelTimers();
		Remove();
	}

	public override void Close()
	{
		CancelTimers();
		base.Close();
	}
}
