using System;
using System.Collections.Generic;

namespace UnityEngine.Rendering;

[Serializable]
public class SerializedDictionary<K, V> : SerializedDictionary<K, V, K, V>
{
	public override K SerializeKey(K key)
	{
		return key;
	}

	public override V SerializeValue(V val)
	{
		return val;
	}

	public override K DeserializeKey(K key)
	{
		return key;
	}

	public override V DeserializeValue(V val)
	{
		return val;
	}
}
[Serializable]
public abstract class SerializedDictionary<K, V, SK, SV> : Dictionary<K, V>, ISerializationCallbackReceiver
{
	[SerializeField]
	private List<SK> m_Keys = new List<SK>();

	[SerializeField]
	private List<SV> m_Values = new List<SV>();

	public abstract SK SerializeKey(K key);

	public abstract SV SerializeValue(V value);

	public abstract K DeserializeKey(SK serializedKey);

	public abstract V DeserializeValue(SV serializedValue);

	public void OnBeforeSerialize()
	{
		m_Keys.Clear();
		m_Values.Clear();
		using Enumerator enumerator = GetEnumerator();
		while (enumerator.MoveNext())
		{
			KeyValuePair<K, V> current = enumerator.Current;
			m_Keys.Add(SerializeKey(current.Key));
			m_Values.Add(SerializeValue(current.Value));
		}
	}

	public void OnAfterDeserialize()
	{
		for (int i = 0; i < m_Keys.Count; i++)
		{
			Add(DeserializeKey(m_Keys[i]), DeserializeValue(m_Values[i]));
		}
		m_Keys.Clear();
		m_Values.Clear();
	}
}
