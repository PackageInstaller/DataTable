using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;

namespace YooAsset;

[Serializable]
internal class PackageManifest
{
	public string FileVersion;

	public bool EnableAddressable;

	public bool LocationToLower;

	public bool IncludeAssetGUID;

	public int OutputNameStyle;

	public int BuildBundleType;

	public string BuildPipeline;

	public string PackageName;

	public string PackageVersion;

	public string PackageNote;

	public List<PackageAsset> AssetList = new List<PackageAsset>();

	public List<PackageBundle> BundleList = new List<PackageBundle>();

	[NonSerialized]
	public Dictionary<string, PackageAsset> AssetDic;

	[NonSerialized]
	public Dictionary<string, string> AssetPathMapping1;

	[NonSerialized]
	public Dictionary<string, string> AssetPathMapping2;

	[NonSerialized]
	public Dictionary<string, PackageBundle> BundleDic1;

	[NonSerialized]
	public Dictionary<string, PackageBundle> BundleDic2;

	[NonSerialized]
	public Dictionary<string, PackageBundle> BundleDic3;

	public PackageDetails GetPackageDetails()
	{
		return new PackageDetails
		{
			FileVersion = FileVersion,
			EnableAddressable = EnableAddressable,
			LocationToLower = LocationToLower,
			IncludeAssetGUID = IncludeAssetGUID,
			OutputNameStyle = OutputNameStyle,
			BuildBundleType = BuildBundleType,
			BuildPipeline = BuildPipeline,
			PackageName = PackageName,
			PackageVersion = PackageVersion,
			PackageNote = PackageNote,
			AssetTotalCount = AssetList.Count,
			BundleTotalCount = BundleList.Count
		};
	}

	public string TryMappingToAssetPath(string location)
	{
		if (string.IsNullOrEmpty(location))
		{
			return string.Empty;
		}
		if (AssetPathMapping1.TryGetValue(location, out var value))
		{
			return value;
		}
		return string.Empty;
	}

	public string TryMappingGUIDToAssetPath(string guid)
	{
		if (string.IsNullOrEmpty(guid))
		{
			return string.Empty;
		}
		if (AssetPathMapping2.TryGetValue(guid, out var value))
		{
			return value;
		}
		return string.Empty;
	}

	public PackageBundle GetMainPackageBundle(int bundleID)
	{
		if (bundleID >= 0 && bundleID < BundleList.Count)
		{
			return BundleList[bundleID];
		}
		throw new Exception($"Invalid bundle id : {bundleID}");
	}

	public PackageBundle GetMainPackageBundle(PackageAsset packageAsset)
	{
		return GetMainPackageBundle(packageAsset.BundleID);
	}

	public PackageBundle[] GetAllDependencies(PackageAsset packageAsset)
	{
		List<PackageBundle> list = new List<PackageBundle>(packageAsset.DependBundleIDs.Length);
		int[] dependBundleIDs = packageAsset.DependBundleIDs;
		foreach (int bundleID in dependBundleIDs)
		{
			PackageBundle mainPackageBundle = GetMainPackageBundle(bundleID);
			list.Add(mainPackageBundle);
		}
		return list.ToArray();
	}

	public PackageBundle[] GetAllDependencies(PackageBundle packageBundle)
	{
		List<PackageBundle> list = new List<PackageBundle>(packageBundle.DependBundleIDs.Length);
		int[] dependBundleIDs = packageBundle.DependBundleIDs;
		foreach (int bundleID in dependBundleIDs)
		{
			PackageBundle mainPackageBundle = GetMainPackageBundle(bundleID);
			list.Add(mainPackageBundle);
		}
		return list.ToArray();
	}

	public bool TryGetPackageAsset(string assetPath, out PackageAsset result)
	{
		return AssetDic.TryGetValue(assetPath, out result);
	}

	public bool TryGetPackageBundleByBundleName(string bundleName, out PackageBundle result)
	{
		return BundleDic1.TryGetValue(bundleName, out result);
	}

	public bool TryGetPackageBundleByFileName(string fileName, out PackageBundle result)
	{
		return BundleDic2.TryGetValue(fileName, out result);
	}

