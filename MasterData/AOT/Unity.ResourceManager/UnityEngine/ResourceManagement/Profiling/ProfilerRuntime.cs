using System;
using System.Collections.Generic;
using Unity.Profiling;
using UnityEngine.ResourceManagement.AsyncOperations;
using UnityEngine.ResourceManagement.ResourceLocations;
using UnityEngine.ResourceManagement.ResourceProviders;
using UnityEngine.ResourceManagement.Util;

namespace UnityEngine.ResourceManagement.Profiling;

internal static class ProfilerRuntime
{
	internal static IProfilerEmitter m_profilerEmitter = new EngineEmitter();

	public static readonly Guid kResourceManagerProfilerGuid = new Guid("4f8a8c93-7634-4ef7-bbbc-6c9928567fa4");

	public const int kCatalogTag = 0;

	public const int kBundleDataTag = 1;

	public const int kAssetDataTag = 2;

	public const int kSceneDataTag = 3;

	private static ProfilerCounterValue<int> CatalogLoadCounter = new ProfilerCounterValue<int>(ProfilerCategory.Loading, "Catalogs", ProfilerMarkerDataUnit.Count);

	private static ProfilerCounterValue<int> AssetBundleLoadCounter = new ProfilerCounterValue<int>(ProfilerCategory.Loading, "Asset Bundles", ProfilerMarkerDataUnit.Count);

	private static ProfilerCounterValue<int> AssetLoadCounter = new ProfilerCounterValue<int>(ProfilerCategory.Loading, "Assets", ProfilerMarkerDataUnit.Count);

	private static ProfilerCounterValue<int> SceneLoadCounter = new ProfilerCounterValue<int>(ProfilerCategory.Loading, "Scenes", ProfilerMarkerDataUnit.Count);

	private static ProfilerFrameData<Hash128, CatalogFrameData> m_CatalogData = new ProfilerFrameData<Hash128, CatalogFrameData>(4);

	private static ProfilerFrameData<IAsyncOperation, BundleFrameData> m_BundleData = new ProfilerFrameData<IAsyncOperation, BundleFrameData>(64);

	private static ProfilerFrameData<IAsyncOperation, AssetFrameData> m_AssetData = new ProfilerFrameData<IAsyncOperation, AssetFrameData>(512);

	private static ProfilerFrameData<IAsyncOperation, AssetFrameData> m_SceneData = new ProfilerFrameData<IAsyncOperation, AssetFrameData>(16);

	private static Dictionary<string, IAsyncOperation> m_BundleNameToOperation = new Dictionary<string, IAsyncOperation>(64);

	private static Dictionary<string, List<IAsyncOperation>> m_BundleNameToAssetOperations = new Dictionary<string, List<IAsyncOperation>>(512);

	private static Dictionary<IAsyncOperation, (int, float)> m_DataChange = new Dictionary<IAsyncOperation, (int, float)>(64);

	public static void Initialise()
	{
		CatalogLoadCounter.Value = 0;
		AssetBundleLoadCounter.Value = 0;
		AssetLoadCounter.Value = 0;
		SceneLoadCounter.Value = 0;
		m_CatalogData.Data.Clear();
		m_BundleData.Data.Clear();
		m_AssetData.Data.Clear();
		m_SceneData.Data.Clear();
		m_profilerEmitter.InitialiseCallbacks(InstanceOnOnLateUpdateDelegate);
	}

	private static void InstanceOnOnLateUpdateDelegate(float deltaTime)
	{
		PushToProfilerStream();
	}

	public static void AddCatalog(Hash128 buildHash)
	{
		if (buildHash.isValid)
		{
			m_CatalogData.Add(buildHash, new CatalogFrameData
			{
				BuildResultHash = buildHash
			});
			CatalogLoadCounter.Value++;
		}
	}

