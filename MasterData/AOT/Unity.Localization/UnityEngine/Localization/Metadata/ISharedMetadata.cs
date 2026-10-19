namespace UnityEngine.Localization.Metadata;

[HideInInspector]
public interface ISharedMetadata : IMetadata
{
	bool Contains(long keyId);

	void AddEntry(long keyId);

	void RemoveEntry(long keyId);
}
