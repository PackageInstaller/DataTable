namespace Bamboo.AssetField;

public interface AssetID
{
	string GUID { get; }

	bool IsValid();
}
