using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Unity.VisualScripting.Community.Libraries.Humility;

[Serializable]
public class DefinedDictionary<TKey, TValue> : ISerializationCallbackReceiver
{
	public Dictionary<TKey, TValue> previous = new Dictionary<TKey, TValue>();

	public Dictionary<TKey, TValue> current = new Dictionary<TKey, TValue>();

	[SerializeField]
	private List<string> previousSerializedKeys = new List<string>();

	[SerializeField]
	private List<string> previousSerializedValues = new List<string>();

	[SerializeField]
	private List<string> currentSerializedKeys = new List<string>();

	[SerializeField]
	private List<string> currentSerializedValues = new List<string>();

	public void DebugCurrent()
	{
		List<TKey> list = Keys().ToList();
		for (int i = 0; i < list.Count; i++)
		{
			Debug.Log(current[list[i]]);
		}
	}

	public void DebugPrevious()
	{
		List<TKey> list = Keys().ToList();
		for (int i = 0; i < list.Count; i++)
		{
			Debug.Log(current[list[i]]);
		}
	}

	public void Add(TKey key, TValue value)
	{
		if (!previous.ContainsKey(key))
		{
			previous.Add(key, value);
		}
		if (!current.ContainsKey(key))
		{
			current.Add(key, value);
		}
	}

	public void Remove(TKey key)
	{
		if (previous.ContainsKey(key))
		{
			previous.Remove(key);
		}
		if (current.ContainsKey(key))
		{
			current.Remove(key);
		}
	}

	public void Clear()
	{
		current.Clear();
	}

	public IEnumerable<TKey> Keys()
	{
		return current.Keys;
	}

	public IEnumerable<TValue> Values()
	{
		return current.Values;
	}

	public TValue Define(TKey key, ref bool defined, Func<TValue, TValue> onCreate, Action<TValue> exists)
	{
		TValue val = current.Define(previous, key, onCreate, exists);
		if (!current.ContainsKey(key))
		{
			defined = true;
		}
		Add(key, val);
		return val;
	}

	public void Undefine(ref bool removed, Action<TValue> onRemoved)
	{
		int num = 10;
		bool _removed = removed;
		for (int i = 0; i < num && (i <= 0 || removed); i++)
		{
			current.Undefine(previous, (TValue val) =>
			{
				_removed = true;
				onRemoved(val);
			});
		}
	}

	public void OnBeforeSerialize()
	{
		previousSerializedKeys.Clear();
		currentSerializedKeys.Clear();
		previousSerializedValues.Clear();
		currentSerializedValues.Clear();
		List<TKey> list = previous.Keys.ToList();
		List<TKey> list2 = current.Keys.ToList();
		List<TValue> value = previous.Values.ToList();
		List<TValue> value2 = current.Values.ToList();
		for (int i = 0; i < list.Count; i++)
		{
			previousSerializedKeys.Add(list.Serialized());
			previousSerializedValues.Add(value.Serialized());
		}
		for (int j = 0; j < list2.Count; j++)
		{
			currentSerializedKeys.Add(list2.Serialized());
			currentSerializedValues.Add(value2.Serialized());
		}
	}

	public void OnAfterDeserialize()
	{
		previous.Clear();
		current.Clear();
		for (int i = 0; i < previousSerializedKeys.Count; i++)
		{
			previous.Add((TKey)previousSerializedKeys[i].Deserialized(), (TValue)previousSerializedValues[i].Deserialized());
		}
		for (int j = 0; j < currentSerializedKeys.Count; j++)
		{
			previous.Add((TKey)currentSerializedKeys[j].Deserialized(), (TValue)currentSerializedValues[j].Deserialized());
		}
	}
}
