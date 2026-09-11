using System.Collections.Generic;

namespace System.Linq.Expressions.Interpreter;

internal class HybridReferenceDictionary<TKey, TValue> where TKey : class
{
	private KeyValuePair<TKey, TValue>[] _keysAndValues;

	private Dictionary<TKey, TValue> _dict;

	public TValue this[TKey key]
	{
		get
		{
			if (TryGetValue(key, out var value))
			{
				return value;
			}
			throw new KeyNotFoundException(SR.Format("The given key '{0}' was not present in the dictionary.", key.ToString()));
		}
		set
		{
			if (_dict != null)
			{
				_dict[key] = value;
				return;
			}
			int num;
			if (_keysAndValues != null)
			{
				num = -1;
				for (int i = 0; i < _keysAndValues.Length; i++)
				{
					if (_keysAndValues[i].Key == key)
					{
						_keysAndValues[i] = new KeyValuePair<TKey, TValue>(key, value);
						return;
					}
					if (_keysAndValues[i].Key == null)
					{
						num = i;
					}
				}
			}
			else
			{
				_keysAndValues = new KeyValuePair<TKey, TValue>[10];
				num = 0;
			}
			if (num != -1)
			{
				_keysAndValues[num] = new KeyValuePair<TKey, TValue>(key, value);
				return;
			}
			_dict = new Dictionary<TKey, TValue>();
			for (int j = 0; j < _keysAndValues.Length; j++)
			{
				_dict[_keysAndValues[j].Key] = _keysAndValues[j].Value;
			}
			_keysAndValues = null;
			_dict[key] = value;
		}
	}

	public bool TryGetValue(TKey key, out TValue value)
	{
		if (_dict != null)
		{
			return _dict.TryGetValue(key, out value);
		}
		if (_keysAndValues != null)
		{
			for (int i = 0; i < _keysAndValues.Length; i++)
			{
				if (_keysAndValues[i].Key == key)
				{
					value = _keysAndValues[i].Value;
					return true;
				}
			}
		}
		value = default(TValue);
		return false;
	}

	public void Remove(TKey key)
	{
		if (_dict != null)
		{
			_dict.Remove(key);
		}
		else
		{
			if (_keysAndValues == null)
			{
				return;
			}
			for (int i = 0; i < _keysAndValues.Length; i++)
			{
				if (_keysAndValues[i].Key == key)
				{
					_keysAndValues[i] = default(KeyValuePair<TKey, TValue>);
					break;
				}
			}
		}
	}

	public bool ContainsKey(TKey key)
	{
		if (_dict != null)
		{
			return _dict.ContainsKey(key);
		}
		KeyValuePair<TKey, TValue>[] keysAndValues = _keysAndValues;
		if (keysAndValues != null)
		{
			for (int i = 0; i < keysAndValues.Length; i++)
			{
				if (keysAndValues[i].Key == key)
				{
					return true;
				}
			}
		}
		return false;
	}

	public IEnumerator<KeyValuePair<TKey, TValue>> GetEnumerator()
	{
		if (_dict != null)
		{
			return _dict.GetEnumerator();
		}
		return GetEnumeratorWorker();
	}

	private IEnumerator<KeyValuePair<TKey, TValue>> GetEnumeratorWorker()
	{
		if (_keysAndValues == null)
		{
			yield break;
		}
		for (int i = 0; i < _keysAndValues.Length; i++)
		{
			if (_keysAndValues[i].Key != null)
			{
				yield return _keysAndValues[i];
			}
		}
	}
}