	public static void AddBundleOperation(ProvideHandle handle, AssetBundleRequestOptions requestOptions, ContentStatus status, BundleSource source)
	{
		if (!(handle.InternalOp is IAsyncOperation asyncOperation))
		{
			throw new NullReferenceException("Could not get Bundle operation for handle loaded for Key " + handle.Location.PrimaryKey);
		}
		string bundleName = requestOptions.BundleName;
		BundleOptions bundleOptions = BundleOptions.None;
		bool flag = requestOptions.Crc != 0;
		if (flag && source == BundleSource.Cache)
		{
			flag = requestOptions.UseCrcForCachedBundle;
		}
		if (flag)
		{
			bundleOptions |= BundleOptions.CheckSumEnabled;
		}
		if (!string.IsNullOrEmpty(requestOptions.Hash))
		{
			bundleOptions |= BundleOptions.CachingEnabled;
		}
		BundleFrameData value = new BundleFrameData
		{
			ReferenceCount = asyncOperation.ReferenceCount,
			BundleCode = bundleName.GetHashCode(),
			Status = status,
			LoadingOptions = bundleOptions,
			Source = source
		};
		m_BundleData.Add(asyncOperation, value);
		if (!m_BundleNameToOperation.ContainsKey(bundleName))
		{
			AssetBundleLoadCounter.Value++;
		}
		m_BundleNameToOperation[bundleName] = asyncOperation;
	}

	public static void BundleReleased(string bundleName)
	{
		if (string.IsNullOrEmpty(bundleName) || !m_BundleNameToOperation.TryGetValue(bundleName, out var value))
		{
			return;
		}
		m_BundleData.Remove(value);
		m_BundleNameToOperation.Remove(bundleName);
		AssetBundleLoadCounter.Value--;
		if (!m_BundleNameToAssetOperations.TryGetValue(bundleName, out var value2))
		{
			return;
		}
		m_BundleNameToAssetOperations.Remove(bundleName);
		foreach (IAsyncOperation item in value2)
		{
			AssetLoadCounter.Value--;
			m_AssetData.Remove(item);
		}
	}

	public static void AddAssetOperation(ProvideHandle handle, ContentStatus status)
	{
		if (!handle.IsValid)
		{
			throw new ArgumentException("Attempting to add a Asset handle to profiler that is not valid");
		}
		if (!(handle.InternalOp is IAsyncOperation asyncOperation))
		{
			throw new NullReferenceException("Could not get operation for InternalOp of handle loaded with primary key: " + handle.Location.PrimaryKey);
		}
		string containingBundleNameForLocation = GetContainingBundleNameForLocation(handle.Location);
		string text;
		if (handle.Location.InternalId.EndsWith("]"))
		{
			int startIndex = handle.Location.InternalId.IndexOf('[');
			text = handle.Location.InternalId.Remove(startIndex);
		}
		else
		{
			text = handle.Location.InternalId;
		}
		AssetFrameData value = new AssetFrameData
		{
			AssetCode = text.GetHashCode(),
			ReferenceCount = asyncOperation.ReferenceCount,
			BundleCode = containingBundleNameForLocation.GetHashCode(),
			Status = status
		};
		if (m_BundleNameToAssetOperations.TryGetValue(containingBundleNameForLocation, out var value2))
		{
			if (!value2.Contains(asyncOperation))
			{
				value2.Add(asyncOperation);
			}
		}
		else
		{
			m_BundleNameToAssetOperations.Add(containingBundleNameForLocation, new List<IAsyncOperation> { asyncOperation });
		}
		if (m_AssetData.Add(asyncOperation, value))
		{
			AssetLoadCounter.Value++;
		}
	}

	private static string GetContainingBundleNameForLocation(IResourceLocation location)
	{
		if (location == null || location.Dependencies == null || location.Dependencies.Count == 0)
		{
			return "";
		}
		if (!(location.Dependencies[0].Data is AssetBundleRequestOptions assetBundleRequestOptions))
		{
			Debug.LogError("Dependency bundle location does not have AssetBundleRequestOptions");
			return "";
		}
		return assetBundleRequestOptions.BundleName;
	}

	public static void AddSceneOperation(AsyncOperationHandle<SceneInstance> handle, IResourceLocation location, ContentStatus status)
	{
		IAsyncOperation internalOp = handle.InternalOp;
		string containingBundleNameForLocation = GetContainingBundleNameForLocation(location);
		AssetFrameData value = new AssetFrameData
		{
			AssetCode = location.InternalId.GetHashCode(),
			ReferenceCount = internalOp.ReferenceCount,
			BundleCode = containingBundleNameForLocation.GetHashCode(),
			Status = status
		};
		if (m_SceneData.Add(internalOp, value))
		{
			SceneLoadCounter.Value++;
		}
	}

