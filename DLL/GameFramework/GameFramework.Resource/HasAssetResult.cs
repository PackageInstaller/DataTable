namespace GameFramework.Resource;

public enum HasAssetResult : byte
{
	NotExist,
	AssetOnline,
	AssetOnDisk,
	AssetOnFileSystem,
	BinaryOnDisk,
	BinaryOnFileSystem,
	Valid
}
