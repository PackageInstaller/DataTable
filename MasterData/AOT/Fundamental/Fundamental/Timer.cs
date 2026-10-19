using UnityEngine.Events;

namespace Fundamental;

public class Timer
{
	private float m_Interval;

	private float m_Duration;

	private bool m_Started;

	private float m_Time;

	private float m_IntervalTime;

	public UnityEvent OnInterval = new UnityEvent();

	public UnityEvent OnEnd = new UnityEvent();

	public bool Started => m_Started;

	public Timer(float duration)
	{
		m_Interval = float.MaxValue;
		m_Duration = duration;
	}

	public Timer(float duration, float interval)
	{
		m_Interval = interval;
		m_Duration = duration;
	}

	public void Reset(bool start)
	{
		m_Time = (m_IntervalTime = 0f);
		m_Started = start;
	}

	public void Toggle(bool start)
	{
		m_Started = start;
	}

	public void Update()
	{
		if (m_Started)
		{
			float num = 0.02f;
			m_Time += num;
			if (m_Time > m_Duration)
			{
				OnEnd.Invoke();
				m_Started = false;
			}
			m_IntervalTime += num;
			if (m_IntervalTime > m_Interval)
			{
				OnInterval.Invoke();
				m_IntervalTime -= m_Interval;
			}
		}
	}
}
