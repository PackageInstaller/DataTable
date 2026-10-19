using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT;

[Serializable]
public class SerializedDictionary<TKey, TValue> : Dictionary<TKey, TValue>, ISerializationCallbackReceiver
{
	[SerializeField]
	private List<TKey> m_Keys = new List<TKey>();

	[SerializeField]
	private List<TValue> m_Values = new List<TValue>();

	public void OnBeforeSerialize()
	{
		m_Keys.Clear();
		m_Values.Clear();
		using Enumerator enumerator = GetEnumerator();
		while (enumerator.MoveNext())
		{
			KeyValuePair<TKey, TValue> current = enumerator.Current;
			m_Keys.Add(current.Key);
			m_Values.Add(current.Value);
		}
	}

	public void OnAfterDeserialize()
	{
		Clear();
		int num = Math.Min(m_Keys.Count, m_Values.Count);
		_ = m_Keys.Count;
		_ = m_Values.Count;
		bool flag = false;
		bool flag2 = false;
		for (int i = 0; i < num; i++)
		{
			TKey val = m_Keys[i];
			if (val == null)
			{
				flag2 = true;
				continue;
			}
			if (ContainsKey(val))
			{
				flag = true;
			}
			base[val] = m_Values[i];
		}
	}
}
