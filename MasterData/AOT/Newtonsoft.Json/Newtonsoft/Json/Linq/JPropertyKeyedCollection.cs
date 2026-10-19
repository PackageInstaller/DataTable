using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics.CodeAnalysis;
using System.Reflection;
using Newtonsoft.Json.Utilities;

namespace Newtonsoft.Json.Linq;

[DefaultMember("Item")]
internal class JPropertyKeyedCollection : Collection<JToken>
{
	private static readonly IEqualityComparer<string> Comparer = StringComparer.Ordinal;

	private Dictionary<string, JToken>? _dictionary;

	public ICollection<string> Keys
	{
		get
		{
			EnsureDictionary();
			return _dictionary.Keys;
		}
	}

	public JPropertyKeyedCollection()
		: base((IList<JToken>)new List<JToken>())
	{
	}

	private void AddKey(string key, JToken item)
	{
		EnsureDictionary();
		_dictionary[key] = item;
	}

	protected override void ClearItems()
	{
		base.ClearItems();
		_dictionary?.Clear();
	}

	public bool Contains(string key)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key");
		}
		if (_dictionary != null)
		{
			return _dictionary.ContainsKey(key);
		}
		return false;
	}

	private void EnsureDictionary()
	{
		if (_dictionary == null)
		{
			_dictionary = new Dictionary<string, JToken>(Comparer);
		}
	}

	private string GetKeyForItem(JToken item)
	{
		return ((JProperty)item).Name;
	}

	protected override void InsertItem(int index, JToken item)
	{
		AddKey(GetKeyForItem(item), item);
		base.InsertItem(index, item);
	}

	protected override void RemoveItem(int index)
	{
		string keyForItem = GetKeyForItem(Items[index]);
		RemoveKey(keyForItem);
		base.RemoveItem(index);
	}

	private void RemoveKey(string key)
	{
		_dictionary?.Remove(key);
	}

	protected override void SetItem(int index, JToken item)
	{
		string keyForItem = GetKeyForItem(item);
		string keyForItem2 = GetKeyForItem(Items[index]);
		if (Comparer.Equals(keyForItem2, keyForItem))
		{
			if (_dictionary != null)
			{
				_dictionary[keyForItem] = item;
			}
		}
		else
		{
			AddKey(keyForItem, item);
			if (keyForItem2 != null)
			{
				RemoveKey(keyForItem2);
			}
		}
		base.SetItem(index, item);
	}

	public bool TryGetValue(string key, [NotNullWhen(true)] out JToken? value)
	{
		if (_dictionary == null)
		{
			value = null;
			return false;
		}
		return _dictionary.TryGetValue(key, out value);
	}

	public int IndexOfReference(JToken t)
	{
		return ((List<JToken>)Items).IndexOfReference(t);
	}

	public bool Compare(JPropertyKeyedCollection other)
	{
		if (this == other)
		{
			return true;
		}
		Dictionary<string, JToken> dictionary = _dictionary;
		Dictionary<string, JToken> dictionary2 = other._dictionary;
		if (dictionary == null && dictionary2 == null)
		{
			return true;
		}
		if (dictionary == null)
		{
			return dictionary2.Count == 0;
		}
		if (dictionary2 == null)
		{
			return dictionary.Count == 0;
		}
		if (dictionary.Count != dictionary2.Count)
		{
			return false;
		}
		foreach (KeyValuePair<string, JToken> item in dictionary)
		{
			if (!dictionary2.TryGetValue(item.Key, out var value))
			{
				return false;
			}
			JProperty jProperty = (JProperty)item.Value;
			JProperty jProperty2 = (JProperty)value;
			if (jProperty.Value == null)
			{
				return jProperty2.Value == null;
			}
			if (!jProperty.Value.DeepEquals(jProperty2.Value))
			{
				return false;
			}
		}
		return true;
	}
}
