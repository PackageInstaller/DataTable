using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using UnityEngine;

namespace GameFramework.Runtime;

public class TimerComponent : GameFrameworkComponent
{
	private enum TimerType
	{
		None,
		OnceWait,
		Once,
		Repeated
	}

	private class Timer : IReference
	{
		private static int m_SerialId;

		public TimerType TimerType { get; private set; }

		public object Callback { get; private set; }

		public Action<long> UpdateCallBack { get; private set; }

		public long Time { get; set; }

		public long StartTime { get; set; }

		public int RepeatCount { get; set; }

		public int ID { get; private set; }

		static Timer()
		{
			m_SerialId = 0;
		}

		public static Timer Create(long time, long startTime, TimerType timerType, object callback, int repeatCount = 0, Action<long> updateCallBack = null)
		{
			Timer timer = ReferencePool.Acquire<Timer>();
			timer.ID = m_SerialId++;
			timer.Time = time;
			timer.StartTime = startTime;
			timer.TimerType = timerType;
			timer.Callback = callback;
			timer.RepeatCount = repeatCount;
			timer.UpdateCallBack = updateCallBack;
			return timer;
		}

		public void Clear()
		{
			ID = -1;
			Time = 0L;
			StartTime = 0L;
			Callback = null;
			UpdateCallBack = null;
			RepeatCount = 0;
			TimerType = TimerType.None;
		}
	}

	private class PausedTimer : IReference
	{
		public Timer Timer { get; private set; }

		public long PausedTime { get; private set; }

		public long GetResidueTime()
		{
			return Timer.Time + Timer.StartTime - PausedTime;
		}

		public static PausedTimer Create(long pausedTime, Timer pauseTimer)
		{
			PausedTimer pausedTimer = ReferencePool.Acquire<PausedTimer>();
			pausedTimer.Timer = pauseTimer;
			pausedTimer.PausedTime = pausedTime;
			return pausedTimer;
		}

		public void Clear()
		{
			Timer = null;
			PausedTime = 0L;
		}
	}

	private readonly Dictionary<int, Timer> m_Timers = new Dictionary<int, Timer>();

	private readonly MultiMap<long, int> m_TimeId = new MultiMap<long, int>();

	private readonly Queue<long> m_TimeOutTime = new Queue<long>();

	private readonly Queue<int> m_TimeOutTimerIds = new Queue<int>();

	private readonly Dictionary<int, PausedTimer> m_PausedTimer = new Dictionary<int, PausedTimer>();

	private readonly Dictionary<int, Timer> m_UpdateTimer = new Dictionary<int, Timer>();

	private long m_MinTime;

	private void Update()
	{
		RunUpdateCallBack();
		if (m_TimeId.Count == 0)
		{
			return;
		}
		long num = TimerTimeUtility.Now();
		if (num < m_MinTime)
		{
			return;
		}
		foreach (KeyValuePair<long, List<int>> item in m_TimeId)
		{
			long key = item.Key;
			if (key > num)
			{
				m_MinTime = key;
				break;
			}
			m_TimeOutTime.Enqueue(key);
		}
		while (m_TimeOutTime.Count > 0)
		{
			long num2 = m_TimeOutTime.Dequeue();
			foreach (int item2 in m_TimeId[num2])
			{
				m_TimeOutTimerIds.Enqueue(item2);
			}
			m_TimeId.Remove(num2);
		}
		while (m_TimeOutTimerIds.Count > 0)
		{
			int key2 = m_TimeOutTimerIds.Dequeue();
			m_Timers.TryGetValue(key2, out var value);
			if (value != null)
			{
				RunTimer(value);
			}
		}
	}

	private void RunUpdateCallBack()
	{
		if (m_UpdateTimer.Count == 0)
		{
			return;
		}
		long num = TimerTimeUtility.Now();
		foreach (Timer value in m_UpdateTimer.Values)
		{
			value.UpdateCallBack?.Invoke(value.Time + value.StartTime - num);
		}
	}

	private void RunTimer(Timer timer)
	{
		switch (timer.TimerType)
		{
		case TimerType.OnceWait:
		{
			TaskCompletionSource<bool> taskCompletionSource = timer.Callback as TaskCompletionSource<bool>;
			RemoveTimer(timer.ID);
			taskCompletionSource?.SetResult(result: true);
			break;
		}
		case TimerType.Once:
		{
			Action action2 = timer.Callback as Action;
			RemoveTimer(timer.ID);
			action2?.Invoke();
			break;
		}
		case TimerType.Repeated:
		{
			Action action = timer.Callback as Action;
			long num = TimerTimeUtility.Now();
			long tillTime = num + timer.Time;
			if (timer.RepeatCount == 1)
			{
				RemoveTimer(timer.ID);
			}
			else
			{
				if (timer.RepeatCount > 1)
				{
					timer.RepeatCount--;
				}
				timer.StartTime = num;
				AddTimer(tillTime, timer.ID);
			}
			action?.Invoke();
			break;
		}
		}
	}

	private void AddTimer(long tillTime, int id)
	{
		m_TimeId.Add(tillTime, id);
		if (tillTime < m_MinTime)
		{
			m_MinTime = tillTime;
		}
	}

	private void RemoveTimer(int id)
	{
		m_Timers.TryGetValue(id, out var value);
		if (value == null)
		{
			Debug.LogError($"删除了不存在的Timer ID:{id}");
			return;
		}
		ReferencePool.Release(value);
		m_Timers.Remove(id);
		m_UpdateTimer.Remove(id);
		if (m_PausedTimer.ContainsKey(id))
		{
			ReferencePool.Release(m_PausedTimer[id]);
			m_PausedTimer.Remove(id);
		}
	}

