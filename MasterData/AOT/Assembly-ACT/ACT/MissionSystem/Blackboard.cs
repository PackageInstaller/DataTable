using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.MissionSystem;

public class Blackboard
{
	private Dictionary<string, object> m_Data = new Dictionary<string, object>();

	public object Get(string key)
	{
		m_Data.TryGetValue(key, out var value);
		return value;
	}

	public void Add(string key, object value)
	{
		m_Data.Add(key, value);
	}

	public void Set(string key, object value)
	{
		m_Data[key] = value;
	}

	public void Clear()
	{
		try
		{
			foreach (KeyValuePair<string, object> datum in m_Data)
			{
				if (datum.Value is IDisposable disposable)
				{
					disposable.Dispose();
				}
			}
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
		m_Data.Clear();
	}

	public void Remove(string key)
	{
		m_Data.Remove(key);
	}
}
