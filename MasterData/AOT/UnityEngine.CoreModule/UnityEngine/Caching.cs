using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/Misc/CachingManager.h")]
[StaticAccessor("GetCachingManager()", StaticAccessorType.Dot)]
public sealed class Caching
{
	public static bool ClearCachedVersion(string assetBundleName, Hash128 hash)
	{
		if (string.IsNullOrEmpty(assetBundleName))
		{
			throw new ArgumentException("Input AssetBundle name cannot be null or empty.");
		}
		return ClearCachedVersionInternal(assetBundleName, hash);
	}

	[NativeName("ClearCachedVersion")]
	internal static bool ClearCachedVersionInternal(string assetBundleName, Hash128 hash)
	{
		return ClearCachedVersionInternal_Injected(assetBundleName, ref hash);
	}

	public static bool ClearOtherCachedVersions(string assetBundleName, Hash128 hash)
	{
		if (string.IsNullOrEmpty(assetBundleName))
		{
			throw new ArgumentException("Input AssetBundle name cannot be null or empty.");
		}
		return ClearCachedVersions(assetBundleName, hash, keepInputVersion: true);
	}

	internal static bool ClearCachedVersions(string assetBundleName, Hash128 hash, bool keepInputVersion)
	{
		return ClearCachedVersions_Injected(assetBundleName, ref hash, keepInputVersion);
	}

	public static bool IsVersionCached(CachedAssetBundle cachedBundle)
	{
		if (string.IsNullOrEmpty(cachedBundle.name))
		{
			throw new ArgumentException("Input AssetBundle name cannot be null or empty.");
		}
		return IsVersionCached("", cachedBundle.name, cachedBundle.hash);
	}

	[NativeName("IsCached")]
	internal static bool IsVersionCached(string url, string assetBundleName, Hash128 hash)
	{
		return IsVersionCached_Injected(url, assetBundleName, ref hash);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool ClearCachedVersionInternal_Injected(string assetBundleName, ref Hash128 hash);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool ClearCachedVersions_Injected(string assetBundleName, ref Hash128 hash, bool keepInputVersion);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool IsVersionCached_Injected(string url, string assetBundleName, ref Hash128 hash);
}
