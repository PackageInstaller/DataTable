using System;
using UnityEngine.Localization.SmartFormat.Core.Extensions;

namespace UnityEngine.Localization.SmartFormat.PersistentVariables;

[Serializable]
public class Variable<T> : IVariableValueChanged, IVariable
{
	[SerializeField]
	private T m_Value;

	public T Value
	{
		get
		{
			return m_Value;
		}
		set
		{
			if (m_Value == null || !m_Value.Equals(value))
			{
				m_Value = value;
				SendValueChangedEvent();
			}
		}
	}

	public event Action<IVariable> ValueChanged;

	public object GetSourceValue(ISelectorInfo _)
	{
		return Value;
	}

	private void SendValueChangedEvent()
	{
		ValueChanged?.Invoke(this);
	}

	public override string ToString()
	{
		return Value.ToString();
	}
}
