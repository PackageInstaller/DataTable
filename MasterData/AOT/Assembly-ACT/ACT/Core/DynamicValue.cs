using System;
using Fundamental;
using UnityEngine;

namespace ACT.Core;

public class DynamicValue
{
	[NonSerialized]
	public int id;

	private string _name;

	private float m_Value;

	private float m_Min;

	private float m_Max;

	public ActionList<float, DynamicValue> onValueChange = new ActionList<float, DynamicValue>();

	public string Name => _name;

	public float value
	{
		get
		{
			return m_Value;
		}
		set
		{
			float arg = m_Value;
			m_Value = Mathf.Clamp(value, m_Min, m_Max);
			onValueChange.Invoke(arg, this);
		}
	}

	public float min
	{
		get
		{
			return m_Min;
		}
		set
		{
			m_Min = value;
			value = m_Value;
		}
	}

	public float max
	{
		get
		{
			return m_Max;
		}
		set
		{
			m_Max = value;
			value = m_Value;
		}
	}

	public DynamicValue(string name)
	{
		_name = name;
	}
}
