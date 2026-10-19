using System;
using System.Collections.Generic;
using UnityEngine.Localization.Metadata;
using UnityEngine.Serialization;

namespace UnityEngine.Localization.Tables;

public class SharedTableData : ScriptableObject, ISerializationCallbackReceiver
{
	[Serializable]
	public class SharedTableEntry
	{
		[SerializeField]
		private long m_Id;

		[SerializeField]
		private string m_Key;

		[SerializeField]
		private MetadataCollection m_Metadata = new MetadataCollection();

		public long Id
		{
			get
			{
				return m_Id;
			}
			internal set
			{
				m_Id = value;
			}
		}

		public string Key
		{
			get
			{
				return m_Key;
			}
			internal set
			{
				m_Key = value;
			}
		}

		public MetadataCollection Metadata
		{
			get
			{
				return m_Metadata;
			}
			set
			{
				m_Metadata = value;
			}
		}

		public override string ToString()
		{
			return $"{Id} - {Key}";
		}
	}

	public const long EmptyId = 0L;

	internal const string NewEntryKey = "New Entry";

	[FormerlySerializedAs("m_TableName")]
	[SerializeField]
	private string m_TableCollectionName;

	[FormerlySerializedAs("m_TableNameGuidString")]
	[SerializeField]
	private string m_TableCollectionNameGuidString;

	[SerializeField]
	private List<SharedTableEntry> m_Entries = new List<SharedTableEntry>();

	[SerializeField]
	[MetadataType(MetadataType.SharedTableData)]
	private MetadataCollection m_Metadata = new MetadataCollection();

	[SerializeReference]
	private IKeyGenerator m_KeyGenerator = new DistributedUIDGenerator();

	private Guid m_TableCollectionNameGuid;

	private Dictionary<long, SharedTableEntry> m_IdDictionary = new Dictionary<long, SharedTableEntry>();

	private Dictionary<string, SharedTableEntry> m_KeyDictionary = new Dictionary<string, SharedTableEntry>();

	public List<SharedTableEntry> Entries
	{
		get
		{
			return m_Entries;
		}
		set
		{
			m_Entries = value;
			m_IdDictionary.Clear();
			m_KeyDictionary.Clear();
		}
	}

	public string TableCollectionName
	{
		get
		{
			return m_TableCollectionName;
		}
		internal set
		{
			m_TableCollectionName = value;
		}
	}

	public Guid TableCollectionNameGuid
	{
		get
		{
			return m_TableCollectionNameGuid;
		}
		internal set
		{
			m_TableCollectionNameGuid = value;
		}
	}

	public MetadataCollection Metadata
	{
		get
		{
			return m_Metadata;
		}
		set
		{
			m_Metadata = value;
		}
	}

	public IKeyGenerator KeyGenerator
	{
		get
		{
			return m_KeyGenerator;
		}
		set
		{
			m_KeyGenerator = value;
		}
	}

	public void Clear()
	{
		m_Entries.Clear();
		m_IdDictionary.Clear();
		m_KeyDictionary.Clear();
	}

	public string GetKey(long id)
	{
		return FindWithId(id)?.Key;
	}

	public long GetId(string key)
	{
		return FindWithKey(key)?.Id ?? 0;
	}

	public long GetId(string key, bool addNewKey)
	{
		SharedTableEntry sharedTableEntry = FindWithKey(key);
		long result = 0L;
		if (sharedTableEntry != null)
		{
			result = sharedTableEntry.Id;
		}
		else if (addNewKey)
		{
			result = AddKeyInternal(key).Id;
		}
		return result;
	}

	public SharedTableEntry GetEntryFromReference(TableEntryReference tableEntryReference)
	{
		if (tableEntryReference.ReferenceType == TableEntryReference.Type.Name)
		{
			return GetEntry(tableEntryReference.Key);
		}
		return GetEntry(tableEntryReference.KeyId);
	}

	public SharedTableEntry GetEntry(long id)
	{
		return FindWithId(id);
	}

	public SharedTableEntry GetEntry(string key)
	{
		return FindWithKey(key);
	}

	public bool Contains(long id)
	{
		return FindWithId(id) != null;
	}

	public bool Contains(string key)
	{
		return FindWithKey(key) != null;
	}

	public SharedTableEntry AddKey(string key, long id)
	{
		if (Contains(id))
		{
			return null;
		}
		return AddKeyInternal(key, id);
	}

	public SharedTableEntry AddKey(string key = null)
	{
		string text = (string.IsNullOrEmpty(key) ? "New Entry" : key);
		SharedTableEntry sharedTableEntry = null;
		int num = 1;
		string key2 = text;
		while (sharedTableEntry == null)
		{
			if (Contains(key2))
			{
				key2 = $"{text} {num++}";
			}
			else
			{
				sharedTableEntry = AddKeyInternal(key2);
			}
		}
		return sharedTableEntry;
	}

	public void RemoveKey(long id)
	{
		SharedTableEntry sharedTableEntry = FindWithId(id);
		if (sharedTableEntry != null)
		{
			RemoveKeyInternal(sharedTableEntry);
		}
	}

	public void RemoveKey(string key)
	{
		SharedTableEntry sharedTableEntry = FindWithKey(key);
		if (sharedTableEntry != null)
		{
			RemoveKeyInternal(sharedTableEntry);
		}
	}

	public void RenameKey(long id, string newValue)
	{
		SharedTableEntry sharedTableEntry = FindWithId(id);
		if (sharedTableEntry != null)
		{
			RenameKeyInternal(sharedTableEntry, newValue);
		}
	}

