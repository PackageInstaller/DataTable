namespace YooAsset;

internal interface IBundleQuery
{
	BundleInfo GetMainBundleInfo(AssetInfo assetInfo);

	BundleInfo[] GetDependBundleInfos(AssetInfo assetPath);

	string GetMainBundleName(int bundleID);

	string GetMainBundleName(AssetInfo assetInfo);

	string[] GetDependBundleNames(AssetInfo assetInfo);
}
