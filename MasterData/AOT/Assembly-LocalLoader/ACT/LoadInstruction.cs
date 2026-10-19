using System;
using UnityEngine;

namespace ACT;

public class LoadInstruction : CustomYieldInstruction
{
	public readonly string name;

	public bool status;

	protected long m_Total;

	protected long m_Current;

	public override bool keepWaiting => !status;

	public virtual float percent
	{
		get
		{
			if (status)
			{
				return 1f;
			}
			if (m_Total == 0L)
			{
				return 0f;
			}
			return (float)m_Current / (float)m_Total;
		}
	}

	public long Total => m_Total;

	public new long Current => m_Current;

	public event Action onUpdate;

	public LoadInstruction()
	{
		status = true;
	}

	public LoadInstruction(string str = "")
	{
		name = str;
		status = true;
	}

	protected virtual void Release()
	{
		status = true;
		m_Total = 1L;
		onUpdate = null;
	}

	public virtual void CompleteOne()
	{
		m_Current++;
		if (m_Current >= m_Total)
		{
			status = true;
		}
		onUpdate?.Invoke();
	}

	public void AddBatch(long count)
	{
		m_Current += count;
		m_Current = (long)Mathf.Clamp(m_Current, 0f, m_Total);
		if (m_Current >= m_Total)
		{
			status = true;
		}
		onUpdate?.Invoke();
	}

	public void Start(long totalMissionCount)
	{
		Clear();
		m_Total = totalMissionCount;
		if (totalMissionCount > 0)
		{
			status = false;
		}
		else
		{
			status = true;
		}
		onUpdate?.Invoke();
	}

	public void Clear()
	{
		m_Current = 0L;
		m_Total = 0L;
	}

	public virtual void WaitOne()
	{
		Wait(1L);
	}

	public void Wait(long count)
	{
		if (count > 0)
		{
			m_Total += count;
			status = m_Total <= 0;
			onUpdate?.Invoke();
		}
	}

	public void OnUpdate()
	{
		onUpdate?.Invoke();
	}

	public static void Release(LoadInstruction l)
	{
		l.Release();
	}
}
