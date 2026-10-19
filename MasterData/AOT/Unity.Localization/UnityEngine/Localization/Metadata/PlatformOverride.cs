using System;
using System.Collections.Generic;
using UnityEngine.Localization.Tables;

namespace UnityEngine.Localization.Metadata;

[Serializable]
[Metadata(AllowedTypes = (MetadataType.AllTableEntries | MetadataType.AllSharedTableEntries), AllowMultiple = false)]
public class PlatformOverride : IEntryOverride, IMetadata, ISerializationCallbackReceiver
{
	[Serializable]
	private class PlatformOverrideData
	{
		public RuntimePlatform platform;

		public EntryOverrideType entryOverrideType;

		public TableReference tableReference;

		public TableEntryReference tableEntryReference;

		public override string ToString()
		{
			return entryOverrideType switch
			{
				EntryOverrideType.Table => $"{platform}: {tableReference}", 
				EntryOverrideType.Entry => $"{platform}: {tableEntryReference}", 
				EntryOverrideType.TableAndEntry => $"{platform}: {tableReference}/{tableEntryReference}", 
				_ => $"{platform}: None", 
			};
		}
	}

	[SerializeField]
	private List<PlatformOverrideData> m_PlatformOverrides = new List<PlatformOverrideData>();

	private PlatformOverrideData m_PlayerPlatformOverride;

	public void AddPlatformTableOverride(RuntimePlatform platform, TableReference table)
	{
		AddPlatformOverride(platform, table, default, EntryOverrideType.Table);
	}

	public void AddPlatformEntryOverride(RuntimePlatform platform, TableEntryReference entry)
	{
		AddPlatformOverride(platform, default, entry, EntryOverrideType.Entry);
	}

	public void AddPlatformOverride(RuntimePlatform platform, TableReference table, TableEntryReference entry, EntryOverrideType entryOverrideType = EntryOverrideType.TableAndEntry)
	{
		PlatformOverrideData platformOverrideData = null;
		for (int i = 0; i < m_PlatformOverrides.Count; i++)
		{
			if (m_PlatformOverrides[i].platform == platform)
			{
				platformOverrideData = m_PlatformOverrides[i];
				break;
			}
		}
		if (platformOverrideData == null)
		{
			platformOverrideData = new PlatformOverrideData
			{
				platform = platform
			};
			m_PlatformOverrides.Add(platformOverrideData);
		}
		platformOverrideData.entryOverrideType = entryOverrideType;
		platformOverrideData.tableReference = table;
		platformOverrideData.tableEntryReference = entry;
	}

	public bool RemovePlatformOverride(RuntimePlatform platform)
	{
		for (int i = 0; i < m_PlatformOverrides.Count; i++)
		{
			if (m_PlatformOverrides[i].platform == platform)
			{
				m_PlatformOverrides.RemoveAt(i);
				return true;
			}
		}
		return false;
	}

	public EntryOverrideType GetOverride(out TableReference tableReference, out TableEntryReference tableEntryReference)
	{
		if (m_PlayerPlatformOverride == null)
		{
			tableReference = default;
			tableEntryReference = default;
			return EntryOverrideType.None;
		}
		tableReference = m_PlayerPlatformOverride.tableReference;
		tableEntryReference = m_PlayerPlatformOverride.tableEntryReference;
		return m_PlayerPlatformOverride.entryOverrideType;
	}

	public EntryOverrideType GetOverride(out TableReference tableReference, out TableEntryReference tableEntryReference, RuntimePlatform platform)
	{
		for (int i = 0; i < m_PlatformOverrides.Count; i++)
		{
			if (m_PlatformOverrides[i].platform == platform)
			{
				PlatformOverrideData platformOverrideData = m_PlatformOverrides[i];
				tableReference = platformOverrideData.tableReference;
				tableEntryReference = platformOverrideData.tableEntryReference;
				return platformOverrideData.entryOverrideType;
			}
		}
		tableReference = default;
		tableEntryReference = default;
		return EntryOverrideType.None;
	}

	public void OnBeforeSerialize()
	{
	}

	public void OnAfterDeserialize()
	{
		for (int i = 0; i < m_PlatformOverrides.Count; i++)
		{
			if (m_PlatformOverrides[i].platform == Application.platform)
			{
				m_PlayerPlatformOverride = m_PlatformOverrides[i];
				break;
			}
		}
	}
}
