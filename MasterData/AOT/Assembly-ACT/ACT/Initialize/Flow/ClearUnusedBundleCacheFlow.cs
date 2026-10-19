using System;
using ACT.LocalLoader;
using Cysharp.Threading.Tasks;
using UnityEngine;
using YooAsset;

namespace ACT.Initialize.Flow;

internal sealed class ClearUnusedBundleCacheFlow : RuntimeLoadFlow
{
	public ClearUnusedBundleCacheFlow()
		: base("ClearUnusedBundleCache")
	{
	}

	protected override void OnStart()
	{
		base.OnStart();
		WaitInitializer.Start(1L);
		ClearUnusedBundlesAsync().Forget();
	}

	private async UniTask ClearUnusedBundlesAsync()
	{
		try
		{
			YooAssetInitData cachedYooAssetInitData = GameStart.CachedYooAssetInitData;
			if (cachedYooAssetInitData == null || cachedYooAssetInitData.YooAssetParam?.PlayMode != EPlayMode.HostPlayMode || cachedYooAssetInitData.PackageInfos == null)
			{
				return;
			}
			foreach (PackageInfo value in cachedYooAssetInitData.PackageInfos.Values)
			{
				ResourcePackage package = value?.Package;
				if (package == null || package.InitializeStatus != EOperationStatus.Succeed)
				{
					continue;
				}
				try
				{
					string version = package.GetPackageVersion();
					if (string.IsNullOrEmpty(version))
					{
						continue;
					}
					ClearCacheFilesOperation operation = package.ClearCacheFilesAsync(EFileClearMode.ClearUnusedBundleFiles);
					await operation.Task;
					if (LuminApplication.LogEnabled)
					{
						if (operation.Status == EOperationStatus.Succeed)
						{
							Debug.Log("[ClearUnusedBundleCache] 清理完成: package=" + package.PackageName + ", version=" + version);
						}
						else
						{
							Debug.LogWarning("[ClearUnusedBundleCache] 清理失败: package=" + package.PackageName + ", error=" + operation.Error);
						}
					}
				}
				catch (Exception ex)
				{
					if (LuminApplication.LogEnabled)
					{
						Debug.LogWarning("[ClearUnusedBundleCache] 清理异常: package=" + package.PackageName + ", error=" + ex.Message);
					}
				}
			}
		}
		finally
		{
			WaitInitializer.CompleteOne();
		}
	}
}
