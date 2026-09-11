using System;
using System.Collections.Generic;
using UnityEngine;

public class ActionTimer : MonoBehaviour
{
	private class Timer
	{
		public int id;

		public bool isActive;

		public float rate;

		public int ticks;

		public int ticksElapsed;

		public float last;

		public Action callBack;

		public Timer(int inId, float inRate, int inTicks, Action inCallBack)
		{
			id = inId;
			rate = ((inRate < 0f) ? 0f : inRate);
			ticks = ((inTicks >= 0) ? inTicks : 0);
			callBack = inCallBack;
			last = 0f;
			ticksElapsed = 0;
			isActive = true;
		}

		public void Tick()
		{
			last += Time.deltaTime;
			if (isActive && last >= rate)
			{
				last = 0f;
				ticksElapsed++;
				callBack();
				if (ticks > 0 && ticks == ticksElapsed)
				{
					isActive = false;
					timer.RemoveTimer(id);
				}
			}
		}
	}

	public static ActionTimer timer;

	private List<Timer> timers;

	private List<int> removalPending;

	private int idCounter;

	private void Awake()
	{
		timer = this;
		timers = new List<Timer>();
		removalPending = new List<int>();
	}

	private void Update()
	{
		Remove();
		Tick();
	}

	public int AddTimer(float rate, Action callBack)
	{
		return AddTimer(rate, 0, callBack);
	}

	public void RemoveTimer(int timerId)
	{
		removalPending.Add(timerId);
	}

	public int AddTimer(float rate, int ticks, Action callBack)
	{
		Timer timer = new Timer(++idCounter, rate, ticks, callBack);
		timers.Add(timer);
		return timer.id;
	}

	private void Remove()
	{
		int count = removalPending.Count;
		if (count <= 0)
		{
			return;
		}
		for (int i = 0; i < count; i++)
		{
			for (int j = 0; j < timers.Count; j++)
			{
				if (timers[j].id == removalPending[i])
				{
					timers.RemoveAt(j);
					break;
				}
			}
		}
		removalPending.Clear();
	}

	private void Tick()
	{
		for (int i = 0; i < timers.Count; i++)
		{
			timers[i].Tick();
		}
	}
}
