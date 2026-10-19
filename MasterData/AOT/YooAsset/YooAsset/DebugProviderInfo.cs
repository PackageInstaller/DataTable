using System;
using System.Collections.Generic;

namespace YooAsset;

[Serializable]
internal struct DebugProviderInfo : IComparer<DebugProviderInfo>, IComparable<DebugProviderInfo>
{
	public string AssetPath;

	public string SpawnScene;

	public string BeginTime;

	public long LoadingTime;

	public int RefCount;

	public string Status;

	public List<string> DependBundles;

	public string PackageName { get; set; }

	public int CompareTo(DebugProviderInfo other)
	{
		return Compare(this, other);
	}

	public int Compare(DebugProviderInfo a, DebugProviderInfo b)
	{
		return string.CompareOrdinal(a.AssetPath, b.AssetPath);
	}
}
