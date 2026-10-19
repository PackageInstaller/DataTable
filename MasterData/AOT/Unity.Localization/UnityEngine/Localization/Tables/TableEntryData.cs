using System;
using UnityEngine.Localization.Metadata;

namespace UnityEngine.Localization.Tables;

[Serializable]
internal class TableEntryData
{
	[SerializeField]
	private long m_Id;

	[SerializeField]
	private string m_Localized;

	[SerializeField]
	private MetadataCollection m_Metadata = new MetadataCollection();

	public long Id
	{
		get
		{
			return m_Id;
		}
		set
		{
			m_Id = value;
		}
	}

	public string Localized
	{
		get
		{
			return m_Localized;
		}
		set
		{
			m_Localized = value;
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

	public TableEntryData()
	{
	}

	public TableEntryData(long id)
	{
		Id = id;
	}

	public TableEntryData(long id, string localized)
		: this(id)
	{
		Localized = localized;
	}
}
