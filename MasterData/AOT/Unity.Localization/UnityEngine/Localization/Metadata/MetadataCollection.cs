using System;
using System.Collections.Generic;

namespace UnityEngine.Localization.Metadata;

[Serializable]
public class MetadataCollection : IMetadataCollection
{
	[SerializeReference]
	private List<IMetadata> m_Items = new List<IMetadata>();

	public IList<IMetadata> MetadataEntries => m_Items;

	public bool HasData
	{
		get
		{
			if (MetadataEntries != null)
			{
				return MetadataEntries.Count > 0;
			}
			return false;
		}
	}

	public bool HasMetadata<TObject>() where TObject : IMetadata
	{
		return GetMetadata<TObject>() != null;
	}

	public TObject GetMetadata<TObject>() where TObject : IMetadata
	{
		foreach (IMetadata item in m_Items)
		{
			if (item is TObject)
			{
				return (TObject)item;
			}
		}
		return default;
	}

	public void GetMetadatas<TObject>(IList<TObject> foundItems) where TObject : IMetadata
	{
		foundItems.Clear();
		foreach (IMetadata item2 in m_Items)
		{
			if (item2 is TObject item)
			{
				foundItems.Add(item);
			}
		}
	}

	public IList<TObject> GetMetadatas<TObject>() where TObject : IMetadata
	{
		List<TObject> list = new List<TObject>();
		GetMetadatas(list);
		return list;
	}

	public void AddMetadata(IMetadata md)
	{
		MetadataEntries.Add(md);
	}

	public bool RemoveMetadata(IMetadata md)
	{
		return m_Items.Remove(md);
	}

	public bool Contains(IMetadata md)
	{
		return m_Items.Contains(md);
	}
}
