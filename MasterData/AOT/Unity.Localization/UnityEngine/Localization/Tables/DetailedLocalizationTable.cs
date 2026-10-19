using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

namespace UnityEngine.Localization.Tables;

public abstract class DetailedLocalizationTable<TEntry> : LocalizationTable, IDictionary<long, TEntry>, ICollection<KeyValuePair<long, TEntry>>, IEnumerable<KeyValuePair<long, TEntry>>, IEnumerable, ISerializationCallbackReceiver where TEntry : TableEntry
{
	private Dictionary<long, TEntry> m_TableEntries = new Dictionary<long, TEntry>();

	ICollection<long> IDictionary<long, TEntry>.Keys => m_TableEntries.Keys;

	public ICollection<TEntry> Values => m_TableEntries.Values;

	public int Count => m_TableEntries.Count;

	public bool IsReadOnly => false;

	public TEntry this[long key]
	{
		get
		{
			return m_TableEntries[key];
		}
		set
		{
			if (key == 0L)
			{
				throw new ArgumentException("Key Id value 0, is not valid. All Key Id's must be non-zero.");
			}
			if (value.Table != this)
			{
				throw new ArgumentException("Table entry does not belong to this table. Table entries can not be shared across tables.");
			}
			RemoveEntry(value.Data.Id);
			value.Data.Id = key;
			m_TableEntries[key] = value;
		}
	}

	public TEntry this[string keyName]
	{
		get
		{
			return GetEntry(keyName);
		}
		set
		{
			if (value.Table != this)
			{
				throw new ArgumentException("Table entry does not belong to this table. Table entries can not be shared across tables.");
			}
			long key = FindKeyId(keyName, addKey: true);
			this[key] = value;
		}
	}

	public abstract TEntry CreateTableEntry();

	internal TEntry CreateTableEntry(TableEntryData data)
	{
		TEntry val = CreateTableEntry();
		val.Data = data;
		return val;
	}

	public override void CreateEmpty(TableEntryReference entryReference)
	{
		AddEntryFromReference(entryReference, string.Empty);
	}

	public TEntry AddEntry(string key, string localized)
	{
		long num = FindKeyId(key, addKey: true);
		if (num != 0L)
		{
			return AddEntry(num, localized);
		}
		return null;
	}

	public virtual TEntry AddEntry(long keyId, string localized)
	{
		if (keyId == 0L)
		{
			throw new ArgumentException(string.Format("Key Id value {0}({1}), is not valid. All Key Id's must be non-zero.", "EmptyId", 0L), "keyId");
		}
		if (!m_TableEntries.TryGetValue(keyId, out var value))
		{
			value = CreateTableEntry();
			value.Data = new TableEntryData(keyId);
			m_TableEntries[keyId] = value;
		}
		value.Data.Localized = localized;
		return value;
	}

	public TEntry AddEntryFromReference(TableEntryReference entryReference, string localized)
	{
		if (entryReference.ReferenceType == TableEntryReference.Type.Id)
		{
			return AddEntry(entryReference.KeyId, localized);
		}
		if (entryReference.ReferenceType == TableEntryReference.Type.Name)
		{
			return AddEntry(entryReference.Key, localized);
		}
		throw new ArgumentException("TableEntryReference should not be Empty", "entryReference");
	}

	public bool RemoveEntry(string key)
	{
		long num = FindKeyId(key, addKey: false);
		if (num != 0L)
		{
			return RemoveEntry(num);
		}
		return false;
	}

	public virtual bool RemoveEntry(long keyId)
	{
		if (m_TableEntries.TryGetValue(keyId, out var value))
		{
			value.Data.Id = 0L;
			value.Table = null;
			return m_TableEntries.Remove(keyId);
		}
		return false;
	}

	public TEntry GetEntryFromReference(TableEntryReference entryReference)
	{
		if (entryReference.ReferenceType == TableEntryReference.Type.Id)
		{
			return GetEntry(entryReference.KeyId);
		}
		if (entryReference.ReferenceType == TableEntryReference.Type.Name)
		{
			return GetEntry(entryReference.Key);
		}
		return null;
	}