	public bool TryGetPackageBundleByBundleGUID(string bundleGUID, out PackageBundle result)
	{
		return BundleDic3.TryGetValue(bundleGUID, out result);
	}

	public bool IsIncludeBundleFile(string bundleGUID)
	{
		return BundleDic3.ContainsKey(bundleGUID);
	}

	public AssetInfo[] GetAllAssetInfos()
	{
		List<AssetInfo> list = new List<AssetInfo>(AssetList.Count);
		foreach (PackageAsset asset in AssetList)
		{
			AssetInfo item = new AssetInfo(PackageName, asset, null);
			list.Add(item);
		}
		return list.ToArray();
	}

	public AssetInfo[] GetAssetInfosByTags(string[] tags)
	{
		List<AssetInfo> list = new List<AssetInfo>(100);
		foreach (PackageAsset asset in AssetList)
		{
			if (asset.HasTag(tags))
			{
				AssetInfo item = new AssetInfo(PackageName, asset, null);
				list.Add(item);
			}
		}
		return list.ToArray();
	}

	public AssetInfo[] GetAssetInfosByAllTags(string[] tags)
	{
		List<AssetInfo> list = new List<AssetInfo>(100);
		foreach (PackageAsset asset in AssetList)
		{
			if (asset.HasAllTags(tags))
			{
				AssetInfo item = new AssetInfo(PackageName, asset, null);
				list.Add(item);
			}
		}
		return list.ToArray();
	}

	public AssetInfo ConvertLocationToAssetInfo(string location, Type assetType)
	{
		string assetPath = ConvertLocationToAssetInfoMapping(location);
		if (TryGetPackageAsset(assetPath, out var result))
		{
			return new AssetInfo(PackageName, result, assetType);
		}
		return new AssetInfo(error: (!string.IsNullOrEmpty(location)) ? ("The location is invalid : " + location) : "The location is null or empty !", packageName: PackageName);
	}

	private string ConvertLocationToAssetInfoMapping(string location)
	{
		if (string.IsNullOrEmpty(location))
		{
			YooLogger.Error("Failed to mapping location to asset path, The location is null or empty.");
			return string.Empty;
		}
		if (AssetPathMapping1.TryGetValue(location, out var value))
		{
			return value;
		}
		YooLogger.Warning("Failed to mapping location to asset path : " + location);
		return string.Empty;
	}

	public AssetInfo ConvertAssetGUIDToAssetInfo(string assetGUID, Type assetType)
	{
		if (!IncludeAssetGUID)
		{
			YooLogger.Warning("Package manifest not include asset guid ! Please check asset bundle collector settings.");
			return new AssetInfo(PackageName, "AssetGUID data is empty !");
		}
		string assetPath = ConvertAssetGUIDToAssetInfoMapping(assetGUID);
		if (TryGetPackageAsset(assetPath, out var result))
		{
			return new AssetInfo(PackageName, result, assetType);
		}
		return new AssetInfo(error: (!string.IsNullOrEmpty(assetGUID)) ? ("The assetGUID is invalid : " + assetGUID) : "The assetGUID is null or empty !", packageName: PackageName);
	}

	private string ConvertAssetGUIDToAssetInfoMapping(string assetGUID)
	{
		if (string.IsNullOrEmpty(assetGUID))
		{
			YooLogger.Error("Failed to mapping assetGUID to asset path, The assetGUID is null or empty.");
			return string.Empty;
		}
		if (AssetPathMapping2.TryGetValue(assetGUID, out var value))
		{
			return value;
		}
		YooLogger.Warning("Failed to mapping assetGUID to asset path : " + assetGUID);
		return string.Empty;
	}

	[Conditional("DEBUG")]
	private void DebugCheckLocation(string location)
	{
		if (!string.IsNullOrEmpty(location))
		{
			int num = location.LastIndexOf(' ');
			if (num != -1 && location.Length == num + 1)
			{
				YooLogger.Warning("Found blank character in location : \"" + location + "\"");
			}
			if (location.IndexOfAny(Path.GetInvalidPathChars()) >= 0)
			{
				YooLogger.Warning("Found illegal character in location : \"" + location + "\"");
			}
		}
	}
}
