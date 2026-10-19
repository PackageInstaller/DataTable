using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace ACT;

public class Instructions : CustomYieldInstruction
{
	private List<LoadInstruction> m_List = new List<LoadInstruction>();

	private List<float> m_Weight = new List<float>();

	public bool Status { get; protected set; }

	public float Percent { get; protected set; }

	public override bool keepWaiting => !Status;

	public event Action onUpdate;

	public Instructions()
	{
		m_List.Clear();
		m_Weight.Clear();
	}

	~Instructions()
	{
		m_List.Clear();
		m_Weight.Clear();
	}

	public Instructions(Instructions other)
	{
		m_List = other.m_List;
		Percent = other.Percent;
		Status = other.Status;
		onUpdate = other.onUpdate;
	}

	public void AddInstruction(LoadInstruction load, float weight)
	{
		if (load != null && !m_List.Contains(load))
		{
			m_List.Add(load);
			m_Weight.Add(weight);
			load.onUpdate += OnOneUpdate;
			OnOneUpdate();
		}
	}

	public void Clear()
	{
		for (int i = 0; i < m_List.Count; i++)
		{
			m_List[i].onUpdate -= OnOneUpdate;
		}
		m_List.Clear();
		m_Weight.Clear();
		OnOneUpdate();
	}

	public float ExceptPercent(LoadInstruction except)
	{
		if (!m_List.Contains(except))
		{
			return Percent;
		}
		return Percent - except.percent * m_Weight[m_List.IndexOf(except)] / m_Weight.Sum();
	}

	private void OnOneUpdate()
	{
		Percent = 0f;
		float num = m_Weight.Sum();
		for (int i = 0; i < m_List.Count; i++)
		{
			Percent += m_List[i].percent * m_Weight[i] / num;
		}
		if (Mathf.Approximately(Percent, 1f))
		{
			Percent = 1f;
		}
		onUpdate?.Invoke();
	}

	public bool GetAllLoadInstructionStatus()
	{
		foreach (LoadInstruction item in m_List)
		{
			if (!item.status)
			{
				return false;
			}
		}
		return true;
	}
}
