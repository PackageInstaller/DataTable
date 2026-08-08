using System;

public class FuncTimer
{
	public float totalTime;

	private float interval;

	private int times;

	private Action func;

	private FuncTimerState state;

	private FuncTimerMode mode;

	private float curInterval;

	private int curTimes;

	public FuncTimer(Action func, float interval, int times = -1, bool autoStart = true)
	{
		this.interval = interval;
		this.func = func;
		this.times = times;
		curInterval = 0f;
		curTimes = 0;
		state = (autoStart ? FuncTimerState.Running : FuncTimerState.Stop);
		mode = FuncTimerMode.Interval;
	}

	public FuncTimer(Action func, int times = -1, bool autoStart = true)
	{
		this.func = func;
		this.times = times;
		interval = 0f;
		curInterval = 0f;
		curTimes = 0;
		state = (autoStart ? FuncTimerState.Running : FuncTimerState.Stop);
		mode = FuncTimerMode.PerFrame;
	}

	public void Start()
	{
		state = FuncTimerState.Running;
	}

	public void Stop()
	{
		state = FuncTimerState.Stop;
	}

	public void Clear()
	{
		state = FuncTimerState.Clear;
	}

	public void Update(float dt)
	{
		if (state != FuncTimerState.Running)
		{
			return;
		}
		totalTime += dt;
		if (mode == FuncTimerMode.PerFrame)
		{
			if (times == -1)
			{
				CallFunc();
				return;
			}
			CallFunc();
			curTimes++;
			if (curTimes >= times)
			{
				state = FuncTimerState.Clear;
			}
			return;
		}
		curInterval += dt;
		if (!(curInterval >= interval))
		{
			return;
		}
		if (times == -1)
		{
			curInterval = 0f;
			CallFunc();
			return;
		}
		curInterval = 0f;
		CallFunc();
		curTimes++;
		if (curTimes >= times)
		{
			state = FuncTimerState.Clear;
		}
	}

	public void CallFunc()
	{
		if (func != null)
		{
			func();
		}
	}

	public bool IsClear()
	{
		return state == FuncTimerState.Clear;
	}

	public void Reset()
	{
		curInterval = 0f;
		curTimes = 0;
		totalTime = 0f;
	}
}