	public static void SceneReleased(AsyncOperationHandle<SceneInstance> handle)
	{
		if (handle.InternalOp is ChainOperationTypelessDepedency<SceneInstance> chainOperationTypelessDepedency)
		{
			if (m_SceneData.Remove(chainOperationTypelessDepedency.WrappedOp.InternalOp))
			{
				SceneLoadCounter.Value--;
			}
			else
			{
				Debug.LogWarning("Failed to remove scene from Addressables profiler for " + chainOperationTypelessDepedency.WrappedOp.DebugName);
			}
		}
		else if (m_SceneData.Remove(handle.InternalOp))
		{
			SceneLoadCounter.Value--;
		}
		else
		{
			Debug.LogWarning("Failed to remove scene from Addressables profiler for " + handle.DebugName);
		}
	}

	internal static void PushToProfilerStream()
	{
		if (m_profilerEmitter.IsEnabled)
		{
			RefreshChangedReferenceCounts();
			m_profilerEmitter.EmitFrameMetaData(kResourceManagerProfilerGuid, 0, m_CatalogData.Values);
			m_profilerEmitter.EmitFrameMetaData(kResourceManagerProfilerGuid, 1, m_BundleData.Values);
			m_profilerEmitter.EmitFrameMetaData(kResourceManagerProfilerGuid, 2, m_AssetData.Values);
			m_profilerEmitter.EmitFrameMetaData(kResourceManagerProfilerGuid, 3, m_SceneData.Values);
			m_CatalogData.Data.Clear();
		}
	}

	private static void RefreshChangedReferenceCounts()
	{
		m_DataChange.Clear();
		foreach (KeyValuePair<IAsyncOperation, BundleFrameData> datum in m_BundleData.Data)
		{
			if (ShouldUpdateFrameDataWithOperationData(datum.Key, datum.Value.ReferenceCount, datum.Value.PercentComplete, out var newDataOut))
			{
				m_DataChange.Add(datum.Key, newDataOut);
			}
		}
		foreach (KeyValuePair<IAsyncOperation, (int, float)> item in m_DataChange)
		{
			BundleFrameData value = m_BundleData[item.Key];
			value.ReferenceCount = item.Value.Item1;
			value.PercentComplete = item.Value.Item2;
			m_BundleData[item.Key] = value;
		}
		m_DataChange.Clear();
		foreach (KeyValuePair<IAsyncOperation, AssetFrameData> datum2 in m_AssetData.Data)
		{
			if (ShouldUpdateFrameDataWithOperationData(datum2.Key, datum2.Value.ReferenceCount, datum2.Value.PercentComplete, out var newDataOut2))
			{
				m_DataChange.Add(datum2.Key, newDataOut2);
			}
		}
		foreach (KeyValuePair<IAsyncOperation, (int, float)> item2 in m_DataChange)
		{
			AssetFrameData value2 = m_AssetData[item2.Key];
			value2.ReferenceCount = item2.Value.Item1;
			value2.PercentComplete = item2.Value.Item2;
			m_AssetData[item2.Key] = value2;
		}
		m_DataChange.Clear();
		foreach (KeyValuePair<IAsyncOperation, AssetFrameData> datum3 in m_SceneData.Data)
		{
			if (ShouldUpdateFrameDataWithOperationData(datum3.Key, datum3.Value.ReferenceCount, datum3.Value.PercentComplete, out var newDataOut3))
			{
				m_DataChange.Add(datum3.Key, newDataOut3);
			}
		}
		foreach (KeyValuePair<IAsyncOperation, (int, float)> item3 in m_DataChange)
		{
			AssetFrameData value3 = m_SceneData[item3.Key];
			value3.ReferenceCount = item3.Value.Item1;
			value3.PercentComplete = item3.Value.Item2;
			m_SceneData[item3.Key] = value3;
		}
	}

	private static bool ShouldUpdateFrameDataWithOperationData(IAsyncOperation activeOperation, int frameReferenceCount, float framePercentComplete, out (int, float) newDataOut)
	{
		int num = activeOperation.ReferenceCount;
		switch (activeOperation.Status)
		{
		case AsyncOperationStatus.Failed:
			num = 0;
			break;
		case AsyncOperationStatus.None:
			if (activeOperation.IsDone || !activeOperation.IsRunning)
			{
				num = 0;
			}
			break;
		}
		float percentComplete = activeOperation.PercentComplete;
		newDataOut = (num, percentComplete);
		if (num == frameReferenceCount)
		{
			return !Mathf.Approximately(percentComplete, framePercentComplete);
		}
		return true;
	}
}
