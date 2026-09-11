using System;
using System.Collections.Generic;
using UnityEngine;

public class FuncTimerManager : MonoBehaviour
{
	private static FuncTimerManager _inst;

	public bool isRunning;

	private int timerKey;

	private Dictionary<int, FuncTimer> dictTimers;

	private Dictionary<int, FuncTimer> tmpAddTimers;

	private List<int> clearedTimer;

	public static FuncTimerManager inst
	{
		get
		{
			if (_inst == null)
			{
				GameObject gameObject = GameObject.Find("GameManager");
				if (gameObject == null)
				{
					return null;
				}
				_inst = gameObject.AddComponent<FuncTimerManager>();
			}
			return _inst;
		}
	}

	private void Awake()
	{
		if (dictTimers == null)
		{
			dictTimers = new Dictionary<int, FuncTimer>();
			tmpAddTimers = new Dictionary<int, FuncTimer>();
			clearedTimer = new List<int>();
			timerKey = 0;
			isRunning = true;
		}
	}

	public int CreateFuncTimer(Action func, float interval, int times = -1, bool autoStart = true)
	{
		timerKey++;
		FuncTimer value = new FuncTimer(func, interval, times, autoStart);
		tmpAddTimers.Add(timerKey, value);
		return timerKey;
	}

	public int CreateFuncFrameTimer(Action func, int times = -1, bool autoStart = true)
	{
		timerKey++;
		FuncTimer value = new FuncTimer(func, times, autoStart);
		tmpAddTimers.Add(timerKey, value);
		return timerKey;
	}

	public void StartFuncTimer(int timerId)
	{
		if (dictTimers.TryGetValue(timerId, out var value))
		{
			value.Start();
		}
		else if (tmpAddTimers.TryGetValue(timerId, out value))
		{
			value.Start();
		}
	}

	public void ResetFuncTimer(int timerId)
	{
		if (dictTimers.TryGetValue(timerId, out var value))
		{
			value.Reset();
		}
		else if (tmpAddTimers.TryGetValue(timerId, out value))
		{
			value.Reset();
		}
	}

	public void StopFuncTimer(int timerId)
	{
		if (dictTimers.TryGetValue(timerId, out var value))
		{
			value.Stop();
		}
		else if (tmpAddTimers.TryGetValue(timerId, out value))
		{
			value.Stop();
		}
	}

	public void RemoveFuncTimer(int timerId)
	{
		if (dictTimers.TryGetValue(timerId, out var value))
		{
			value.Clear();
		}
		else if (tmpAddTimers.TryGetValue(timerId, out value))
		{
			value.Clear();
		}
	}

	public float QueryTotalTime(int timerId)
	{
		return Get(timerId)?.totalTime ?? 0f;
	}

	private FuncTimer Get(int timerId)
	{
		if (!dictTimers.TryGetValue(timerId, out var value))
		{
			tmpAddTimers.TryGetValue(timerId, out value);
		}
		return value;
	}

	private void Update()
	{
		if (!isRunning)
		{
			return;
		}
		foreach (KeyValuePair<int, FuncTimer> tmpAddTimer in tmpAddTimers)
		{
			dictTimers.Add(tmpAddTimer.Key, tmpAddTimer.Value);
		}
		tmpAddTimers.Clear();
		foreach (KeyValuePair<int, FuncTimer> dictTimer in dictTimers)
		{
			if (dictTimer.Value.IsClear())
			{
				clearedTimer.Add(dictTimer.Key);
			}
			else
			{
				dictTimer.Value.Update(Time.deltaTime);
			}
		}
		foreach (int item in clearedTimer)
		{
			dictTimers.Remove(item);
		}
		clearedTimer.Clear();
	}

	public void ClearAll()
	{
		dictTimers.Clear();
		clearedTimer.Clear();
	}
}
