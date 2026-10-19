using System;
using System.Collections.Generic;

namespace UnityEngine.ResourceManagement.Profiling;

internal class ProfilerFrameData<T1, T2>
{
	private Dictionary<T1, T2> m_Data;

	private T2[] m_Array;

	private uint m_Version;

	private uint m_ArrayVersion;

	internal Dictionary<T1, T2> Data => m_Data;

	public T2[] Values
	{
		get
		{
			if (m_ArrayVersion == m_Version)
			{
				return m_Array ?? Array.Empty<T2>();
			}
			m_Array = new T2[m_Data.Count];
			m_Data.Values.CopyTo(m_Array, 0);
			m_ArrayVersion = m_Version;
			return m_Array;
		}
	}

	public T2 this[T1 key]
	{
		get
		{
			if (!m_Data.TryGetValue(key, out var value))
			{
				throw new ArgumentOutOfRangeException("Key " + key.ToString() + " not found for FrameData");
			}
			return value;
		}
		set
		{
			if (m_Array != null && m_Data.TryGetValue(key, out var value2))
			{
				for (int i = 0; i < m_Array.Length; i++)
				{
					ref readonly T2 reference = ref m_Array[i];
					object obj = value2;
					if (reference.Equals(obj))
					{
						m_Array[i] = value;
						break;
					}
				}
			}
			m_Data[key] = value;
		}
	}

	public ProfilerFrameData()
	{
		m_Data = new Dictionary<T1, T2>(32);
	}

	public ProfilerFrameData(int count)
	{
		m_Data = new Dictionary<T1, T2>(count);
	}

	public bool Add(T1 key, T2 value)
	{
		bool flag = m_Data.ContainsKey(key);
		m_Data[key] = value;
		m_Version++;
		return !flag;
	}

	internal bool Remove(T1 key)
	{
		bool flag = m_Data.Remove(key);
		if (flag)
		{
			m_Version++;
		}
		return flag;
	}

	public bool TryGetValue(T1 key, out T2 value)
	{
		return m_Data.TryGetValue(key, out value);
	}

	public bool ContainsKey(T1 key)
	{
		return m_Data.ContainsKey(key);
	}

	public IEnumerable<KeyValuePair<T1, T2>> Enumerate()
	{
		foreach (KeyValuePair<T1, T2> datum in m_Data)
		{
			yield return datum;
		}
	}
}