	public void CancelTimer(int id)
	{
		if (m_PausedTimer.ContainsKey(id))
		{
			ReferencePool.Release(m_PausedTimer[id].Timer);
			ReferencePool.Release(m_PausedTimer[id]);
			m_PausedTimer.Remove(id);
		}
		else
		{
			RemoveTimer(id);
		}
	}

	public bool IsExistTimer(int id)
	{
		return m_PausedTimer.ContainsKey(id) || m_Timers.ContainsKey(id);
	}

	public void PauseTimer(int id)
	{
		m_Timers.TryGetValue(id, out var value);
		if (value == null)
		{
			Debug.LogError($"Timer不存在 ID:{id}");
			return;
		}
		m_TimeId.Remove(value.StartTime + value.Time, value.ID);
		m_Timers.Remove(id);
		m_UpdateTimer.Remove(id);
		PausedTimer value2 = PausedTimer.Create(TimerTimeUtility.Now(), value);
		m_PausedTimer.Add(id, value2);
	}

	public void ResumeTimer(int id)
	{
		m_PausedTimer.TryGetValue(id, out var value);
		if (value == null)
		{
			Debug.LogError($"Timer不存在 ID:{id}");
			return;
		}
		m_Timers.Add(id, value.Timer);
		if (value.Timer.UpdateCallBack != null)
		{
			m_UpdateTimer.Add(id, value.Timer);
		}
		long tillTime = TimerTimeUtility.Now() + value.GetResidueTime();
		value.Timer.StartTime += TimerTimeUtility.Now() - value.PausedTime;
		AddTimer(tillTime, value.Timer.ID);
		ReferencePool.Release(value);
		m_PausedTimer.Remove(id);
	}

	public void ChangeTime(int id, long time, bool isChangeRepeat = false)
	{
		m_PausedTimer.TryGetValue(id, out var value);
		if (value?.Timer != null)
		{
			value.Timer.Time += time;
			return;
		}
		m_Timers.TryGetValue(id, out var value2);
		if (value2 == null)
		{
			Debug.LogError($"Timer不存在 ID:{id}");
		}
		m_TimeId.Remove(value2.StartTime + value2.Time, value2.ID);
		if (value2.TimerType == TimerType.Repeated && !isChangeRepeat)
		{
			value2.StartTime += time;
		}
		else
		{
			value2.Time += time;
		}
		AddTimer(value2.StartTime + value2.Time, value2.ID);
	}

	public int AddOnceTimer(long time, Action callback, Action<long> updateCallBack = null)
	{
		if (time < 0)
		{
			Debug.LogError($"new once time too small: {time}");
		}
		long num = TimerTimeUtility.Now();
		Timer timer = Timer.Create(time, num, TimerType.Once, callback, 1, updateCallBack);
		m_Timers.Add(timer.ID, timer);
		if (updateCallBack != null)
		{
			m_UpdateTimer.Add(timer.ID, timer);
		}
		AddTimer(num + time, timer.ID);
		return timer.ID;
	}

	public async Task<bool> OnceTimerAsync(long time, TimerCancellationToken cancellationToken = null)
	{
		long nowTime = TimerTimeUtility.Now();
		if (time <= 0)
		{
			return true;
		}
		TaskCompletionSource<bool> tcs = new TaskCompletionSource<bool>();
		Timer timer = Timer.Create(time, nowTime, TimerType.OnceWait, tcs);
		m_Timers.Add(timer.ID, timer);
		int timerId = timer.ID;
		AddTimer(nowTime + time, timerId);
		bool result;
		try
		{
			cancellationToken?.Add(CancelAction);
			result = await tcs.Task;
		}
		finally
		{
			cancellationToken?.Remove(CancelAction);
		}
		return result;
		void CancelAction()
		{
			RemoveTimer(timerId);
			tcs.SetResult(result: false);
		}
	}

	public async Task<bool> FrameAsync(TimerCancellationToken cancellationToken = null)
	{
		return await OnceTimerAsync(1L, cancellationToken);
	}

	public int AddRepeatedTimer(long time, int repeatCount, Action callback, Action<long> updateCallback = null)
	{
		if (time < 0)
		{
			Debug.LogError($"new once time too small: {time}");
		}
		long num = TimerTimeUtility.Now();
		Timer timer = Timer.Create(time, num, TimerType.Repeated, callback, repeatCount, updateCallback);
		m_Timers.Add(timer.ID, timer);
		if (updateCallback != null)
		{
			m_UpdateTimer.Add(timer.ID, timer);
		}
		AddTimer(num + time, timer.ID);
		return timer.ID;
	}

	public void AddRepeatedTimer(out int id, long time, int repeatCount, Action callback, Action<long> updateCallback = null)
	{
		if (time < 0)
		{
			Debug.LogError($"new once time too small: {time}");
		}
		long num = TimerTimeUtility.Now();
		Timer timer = Timer.Create(time, num, TimerType.Repeated, callback, repeatCount, updateCallback);
		m_Timers.Add(timer.ID, timer);
		if (updateCallback != null)
		{
			m_UpdateTimer.Add(timer.ID, timer);
		}
		id = timer.ID;
		AddTimer(num + time, timer.ID);
	}

	public int AddFrameTimer(Action callback)
	{
		long num = TimerTimeUtility.Now();
		Timer timer = Timer.Create(1L, num, TimerType.Once, callback);
		m_Timers.Add(timer.ID, timer);
		AddTimer(num + 1, timer.ID);
		return timer.ID;
	}
}
