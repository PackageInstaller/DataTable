using System;
using System.Collections.Generic;
using UnityEngine;

namespace YooAsset;

[Serializable]
internal class DebugPackageData
{
	public string PackageName;

	public List<DebugProviderInfo> ProviderInfos = new List<DebugProviderInfo>(1000);

	public List<DebugBundleInfo> BundleInfos = new List<DebugBundleInfo>(1000);

	public List<DebugOperationInfo> OperationInfos = new List<DebugOperationInfo>(1000);

	[NonSerialized]
	public Dictionary<string, DebugBundleInfo> BundleInfoDic = new Dictionary<string, DebugBundleInfo>();

	private bool _isParse;

	public DebugBundleInfo GetBundleInfo(string bundleName)
	{
		if (!_isParse)
		{
			_isParse = true;
			foreach (DebugBundleInfo bundleInfo in BundleInfos)
			{
				if (!BundleInfoDic.ContainsKey(bundleInfo.BundleName))
				{
					BundleInfoDic.Add(bundleInfo.BundleName, bundleInfo);
				}
			}
		}
		if (BundleInfoDic.TryGetValue(bundleName, out var value))
		{
			return value;
		}
		Debug.LogError("Can not found DebugBundleInfo : " + bundleName);
		return default;
	}
}
