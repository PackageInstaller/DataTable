using System;
using System.Collections.Generic;
using UnityEngine.Localization.Metadata;
using UnityEngine.Serialization;

namespace UnityEngine.Localization.Tables;

public abstract class LocalizationTable : ScriptableObject, IMetadataCollection, IComparable<LocalizationTable>
{
	[SerializeField]
	private LocaleIdentifier m_LocaleId;

	[HideInInspector]
	[SerializeField]
	[FormerlySerializedAs("m_KeyDatabase")]
	private SharedTableData m_SharedData;

	[SerializeField]
	private MetadataCollection m_Metadata = new MetadataCollection();

	[SerializeField]
	private List<TableEntryData> m_TableData = new List<TableEntryData>();

	public LocaleIdentifier LocaleIdentifier
	{
		get
		{
			return m_LocaleId;
		}
		set
		{
			m_LocaleId = value;
		}
	}

	public string TableCollectionName
	{
		get
		{
			VerifySharedTableDataIsNotNull();
			return SharedData.TableCollectionName;
		}
	}

	public SharedTableData SharedData
	{
		get
		{
			return m_SharedData;
		}
		set
		{
			m_SharedData = value;
		}
	}

	internal List<TableEntryData> TableData => m_TableData;

	public IList<IMetadata> MetadataEntries => m_Metadata.MetadataEntries;

	public TObject GetMetadata<TObject>() where TObject : IMetadata
	{
		return m_Metadata.GetMetadata<TObject>();
	}

	public void GetMetadatas<TObject>(IList<TObject> foundItems) where TObject : IMetadata
	{
		m_Metadata.GetMetadatas(foundItems);
	}

	public IList<TObject> GetMetadatas<TObject>() where TObject : IMetadata
	{
		return m_Metadata.GetMetadatas<TObject>();
	}

	public void AddMetadata(IMetadata md)
	{
		m_Metadata.AddMetadata(md);
	}

	public bool RemoveMetadata(IMetadata md)
	{
		return m_Metadata.RemoveMetadata(md);
	}

	public bool Contains(IMetadata md)
	{
		return m_Metadata.Contains(md);
	}

	public abstract void CreateEmpty(TableEntryReference entryReference);

	protected long FindKeyId(string key, bool addKey)
	{
		VerifySharedTableDataIsNotNull();
		return SharedData.GetId(key, addKey);
	}

	private void VerifySharedTableDataIsNotNull()
	{
		if (SharedData == null)
		{
			throw new NullReferenceException("The Table \"" + name + "\" does not have a SharedTableData.");
		}
	}

	public override string ToString()
	{
		return $"{TableCollectionName}({LocaleIdentifier})";
	}

	public int CompareTo(LocalizationTable other)
	{
		if (other == null)
		{
			return 1;
		}
		return LocaleIdentifier.CompareTo(other.LocaleIdentifier);
	}
}
