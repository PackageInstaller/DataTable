using System;
using System.Collections.Generic;
using System.Linq;

namespace UnityEngine.Localization.Metadata;

[Serializable]
public abstract class SharedTableCollectionMetadata : IMetadata, ISerializationCallbackReceiver
{
	[Serializable]
	private class Item
	{
		[SerializeField]
		private long m_KeyId;

		[SerializeField]
		private List<string> m_TableCodes = new List<string>();

		public long KeyId
		{
			get
			{
				return m_KeyId;
			}
			set
			{
				m_KeyId = value;
			}
		}

		public List<string> Tables
		{
			get
			{
				return m_TableCodes;
			}
			set
			{
				m_TableCodes = value;
			}
		}
	}

	[HideInInspector]
	[SerializeField]
	private List<Item> m_Entries = new List<Item>();

	public Dictionary<long, HashSet<string>> EntriesLookup { get; set; } = new Dictionary<long, HashSet<string>>();

	public bool IsEmpty => EntriesLookup.Count == 0;

	public bool Contains(long keyId)
	{
		return EntriesLookup.ContainsKey(keyId);
	}

	public bool Contains(long keyId, string code)
	{
		if (EntriesLookup.TryGetValue(keyId, out var value))
		{
			return value.Contains(code);
		}
		return false;
	}

	public void AddEntry(long keyId, string code)
	{
		EntriesLookup.TryGetValue(keyId, out var value);
		if (value == null)
		{
			value = new HashSet<string>();
			EntriesLookup[keyId] = value;
		}
		value.Add(code);
	}

	public void RemoveEntry(long keyId, string code)
	{
		if (EntriesLookup.TryGetValue(keyId, out var value))
		{
			value.Remove(code);
			if (value.Count == 0)
			{
				EntriesLookup.Remove(keyId);
			}
		}
	}

	public virtual void OnBeforeSerialize()
	{
		m_Entries.Clear();
		foreach (KeyValuePair<long, HashSet<string>> item in EntriesLookup)
		{
			m_Entries.Add(new Item
			{
				KeyId = item.Key,
				Tables = item.Value.ToList()
			});
		}
	}

	public virtual void OnAfterDeserialize()
	{
		EntriesLookup = new Dictionary<long, HashSet<string>>();
		foreach (Item entry in m_Entries)
		{
			EntriesLookup[entry.KeyId] = new HashSet<string>(entry.Tables);
		}
	}
}
