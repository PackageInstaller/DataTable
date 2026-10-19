using System.Collections.Generic;
using Bamboo.AssetField;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using YooAsset;

namespace ACT;

public class AssetStationManager : Singleton<AssetStationManager>
{
	private static AssetOffice _assetOffice;

	private static AssetStation _battleStation;

	private static AssetStation _sceneStation;

	private static bool _isUnityUnloadUnusedAssetsRunning;

	public static AssetOffice AssetOffice
	{
		get
		{
			if (_assetOffice == null)
			{
				_assetOffice = new AssetOffice(1, new YooAssetLoader());
			}
			return _assetOffice;
		}
	}

	public static AssetStation Root => AssetOffice.Root;

	public static AssetStation BattleStation
	{
		get
		{
			if (_battleStation == null && LuminApplication.LogEnabled)
			{
				Debug.LogError("此时不可调用战斗Station");
			}
			return _battleStation;
		}
	}

	public static AssetStation SceneStation
	{
		get
		{
			if (_sceneStation == null && LuminApplication.LogEnabled)
			{
				Debug.LogError("此时不可调用场景Station");
			}
			return _sceneStation;
		}
	}

	public void SpawnStation()
	{
		if (_battleStation == null)
		{
			_battleStation = AssetOffice.NewStation(2, 1);
			_sceneStation = AssetOffice.NewStation(3, 1);
		}
	}

	public override void UnInit()
	{
		base.UnInit();
		ImageManager.UnloadAllTemporaryAssetStations();
		UnloadAllStations();
	}

	public static void UnloadBattleStation()
	{
		_battleStation?.UnloadAll();
	}

	public static void UnloadSceneStation()
	{
		_sceneStation?.UnloadAll();
	}

	public static void UnloadAllStations()
	{
		_sceneStation?.UnloadAll();
		_battleStation?.UnloadAll();
	}

	public static void RequestUnloadUnusedUnityAssets()
	{
		if (!_isUnityUnloadUnusedAssetsRunning)
		{
			UnloadUnusedUnityAssetsAsync().Forget();
		}
	}

	public static async UniTask UnloadUnusedUnityAssetsAsync()
	{
		if (_isUnityUnloadUnusedAssetsRunning)
		{
			await UniTask.WaitUntil(() => !_isUnityUnloadUnusedAssetsRunning);
			return;
		}
		_isUnityUnloadUnusedAssetsRunning = true;
		try
		{
			await Resources.UnloadUnusedAssets();
		}
		finally
		{
			_isUnityUnloadUnusedAssetsRunning = false;
		}
	}

	public static void RequestUnloadUnusedYooAssets(string packageName, int loopCount = 10)
	{
		UnloadUnusedYooAssetsAsync(packageName, loopCount).Forget();
	}

	public static async UniTask UnloadUnusedYooAssetsAsync(string packageName, int loopCount = 10)
	{
		if (YooAssets.Initialized && !string.IsNullOrEmpty(packageName))
		{
			ResourcePackage resourcePackage = YooAssets.TryGetPackage(packageName);
			if (resourcePackage != null)
			{
				await resourcePackage.UnloadUnusedAssetsAsync(loopCount).Task;
			}
		}
	}

	public static void RequestUnloadUnusedAllYooAssetPackages(int loopCount = 10)
	{
		UnloadUnusedAllYooAssetPackagesAsync(loopCount).Forget();
	}

	public static async UniTask UnloadUnusedAllYooAssetPackagesAsync(int loopCount = 10)
	{
		if (YooAssets.Initialized)
		{
			List<string> packages = YooAssetDefine.PACKAGES;
			for (int i = 0; i < packages.Count; i++)
			{
				await UnloadUnusedYooAssetsAsync(packages[i], loopCount);
			}
		}
	}
}
