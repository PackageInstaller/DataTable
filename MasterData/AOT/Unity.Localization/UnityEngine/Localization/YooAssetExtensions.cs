using System.Collections.Generic;
using UnityEngine.ResourceManagement.AsyncOperations;
using YooAsset;

namespace UnityEngine.Localization;

public static class YooAssetExtensions
{
	public static AsyncOperationHandle<TObject> ToAsyncOperationHandle<TObject>(this AssetHandle assetHandle) where TObject : class
	{
		return YooAssetAdapter.ConvertAssetHandleToAsyncOperationHandle<TObject>(assetHandle);
	}

	public static AsyncOperationHandle<Object> ToAsyncOperationHandle(this AssetHandle assetHandle)
	{
		return YooAssetAdapter.ConvertAssetHandleToAsyncOperationHandle<Object>(assetHandle);
	}

	public static AsyncOperationHandle<IList<TObject>> ToAsyncOperationHandle<TObject>(this List<AssetHandle> assetsHandle) where TObject : class
	{
		return YooAssetAdapter.ConvertAssetHandleListToAsyncOperationHandleList<TObject>(assetsHandle);
	}

	public static AsyncOperationHandle<IList<Object>> ToAsyncOperationHandle(this List<AssetHandle> assetsHandle)
	{
		return YooAssetAdapter.ConvertAssetHandleListToAsyncOperationHandleList<Object>(assetsHandle);
	}
}
