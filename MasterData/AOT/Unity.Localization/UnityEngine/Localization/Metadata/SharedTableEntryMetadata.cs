using System.Collections.Generic;
using UnityEngine.Localization.Tables;

namespace UnityEngine.Localization.Metadata;

public abstract class SharedTableEntryMetadata : IMetadata, ISerializationCallbackReceiver
{
	[SerializeField]
	private List<long> m_Entries = new List<long>();

	private HashSet<long> m_EntriesLookup = new HashSet<long>();

	internal int Count => m_EntriesLookup.Count;

	internal bool IsRegistered(TableEntry entry)
	{
		return m_EntriesLookup.Contains(entry.Data.Id);
	}

	internal void Register(TableEntry entry)
	{
		m_EntriesLookup.Add(entry.Data.Id);
	}

	internal void Unregister(TableEntry entry)
	{
		m_EntriesLookup.Remove(entry.Data.Id);
	}

	public void OnBeforeSerialize()
	{
		if (m_Entries == null)
		{
			m_Entries = new List<long>();
		}
		else
		{
			m_Entries.Clear();
		}
		m_Entries.AddRange(m_EntriesLookup);
	}

	public void OnAfterDeserialize()
	{
		if (m_EntriesLookup == null)
		{
			m_EntriesLookup = new HashSet<long>();
		}
		else
		{
			m_EntriesLookup.Clear();
		}
		foreach (long entry in m_Entries)
		{
			m_EntriesLookup.Add(entry);
		}
	}
}
