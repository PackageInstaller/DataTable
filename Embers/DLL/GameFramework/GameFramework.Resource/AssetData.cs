using System;

namespace GameFramework.Resource;

public readonly struct AssetData
{
	public readonly string PackageName;

	public readonly Type AssetType;

	public readonly string Error;

	public readonly string Address;

	public readonly string AssetPath;

	internal AssetData(string packageName, string assetPath, string address, Type assetType)
	{
		PackageName = packageName;
		AssetPath = assetPath;
		Address = address;
		AssetType = assetType;
		Error = string.Empty;
	}

	internal AssetData(string packageName, string error)
	{
		PackageName = packageName;
		Error = error;
		AssetType = null;
		Address = string.Empty;
		AssetPath = string.Empty;
	}
}
