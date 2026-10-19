using System;
using System.Collections.Generic;

namespace YooAsset;

[Serializable]
internal struct DebugBundleInfo : IComparer<DebugBundleInfo>, IComparable<DebugBundleInfo>
{
	public string BundleName;

	public int RefCount;

	public string Status;

	public List<string> ReferenceBundles;

	public int CompareTo(DebugBundleInfo other)
	{
		return Compare(this, other);
	}

	public int Compare(DebugBundleInfo a, DebugBundleInfo b)
	{
		return string.CompareOrdinal(a.BundleName, b.BundleName);
	}
}
