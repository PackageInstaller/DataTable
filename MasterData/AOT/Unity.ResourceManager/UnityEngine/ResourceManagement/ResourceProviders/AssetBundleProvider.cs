using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using UnityEngine.ResourceManagement.ResourceLocations;
using UnityEngine.ResourceManagement.Util;

namespace UnityEngine.ResourceManagement.ResourceProviders;

[DisplayName("AssetBundle Provider")]
public class AssetBundleProvider : ResourceProviderBase
{
	internal static Dictionary<string, AssetBundleUnloadOperation> m_UnloadingBundles = new Dictionary<string, AssetBundleUnloadOperation>();

	protected internal static Dictionary<string, AssetBundleUnloadOperation> UnloadingBundles
	{
		get
		{
			return m_UnloadingBundles;
		}
		internal set
		{
			m_UnloadingBundles = value;
		}
	}

	internal static int UnloadingAssetBundleCount => m_UnloadingBundles.Count;

	internal static int AssetBundleCount => AssetBundle.GetAllLoadedAssetBundles().Count() - UnloadingAssetBundleCount;

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.SubsystemRegistration)]
	private static void Init()
	{
		m_UnloadingBundles = new Dictionary<string, AssetBundleUnloadOperation>();
	}

	internal static void WaitForAllUnloadingBundlesToComplete()
	{
		if (UnloadingAssetBundleCount > 0)
		{
			AssetBundleUnloadOperation[] array = m_UnloadingBundles.Values.ToArray();
			for (int i = 0; i < array.Length; i++)
			{
				array[i].WaitForCompletion();
			}
		}
	}

	public override void Provide(ProvideHandle providerInterface)
	{
		if (m_UnloadingBundles.TryGetValue(providerInterface.Location.InternalId, out var value) && value.isDone)
		{
			value = null;
		}
		new AssetBundleResource().Start(providerInterface, value);
	}

	public override Type GetDefaultType(IResourceLocation location)
	{
		return typeof(IAssetBundleResource);
	}

	public override void Release(IResourceLocation location, object asset)
	{
		if (location == null)
		{
			throw new ArgumentNullException("location");
		}
		AssetBundleUnloadOperation unloadOp;
		if (asset == null)
		{
			if (!(location is DownloadOnlyLocation))
			{
				Debug.LogWarningFormat("Releasing null asset bundle from location {0}.  This is an indication that the bundle failed to load.", location);
			}
		}
		else if (asset is AssetBundleResource assetBundleResource && assetBundleResource.Unload(out unloadOp))
		{
			m_UnloadingBundles.Add(location.InternalId, unloadOp);
			unloadOp.completed += (AsyncOperation op) =>
			{
				m_UnloadingBundles.Remove(location.InternalId);
			};
		}
	}

	internal virtual IOperationCacheKey CreateCacheKeyForLocation(ResourceManager rm, IResourceLocation location, Type desiredType)
	{
		return new IdCacheKey(location.GetType(), rm.TransformInternalId(location));
	}
}
