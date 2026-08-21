using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace ES3Internal;

[Serializable]
public abstract class ES3SerializableDictionary<TKey, TVal> : Dictionary<TKey, TVal>, ISerializationCallbackReceiver
{
	[SerializeField]
	private List<TKey> _Keys;

	[SerializeField]
	private List<TVal> _Values;

	protected abstract bool KeysAreEqual(TKey a, TKey b);

	protected abstract bool ValuesAreEqual(TVal a, TVal b);

	public void OnBeforeSerialize()
	{
		_Keys = new List<TKey>();
		_Values = new List<TVal>();
		using Enumerator enumerator = GetEnumerator();
		while (enumerator.MoveNext())
		{
			KeyValuePair<TKey, TVal> current = enumerator.Current;
			try
			{
				_Keys.Add(current.Key);
				_Values.Add(current.Value);
			}
			catch
			{
			}
		}
	}

	public void OnAfterDeserialize()
	{
		if (_Keys == null || _Values == null)
		{
			return;
		}
		if (_Keys.Count != _Values.Count)
		{
			throw new Exception($"Key count is different to value count after deserialising dictionary.");
		}
		Clear();
		for (int i = 0; i < _Keys.Count; i++)
		{
			if (_Keys[i] != null)
			{
				try
				{
					Add(_Keys[i], _Values[i]);
				}
				catch
				{
				}
			}
		}
		_Keys = null;
		_Values = null;
	}

	public int RemoveNullValues()
	{
		List<TKey> list = (from pair in this
			where pair.Value == null
			select pair.Key).ToList();
		foreach (TKey item in list)
		{
			Remove(item);
		}
		return list.Count;
	}

	public bool ChangeKey(TKey oldKey, TKey newKey)
	{
		if (KeysAreEqual(oldKey, newKey))
		{
			return false;
		}
		TVal value = base[oldKey];
		Remove(oldKey);
		base[newKey] = value;
		return true;
	}
}
