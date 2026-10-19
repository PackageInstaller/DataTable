using System.Collections.Generic;
using UnityEngine.Localization.Metadata;

namespace UnityEngine.Localization.Tables;

public class TableEntry : IMetadataCollection
{
	private SharedTableData.SharedTableEntry m_SharedTableEntry;

	public LocalizationTable Table { get; internal set; }

	internal TableEntryData Data { get; set; }

	public SharedTableData.SharedTableEntry SharedEntry
	{
		get
		{
			if (m_SharedTableEntry == null)
			{
				m_SharedTableEntry = Table.SharedData.GetEntry(KeyId);
			}
			return m_SharedTableEntry;
		}
	}

	public string Key
	{
		get
		{
			return SharedEntry?.Key;
		}
		set
		{
			Table.SharedData.RenameKey(KeyId, value);
		}
	}

	public long KeyId => Data.Id;

	public string LocalizedValue => Data.Localized;

	public IList<IMetadata> MetadataEntries => Data.Metadata.MetadataEntries;

	public TObject GetMetadata<TObject>() where TObject : IMetadata
	{
		return Data.Metadata.GetMetadata<TObject>();
	}

	public void GetMetadatas<TObject>(IList<TObject> foundItems) where TObject : IMetadata
	{
		Data.Metadata.GetMetadatas(foundItems);
	}

	public IList<TObject> GetMetadatas<TObject>() where TObject : IMetadata
	{
		return Data.Metadata.GetMetadatas<TObject>();
	}

	public bool HasTagMetadata<TShared>() where TShared : SharedTableEntryMetadata
	{
		TShared metadata = Table.GetMetadata<TShared>();
		if (metadata != null && metadata.IsRegistered(this))
		{
			return true;
		}
		return false;
	}

	public void AddTagMetadata<TShared>() where TShared : SharedTableEntryMetadata, new()
	{
		TShared val = null;
		foreach (IMetadata metadataEntry in Table.MetadataEntries)
		{
			if (metadataEntry is TShared val2)
			{
				val = val2;
				break;
			}
		}
		if (val == null)
		{
			val = new TShared();
			Table.AddMetadata(val);
		}
		val.Register(this);
		AddMetadata(val);
	}

	public void AddSharedMetadata(SharedTableEntryMetadata md)
	{
		if (!Table.Contains(md))
		{
			Table.AddMetadata(md);
		}
		md.Register(this);
		AddMetadata(md);
	}

	public void AddSharedMetadata(SharedTableCollectionMetadata md)
	{
		if (!Table.SharedData.Metadata.Contains(md))
		{
			Table.SharedData.Metadata.AddMetadata(md);
		}
		md.AddEntry(Data.Id, Table.LocaleIdentifier.Code);
	}

	public void AddMetadata(IMetadata md)
	{
		Data.Metadata.AddMetadata(md);
	}

	public void RemoveTagMetadata<TShared>() where TShared : SharedTableEntryMetadata
	{
		IList<IMetadata> metadataEntries = Table.MetadataEntries;
		IList<IMetadata> metadataEntries2 = Data.Metadata.MetadataEntries;
		for (int i = 0; i < metadataEntries.Count; i++)
		{
			if (metadataEntries[i] is TShared val)
			{
				val.Unregister(this);
				metadataEntries2.Remove(val);
				if (val.Count == 0)
				{
					metadataEntries.RemoveAt(i);
					i--;
				}
			}
		}
	}

	public void RemoveSharedMetadata(SharedTableEntryMetadata md)
	{
		md.Unregister(this);
		RemoveMetadata(md);
		if (md.Count == 0 && Table.Contains(md))
		{
			Table.RemoveMetadata(md);
		}
	}

	public void RemoveSharedMetadata(SharedTableCollectionMetadata md)
	{
		md.RemoveEntry(Data.Id, Table.LocaleIdentifier.Code);
		if (md.IsEmpty)
		{
			Table.SharedData.Metadata.RemoveMetadata(md);
		}
	}

	public bool RemoveMetadata(IMetadata md)
	{
		return Data.Metadata.RemoveMetadata(md);
	}

	public bool Contains(IMetadata md)
	{
		return Data.Metadata.Contains(md);
	}

	public override string ToString()
	{
		return $"{KeyId} - {LocalizedValue}";
	}
}