	public TEntry GetEntry(string key)
	{
		long num = FindKeyId(key, addKey: false);
		if (num != 0L)
		{
			return GetEntry(num);
		}
		return null;
	}

	public virtual TEntry GetEntry(long keyId)
	{
		m_TableEntries.TryGetValue(keyId, out var value);
		return value;
	}

	public void Add(long keyId, TEntry value)
	{
		this[keyId] = value;
	}

	public void Add(KeyValuePair<long, TEntry> item)
	{
		this[item.Key] = item.Value;
	}

	public bool ContainsKey(long keyId)
	{
		return m_TableEntries.ContainsKey(keyId);
	}

	public bool ContainsValue(string localized)
	{
		foreach (TEntry value in m_TableEntries.Values)
		{
			if (value.Data.Localized == localized)
			{
				return true;
			}
		}
		return false;
	}

	public bool Contains(KeyValuePair<long, TEntry> item)
	{
		return m_TableEntries.Contains(item);
	}

	public bool Remove(long keyId)
	{
		return RemoveEntry(keyId);
	}

	public bool Remove(KeyValuePair<long, TEntry> item)
	{
		if (Contains(item))
		{
			RemoveEntry(item.Key);
			return true;
		}
		return false;
	}

	public IList<TEntry> CheckForMissingSharedTableDataEntries(MissingEntryAction action = MissingEntryAction.Nothing)
	{
		TEntry[] array = (from e in m_TableEntries
			where !SharedData.Contains(e.Key)
			select e.Value).ToArray();
		if (array.Length == 0)
		{
			return array;
		}
		switch (action)
		{
		case MissingEntryAction.AddEntriesToSharedData:
		{
			for (int num2 = 0; num2 < array.Length; num2++)
			{
				SharedTableData.SharedTableEntry sharedTableEntry = SharedData.AddKey();
				SharedData.RemapId(sharedTableEntry.Id, array[num2].KeyId);
			}
			break;
		}
		case MissingEntryAction.RemoveEntriesFromTable:
		{
			for (int num = 0; num < array.Length; num++)
			{
				RemoveEntry(array[num].KeyId);
			}
			break;
		}
		}
		return array;
	}

	public bool TryGetValue(long keyId, out TEntry value)
	{
		return m_TableEntries.TryGetValue(keyId, out value);
	}

	public void Clear()
	{
		TableData.Clear();
		m_TableEntries.Clear();
	}

	public void CopyTo(KeyValuePair<long, TEntry>[] array, int arrayIndex)
	{
		foreach (KeyValuePair<long, TEntry> tableEntry in m_TableEntries)
		{
			array[arrayIndex++] = tableEntry;
		}
	}

	public IEnumerator<KeyValuePair<long, TEntry>> GetEnumerator()
	{
		return m_TableEntries.GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return m_TableEntries.GetEnumerator();
	}

	public override string ToString()
	{
		return $"{TableCollectionName}({LocaleIdentifier})";
	}

	public void OnBeforeSerialize()
	{
		TableData.Clear();
		using IEnumerator<KeyValuePair<long, TEntry>> enumerator = GetEnumerator();
		while (enumerator.MoveNext())
		{
			KeyValuePair<long, TEntry> current = enumerator.Current;
			current.Value.Data.Id = current.Key;
			TableData.Add(current.Value.Data);
		}
	}

	public void OnAfterDeserialize()
	{
		try
		{
			m_TableEntries = TableData.ToDictionary((TableEntryData o) => o.Id, CreateTableEntry);
		}
		catch (Exception ex)
		{
			Debug.LogError($"Error Deserializing Table Data \"{TableCollectionName}({LocaleIdentifier})\".\n{ex.Message}\n{ex.InnerException}", this);
		}
	}
}