	public void RenameKey(string oldValue, string newValue)
	{
		SharedTableEntry sharedTableEntry = FindWithKey(oldValue);
		if (sharedTableEntry != null)
		{
			RenameKeyInternal(sharedTableEntry, newValue);
		}
	}

	public bool RemapId(long currentId, long newId)
	{
		if (FindWithId(newId) != null)
		{
			return false;
		}
		SharedTableEntry sharedTableEntry = FindWithId(currentId);
		if (sharedTableEntry == null)
		{
			return false;
		}
		sharedTableEntry.Id = newId;
		m_IdDictionary.Remove(currentId);
		m_IdDictionary[newId] = sharedTableEntry;
		return true;
	}

	[Obsolete("FindSimilarKey will be removed in the future, please use Unity Search. See TableEntrySearchData class for further details.")]
	public SharedTableEntry FindSimilarKey(string text, out int distance)
	{
		SharedTableEntry result = null;
		distance = int.MaxValue;
		foreach (SharedTableEntry entry in Entries)
		{
			int num = ComputeLevenshteinDistance(text.ToLower(), entry.Key.ToLower());
			if (num < distance)
			{
				result = entry;
				distance = num;
			}
		}
		return result;
	}

	private static int ComputeLevenshteinDistance(string a, string b)
	{
		int length = a.Length;
		int length2 = b.Length;
		int[,] array = new int[length + 1, length2 + 1];
		if (length == 0)
		{
			return length2;
		}
		if (length2 == 0)
		{
			return length;
		}
		int num = 0;
		while (num <= length)
		{
			array[num, 0] = num++;
		}
		int num2 = 0;
		while (num2 <= length2)
		{
			array[0, num2] = num2++;
		}
		for (int i = 1; i <= length; i++)
		{
			for (int j = 1; j <= length2; j++)
			{
				int num3 = ((b[j - 1] != a[i - 1]) ? 1 : 0);
				array[i, j] = Mathf.Min(Mathf.Min(array[i - 1, j] + 1, array[i, j - 1] + 1), array[i - 1, j - 1] + num3);
			}
		}
		return array[length, length2];
	}

	private SharedTableEntry AddKeyInternal(string key)
	{
		SharedTableEntry sharedTableEntry = new SharedTableEntry
		{
			Id = m_KeyGenerator.GetNextKey(),
			Key = key
		};
		while (FindWithId(sharedTableEntry.Id) != null)
		{
			sharedTableEntry.Id = m_KeyGenerator.GetNextKey();
		}
		Entries.Add(sharedTableEntry);
		if (m_IdDictionary.Count > 0)
		{
			m_IdDictionary[sharedTableEntry.Id] = sharedTableEntry;
		}
		if (m_KeyDictionary.Count > 0)
		{
			m_KeyDictionary[key] = sharedTableEntry;
		}
		return sharedTableEntry;
	}

	private SharedTableEntry AddKeyInternal(string key, long id)
	{
		SharedTableEntry sharedTableEntry = new SharedTableEntry
		{
			Id = id,
			Key = key
		};
		Entries.Add(sharedTableEntry);
		if (m_IdDictionary.Count > 0)
		{
			m_IdDictionary[sharedTableEntry.Id] = sharedTableEntry;
		}
		if (m_KeyDictionary.Count > 0)
		{
			m_KeyDictionary[key] = sharedTableEntry;
		}
		return sharedTableEntry;
	}

	private void RenameKeyInternal(SharedTableEntry entry, string newValue)
	{
		if (m_KeyDictionary.Count > 0)
		{
			m_KeyDictionary.Remove(entry.Key);
			m_KeyDictionary[newValue] = entry;
		}
		entry.Key = newValue;
	}

	private void RemoveKeyInternal(SharedTableEntry entry)
	{
		if (m_KeyDictionary.Count > 0)
		{
			m_KeyDictionary.Remove(entry.Key);
		}
		if (m_IdDictionary.Count > 0)
		{
			m_IdDictionary.Remove(entry.Id);
		}
		Entries.Remove(entry);
	}

	private SharedTableEntry FindWithId(long id)
	{
		if (id == 0L)
		{
			return null;
		}
		if (m_IdDictionary.Count == 0)
		{
			foreach (SharedTableEntry entry in m_Entries)
			{
				m_IdDictionary[entry.Id] = entry;
			}
		}
		m_IdDictionary.TryGetValue(id, out var value);
		return value;
	}

	private SharedTableEntry FindWithKey(string key)
	{
		if (m_KeyDictionary.Count == 0)
		{
			foreach (SharedTableEntry entry in m_Entries)
			{
				m_KeyDictionary[entry.Key] = entry;
			}
		}
		m_KeyDictionary.TryGetValue(key, out var value);
		return value;
	}

	public override string ToString()
	{
		return TableCollectionName + "(Shared Table Data)";
	}

	public void OnBeforeSerialize()
	{
		m_TableCollectionNameGuidString = TableReference.StringFromGuid(m_TableCollectionNameGuid);
	}

	public void OnAfterDeserialize()
	{
		m_IdDictionary.Clear();
		m_KeyDictionary.Clear();
		m_TableCollectionNameGuid = (string.IsNullOrEmpty(m_TableCollectionNameGuidString) ? Guid.Empty : Guid.Parse(m_TableCollectionNameGuidString));
	}
}
