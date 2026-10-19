using System.Collections.Generic;
using UnityEngine.Pool;
using UnityEngine.ResourceManagement.AsyncOperations;
using YooAsset;

namespace UnityEngine.Localization;

internal class YooAssetAdapter
{
	public static AsyncOperationHandle<TObject> ConvertAssetHandleToAsyncOperationHandle<TObject>(AssetHandle assetHandle) where TObject : class
	{
		if (assetHandle == null || !assetHandle.IsValid)
		{
			return AddressablesInterface.ResourceManager.CreateCompletedOperation<TObject>(null, "Invalid AssetHandle");
		}
		YooAssetToAsyncOperationAdapter<TObject> yooAssetToAsyncOperationAdapter = GenericPool<YooAssetToAsyncOperationAdapter<TObject>>.Get();
		yooAssetToAsyncOperationAdapter.Init(assetHandle);
		return AddressablesInterface.ResourceManager.StartOperation(yooAssetToAsyncOperationAdapter, default);
	}

	public static AsyncOperationHandle<IList<TObject>> ConvertAssetHandleListToAsyncOperationHandleList<TObject>(List<AssetHandle> assetHandles) where TObject : class
	{
		if (assetHandles == null || assetHandles.Count == 0)
		{
			return AddressablesInterface.ResourceManager.CreateCompletedOperation((IList<TObject>)new List<TObject>(), "Empty AssetHandle list");
		}
		YooAssetListToAsyncOperationListAdapter<TObject> yooAssetListToAsyncOperationListAdapter = GenericPool<YooAssetListToAsyncOperationListAdapter<TObject>>.Get();
		yooAssetListToAsyncOperationListAdapter.Init(assetHandles);
		return AddressablesInterface.ResourceManager.StartOperation(yooAssetListToAsyncOperationListAdapter, default);
	}

	public static AsyncOperationHandle<IList<TObject>> ConvertSubAssetsHandleToAsyncOperationHandle<TObject>(SubAssetsHandle subAssetsHandle) where TObject : class
	{
		if (subAssetsHandle == null || !subAssetsHandle.IsValid)
		{
			return AddressablesInterface.ResourceManager.CreateCompletedOperation<IList<TObject>>(null, "Invalid SubAssetsHandle");
		}
		YooAssetSubAssetsToAsyncOperationAdapter<TObject> yooAssetSubAssetsToAsyncOperationAdapter = GenericPool<YooAssetSubAssetsToAsyncOperationAdapter<TObject>>.Get();
		yooAssetSubAssetsToAsyncOperationAdapter.Init(subAssetsHandle);
		return AddressablesInterface.ResourceManager.StartOperation(yooAssetSubAssetsToAsyncOperationAdapter, default);
	}

	public static AsyncOperationHandle<IList<TObject>> ConvertAllAssetsHandleToAsyncOperationHandle<TObject>(AllAssetsHandle allAssetsHandle) where TObject : class
	{
		if (allAssetsHandle == null || !allAssetsHandle.IsValid)
		{
			return AddressablesInterface.ResourceManager.CreateCompletedOperation<IList<TObject>>(null, "Invalid AllAssetsHandle");
		}
		YooAssetAllAssetsToAsyncOperationAdapter<TObject> yooAssetAllAssetsToAsyncOperationAdapter = GenericPool<YooAssetAllAssetsToAsyncOperationAdapter<TObject>>.Get();
		yooAssetAllAssetsToAsyncOperationAdapter.Init(allAssetsHandle);
		return AddressablesInterface.ResourceManager.StartOperation(yooAssetAllAssetsToAsyncOperationAdapter, default);
	}
}
