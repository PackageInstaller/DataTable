using System.Collections.Generic;

namespace UnityEngine.Localization.Metadata;

public interface IMetadataCollection
{
	IList<IMetadata> MetadataEntries { get; }

	TObject GetMetadata<TObject>() where TObject : IMetadata;

	void GetMetadatas<TObject>(IList<TObject> foundItems) where TObject : IMetadata;

	IList<TObject> GetMetadatas<TObject>() where TObject : IMetadata;

	void AddMetadata(IMetadata md);

	bool RemoveMetadata(IMetadata md);

	bool Contains(IMetadata md);
}
