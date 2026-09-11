using System;
using System.Collections.Generic;
using System.Threading;

public class TimerCenter
{
	internal class TimerInfo
	{
		public string timerName;

		public int timerId;

		public long crtTime;

		public int duration;

		public long actTime;

		public Action onTimer;

		public int dispTimerId;
	}

	internal class TimerCore
	{
		internal class TimerInfoEx
		{
			public string timerName;

			public int timerId;

			public long execTime;

			public TimerCallback onTimer;

			public object state;

			public bool enable;
		}

		private int maxIndex;

		private Dictionary<long, TimerInfoEx> id2Timer = new Dictionary<long, TimerInfoEx>();

		private SortedDictionary<long, LinkedList<TimerInfoEx>> allTimers = new SortedDictionary<long, LinkedList<TimerInfoEx>>();

		private Func<long> callback;

		public TimerCore(Func<long> callback)
		{
			this.callback = callback;
		}

		private int GetTimerId()
		{
			if (++maxIndex == 0)
			{
				maxIndex = 1;
			}
			return maxIndex;
		}

		public void SetWaitTime(long ti)
		{
			if (allTimers.Count == 0)
			{
				return;
			}
			SortedDictionary<long, LinkedList<TimerInfoEx>> sortedDictionary = new SortedDictionary<long, LinkedList<TimerInfoEx>>();
			foreach (KeyValuePair<long, LinkedList<TimerInfoEx>> allTimer in allTimers)
			{
				long num = allTimer.Key + ti;
				LinkedList<TimerInfoEx> value = allTimer.Value;
				sortedDictionary.Add(num, value);
				for (LinkedListNode<TimerInfoEx> linkedListNode = value.First; linkedListNode != null; linkedListNode = linkedListNode.Next)
				{
					linkedListNode.Value.execTime = num;
				}
			}
			allTimers = sortedDictionary;
		}

		public int SetTimer(string _timerName, long _execTime, TimerCallback _onTimer, object _state)
		{
			if (string.IsNullOrEmpty(_timerName))
			{
				_timerName = "unnamed dispTimer";
			}
			if (_execTime <= 0)
			{
				throw new ArgumentException("_execTime > 0");
			}
			if (_onTimer == null)
			{
				throw new ArgumentException("_onTimer != null");
			}
			TimerInfoEx timerInfoEx = new TimerInfoEx
			{
				timerName = _timerName,
				execTime = _execTime,
				onTimer = _onTimer,
				state = _state,
				timerId = GetTimerId(),
				enable = true
			};
			if (!allTimers.TryGetValue(_execTime, out var value))
			{
				value = new LinkedList<TimerInfoEx>();
				allTimers.Add(_execTime, value);
			}
			value.AddLast(timerInfoEx);
			id2Timer.Add(timerInfoEx.timerId, timerInfoEx);
			return timerInfoEx.timerId;
		}

		public void DeleteTimer(int timerId)
		{
			if (!id2Timer.TryGetValue(timerId, out var value))
			{
				return;
			}
			id2Timer.Remove(timerId);
			long execTime = value.execTime;
			if (allTimers.TryGetValue(execTime, out var value2))
			{
				if (value2.Count <= 1)
				{
					allTimers.Remove(execTime);
				}
				else
				{
					value2.Remove(value);
				}
			}
			value.enable = false;
		}

		public void Schedule()
		{
			if (allTimers.Count == 0)
			{
				return;
			}
			LinkedList<TimerInfoEx> linkedList = null;
			long num = callback();
			foreach (KeyValuePair<long, LinkedList<TimerInfoEx>> allTimer in allTimers)
			{
				if (allTimer.Key > num)
				{
					break;
				}
				for (LinkedListNode<TimerInfoEx> linkedListNode = allTimer.Value.First; linkedListNode != null; linkedListNode = linkedListNode.Next)
				{
					TimerInfoEx value = linkedListNode.Value;
					if (linkedList == null)
					{
						linkedList = new LinkedList<TimerInfoEx>();
					}
					linkedList.AddLast(value);
				}
			}
			if (linkedList == null)
			{
				return;
			}
			for (LinkedListNode<TimerInfoEx> linkedListNode2 = linkedList.First; linkedListNode2 != null; linkedListNode2 = linkedListNode2.Next)
			{
				TimerInfoEx value2 = linkedListNode2.Value;
				if (value2.onTimer != null && value2.enable)
				{
					value2.onTimer(value2.state);
				}
				DeleteTimer(value2.timerId);
			}
		}
	}

	private Dictionary<int, TimerInfo> TimerInfoMap = new Dictionary<int, TimerInfo>();

	private int curTimerIndex;

	private Func<long> timeFuc;

	private long pauseTime;

	private TimerCore generator;

	public TimerCenter(Func<long> timeFuc)
	{
		this.timeFuc = timeFuc;
		generator = new TimerCore(timeFuc);
	}

	private int BuildTimerId()
	{
		curTimerIndex++;
		if (curTimerIndex == 0)
		{
			curTimerIndex = 1;
		}
		return curTimerIndex;
	}

	public int SetTimer(string name, float delay, int duration, Action onTimer)
	{
		return SetTimer(name, (int)delay, duration, onTimer);
	}

	public int SetTimer(string _timerName, int _delay, int _duration, Action _onTimer)
	{
		if (_delay < 0)
		{
			throw new ArgumentException("_delay >= 0");
		}
		if (_duration < 0)
		{
			throw new ArgumentException("_duration >= 0");
		}
		if (_onTimer == null)
		{
			throw new ArgumentException("_onTimer != null");
		}
		if (string.IsNullOrEmpty(_timerName))
		{
			_timerName = "unnamed perTimer";
		}
		long num = timeFuc();
		TimerInfo timerInfo = new TimerInfo
		{
			timerId = BuildTimerId(),
			timerName = _timerName,
			crtTime = num,
			duration = _duration,
			actTime = num + _delay,
			onTimer = _onTimer
		};
		TimerInfoMap.Add(timerInfo.timerId, timerInfo);
		timerInfo.dispTimerId = generator.SetTimer(timerInfo.timerName, timerInfo.actTime, OnTimer, timerInfo);
		return timerInfo.timerId;
	}

	private void OnTimer(object state)
	{
		TimerInfo timerInfo = (TimerInfo)state;
		int timerId = timerInfo.timerId;
		if (GetTimer(timerId))
		{
			timerInfo.actTime += timerInfo.duration;
			timerInfo.onTimer();
			if (timerInfo.duration == 0)
			{
				DeleteTimer(timerId);
			}
			else
			{
				timerInfo.dispTimerId = generator.SetTimer(timerInfo.timerName, timerInfo.actTime, OnTimer, timerInfo);
			}
		}
	}

	public bool GetTimer(int timerId)
	{
		return TimerInfoMap.ContainsKey(timerId);
	}

	public void DeleteTimer(int timerId)
	{
		TimerInfo value = null;
		if (TimerInfoMap.TryGetValue(timerId, out value))
		{
			generator.DeleteTimer(value.dispTimerId);
			TimerInfoMap.Remove(timerId);
		}
	}

	public void Schedule()
	{
		if (pauseTime == 0L)
		{
			generator.Schedule();
		}
	}

	public void Pause()
	{
		pauseTime = timeFuc();
	}

	public void Resume()
	{
		if (pauseTime == 0L)
		{
			return;
		}
		long num = timeFuc() - pauseTime;
		foreach (TimerInfo value in TimerInfoMap.Values)
		{
			value.actTime += num;
		}
		generator.SetWaitTime(num);
		pauseTime = 0L;
	}
}
