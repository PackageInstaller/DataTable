using System;
using System.Linq;

namespace YooAsset;

[Serializable]
internal class PackageAsset
{
	public string Address;

	public string AssetPath;

	public string AssetGUID;

	public string[] AssetTags;

	public int BundleID;

	public int[] DependBundleIDs;

	[NonSerialized]
	public object TempDataInEditor;

	public bool HasTag(string[] tags)
	{
		if (tags == null || tags.Length == 0)
		{
			return false;
		}
		if (AssetTags == null || AssetTags.Length == 0)
		{
			return false;
		}
		foreach (string value in tags)
		{
			if (AssetTags.Contains(value))
			{
				return true;
			}
		}
		return false;
	}

	public bool HasAllTags(string[] tags)
	{
		if (tags == null || tags.Length == 0)
		{
			return false;
		}
		if (AssetTags == null || AssetTags.Length == 0)
		{
			return false;
		}
		foreach (string value in tags)
		{
			if (!AssetTags.Contains(value))
			{
				return false;
			}
		}
		return true;
	}
}
