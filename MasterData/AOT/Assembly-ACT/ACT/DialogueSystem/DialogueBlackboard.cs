using System;
using System.Collections.Generic;

namespace ACT.DialogueSystem;

public class DialogueBlackboard
{
	private readonly Dictionary<Type, object> m_Values = new Dictionary<Type, object>();

	public bool AddValue<T>(object value)
	{
		return m_Values.TryAdd(typeof(T), value);
	}

	public bool RemoveValue<T>()
	{
		return m_Values.Remove(typeof(T));
	}

	public void SetValue<T>(object value)
	{
		m_Values[typeof(T)] = value;
	}

	public void GetAllValues(List<object> result)
	{
		result.Clear();
		result.AddRange(m_Values.Values);
	}

	public void ClearAllValues()
	{
		m_Values.Clear();
	}
}
