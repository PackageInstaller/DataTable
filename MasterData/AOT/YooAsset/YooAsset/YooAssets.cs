using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace YooAsset;

public static class YooAssets
{
	private static bool _isInitialize = false;

	private static GameObject _driver = null;

	private static readonly List<ResourcePackage> _packages = new List<ResourcePackage>();

	private static ResourcePackage _defaultPackage;

	public static bool Initialized => _isInitialize;

	public static void Initialize(ILogger logger = null)
	{
		if (_isInitialize)
		{
			Debug.LogWarning("YooAssets is initialized !");
		}
		else if (!_isInitialize)
		{
			YooLogger.Logger = logger;
			_isInitialize = true;
			_driver = new GameObject("[YooAssets]");
			_driver.AddComponent<YooAssetsDriver>();
			UnityEngine.Object.DontDestroyOnLoad(_driver);
			OperationSystem.Initialize();
		}
	}

	public static void Destroy()
	{
		if (_isInitialize)
		{
			_isInitialize = false;
			if (_driver != null)
			{
				UnityEngine.Object.Destroy(_driver);
			}
			ClearAllPackageOperation();
			AssetBundle.UnloadAllAssetBundles(unloadAllObjects: true);
			_packages.Clear();
		}
	}

	internal static void Update()
	{
		if (_isInitialize)
		{
			OperationSystem.Update();
		}
	}

	internal static void ClearAllPackageOperation()
	{
		foreach (ResourcePackage package in _packages)
		{
			OperationSystem.ClearPackageOperation(package.PackageName);
		}
		OperationSystem.DestroyAll();
	}

	public static ResourcePackage CreatePackage(string packageName)
	{
		CheckException(packageName);
		if (ContainsPackage(packageName))
		{
			throw new Exception("Package " + packageName + " already existed !");
		}
		ResourcePackage resourcePackage = new ResourcePackage(packageName);
		_packages.Add(resourcePackage);
		return resourcePackage;
	}

	public static ResourcePackage GetPackage(string packageName)
	{
		CheckException(packageName);
		ResourcePackage packageInternal = GetPackageInternal(packageName);
		if (packageInternal == null)
		{
			YooLogger.Error("Can not found resource package : " + packageName);
		}
		return packageInternal;
	}

	public static ResourcePackage TryGetPackage(string packageName)
	{
		CheckException(packageName);
		return GetPackageInternal(packageName);
	}

	public static List<ResourcePackage> GetAllPackages()
	{
		return _packages.ToList();
	}

	public static bool RemovePackage(string packageName)
	{
		CheckException(packageName);
		ResourcePackage packageInternal = GetPackageInternal(packageName);
		if (packageInternal == null)
		{
			return false;
		}
		return RemovePackage(packageInternal);
	}

	public static bool RemovePackage(ResourcePackage package)
	{
		CheckException(package);
		string packageName = package.PackageName;
		if (package.InitializeStatus != EOperationStatus.None)
		{
			YooLogger.Error("The resource package " + packageName + " has not been destroyed, please call the method DestroyAsync to destroy!");
			return false;
		}
		_packages.Remove(package);
		return true;
	}

	public static bool ContainsPackage(string packageName)
	{
		CheckException(packageName);
		return GetPackageInternal(packageName) != null;
	}

	public static void StartOperation(GameAsyncOperation operation)
	{
		OperationSystem.StartOperation(string.Empty, operation);
	}

	private static ResourcePackage GetPackageInternal(string packageName)
	{
		foreach (ResourcePackage package in _packages)
		{
			if (package.PackageName == packageName)
			{
				return package;
			}
		}
		return null;
	}

	private static void CheckException(string packageName)
	{
		if (!_isInitialize)
		{
			throw new Exception("YooAssets not initialize !");
		}
		if (string.IsNullOrEmpty(packageName))
		{
			throw new Exception("Package name is null or empty !");
		}
	}

	private static void CheckException(ResourcePackage package)
	{
		if (!_isInitialize)
		{
			throw new Exception("YooAssets not initialize !");
		}
		if (package == null)
		{
			throw new Exception("Package instance is null !");
		}
	}

	public static void SetDownloadSystemUnityWebRequest(UnityWebRequestDelegate createDelegate)
	{
		DownloadSystemHelper.UnityWebRequestCreater = createDelegate;
	}

	public static void SetOperationSystemMaxTimeSlice(long milliseconds)
	{
		if (milliseconds < 10)
		{
			milliseconds = 10L;
			YooLogger.Warning("MaxTimeSlice minimum value is 10 milliseconds.");
		}
		OperationSystem.MaxTimeSlice = milliseconds;
	}

	internal static DebugReport GetDebugReport()
	{
		DebugReport debugReport = new DebugReport();
		debugReport.FrameCount = Time.frameCount;
		foreach (ResourcePackage package in _packages)
		{
			DebugPackageData debugPackageData = package.GetDebugPackageData();
			debugReport.PackageDatas.Add(debugPackageData);
		}
		return debugReport;
	}

	public static void SetDefaultPackage(ResourcePackage package)
	{
		_defaultPackage = package;
	}

	public static bool IsNeedDownloadFromRemote(string location)
	{
		return _defaultPackage.IsNeedDownloadFromRemote(location);
	}

	public static bool IsNeedDownloadFromRemote(AssetInfo assetInfo)
	{
		return _defaultPackage.IsNeedDownloadFromRemote(assetInfo);
	}

	public static AssetInfo[] GetAssetInfos(string tag)
	{
		return _defaultPackage.GetAssetInfos(tag);
	}

	public static AssetInfo[] GetAssetInfos(string[] tags)
	{
		return _defaultPackage.GetAssetInfos(tags);
	}

	public static AssetInfo[] GetAssetInfosByAllTags(string[] tags)
	{
		return _defaultPackage.GetAssetInfosByAllTags(tags);
	}

	public static AssetInfo GetAssetInfo(string location)
	{
		return _defaultPackage.GetAssetInfo(location);
	}

	public static AssetInfo GetAssetInfo(string location, Type type)
	{
		return _defaultPackage.GetAssetInfo(location, type);
	}

	public static AssetInfo GetAssetInfoByGUID(string assetGUID)
	{
		return _defaultPackage.GetAssetInfoByGUID(assetGUID);
	}

	public static AssetInfo GetAssetInfoByGUID(string assetGUID, Type type)
	{
		return _defaultPackage.GetAssetInfoByGUID(assetGUID, type);
	}

	public static bool CheckLocationValid(string location)
	{
		return _defaultPackage.CheckLocationValid(location);
	}

	public static RawFileHandle LoadRawFileSync(AssetInfo assetInfo)
	{
		return _defaultPackage.LoadRawFileSync(assetInfo);
	}

	public static RawFileHandle LoadRawFileSync(string location)
	{
		return _defaultPackage.LoadRawFileSync(location);
	}

	public static RawFileHandle LoadRawFileAsync(AssetInfo assetInfo, uint priority = 0u)
	{
		return _defaultPackage.LoadRawFileAsync(assetInfo, priority);
	}

	public static RawFileHandle LoadRawFileAsync(string location, uint priority = 0u)
	{
		return _defaultPackage.LoadRawFileAsync(location, priority);
	}

	public static SceneHandle LoadSceneSync(string location, LoadSceneMode sceneMode = LoadSceneMode.Single, LocalPhysicsMode physicsMode = LocalPhysicsMode.None)
	{
		return _defaultPackage.LoadSceneSync(location, sceneMode, physicsMode);
	}

	public static SceneHandle LoadSceneSync(AssetInfo assetInfo, LoadSceneMode sceneMode = LoadSceneMode.Single, LocalPhysicsMode physicsMode = LocalPhysicsMode.None)
	{
		return _defaultPackage.LoadSceneSync(assetInfo, sceneMode, physicsMode);
	}

	public static SceneHandle LoadSceneAsync(string location, LoadSceneMode sceneMode = LoadSceneMode.Single, LocalPhysicsMode physicsMode = LocalPhysicsMode.None, bool suspendLoad = false, uint priority = 100u)
	{
		return _defaultPackage.LoadSceneAsync(location, sceneMode, physicsMode, suspendLoad, priority);
	}

	public static SceneHandle LoadSceneAsync(AssetInfo assetInfo, LoadSceneMode sceneMode = LoadSceneMode.Single, LocalPhysicsMode physicsMode = LocalPhysicsMode.None, bool suspendLoad = false, uint priority = 100u)
	{
		return _defaultPackage.LoadSceneAsync(assetInfo, sceneMode, physicsMode, suspendLoad, priority);
	}

	public static AssetHandle LoadAssetSync(AssetInfo assetInfo)
	{
		return _defaultPackage.LoadAssetSync(assetInfo);
	}

	public static AssetHandle LoadAssetSync<TObject>(string location) where TObject : UnityEngine.Object
	{
		return _defaultPackage.LoadAssetSync<TObject>(location);
	}

	public static AssetHandle LoadAssetSync(string location, Type type)
	{
		return _defaultPackage.LoadAssetSync(location, type);
	}

	public static AssetHandle LoadAssetSync(string location)
	{
		return _defaultPackage.LoadAssetSync(location);
	}

	public static AssetHandle LoadAssetAsync(AssetInfo assetInfo, uint priority = 0u)
	{
		return _defaultPackage.LoadAssetAsync(assetInfo, priority);
	}

	public static AssetHandle LoadAssetAsync<TObject>(string location, uint priority = 0u) where TObject : UnityEngine.Object
	{
		return _defaultPackage.LoadAssetAsync<TObject>(location, priority);
	}

	public static AssetHandle LoadAssetAsync(string location, Type type, uint priority = 0u)
	{
		return _defaultPackage.LoadAssetAsync(location, type, priority);
	}

	public static AssetHandle LoadAssetAsync(string location, uint priority = 0u)
	{
		return _defaultPackage.LoadAssetAsync(location, priority);
	}

	public static SubAssetsHandle LoadSubAssetsSync(AssetInfo assetInfo)
	{
		return _defaultPackage.LoadSubAssetsSync(assetInfo);
	}

	public static SubAssetsHandle LoadSubAssetsSync<TObject>(string location) where TObject : UnityEngine.Object
	{
		return _defaultPackage.LoadSubAssetsSync<TObject>(location);
	}

	public static SubAssetsHandle LoadSubAssetsSync(string location, Type type)
	{
		return _defaultPackage.LoadSubAssetsSync(location, type);
	}

	public static SubAssetsHandle LoadSubAssetsSync(string location)
	{
		return _defaultPackage.LoadSubAssetsSync(location);
	}

	public static SubAssetsHandle LoadSubAssetsAsync(AssetInfo assetInfo, uint priority = 0u)
	{
		return _defaultPackage.LoadSubAssetsAsync(assetInfo, priority);
	}

	public static SubAssetsHandle LoadSubAssetsAsync<TObject>(string location, uint priority = 0u) where TObject : UnityEngine.Object
	{
		return _defaultPackage.LoadSubAssetsAsync<TObject>(location, priority);
	}

	public static SubAssetsHandle LoadSubAssetsAsync(string location, Type type, uint priority = 0u)
	{
		return _defaultPackage.LoadSubAssetsAsync(location, type, priority);
	}

	public static SubAssetsHandle LoadSubAssetsAsync(string location, uint priority = 0u)
	{
		return _defaultPackage.LoadSubAssetsAsync(location, priority);
	}

	public static AllAssetsHandle LoadAllAssetsSync(AssetInfo assetInfo)
	{
		return _defaultPackage.LoadAllAssetsSync(assetInfo);
	}

	public static AllAssetsHandle LoadAllAssetsSync<TObject>(string location) where TObject : UnityEngine.Object
	{
		return _defaultPackage.LoadAllAssetsSync<TObject>(location);
	}

	public static AllAssetsHandle LoadAllAssetsSync(string location, Type type)
	{
		return _defaultPackage.LoadAllAssetsSync(location, type);
	}

	public static AllAssetsHandle LoadAllAssetsSync(string location)
	{
		return _defaultPackage.LoadAllAssetsSync(location);
	}

	public static AllAssetsHandle LoadAllAssetsAsync(AssetInfo assetInfo, uint priority = 0u)
	{
		return _defaultPackage.LoadAllAssetsAsync(assetInfo, priority);
	}

	public static AllAssetsHandle LoadAllAssetsAsync<TObject>(string location, uint priority = 0u) where TObject : UnityEngine.Object
	{
		return _defaultPackage.LoadAllAssetsAsync<TObject>(location, priority);
	}

	public static AllAssetsHandle LoadAllAssetsAsync(string location, Type type, uint priority = 0u)
	{
		return _defaultPackage.LoadAllAssetsAsync(location, type, priority);
	}

	public static AllAssetsHandle LoadAllAssetsAsync(string location, uint priority = 0u)
	{
		return _defaultPackage.LoadAllAssetsAsync(location, priority);
	}

	public static ResourceDownloaderOperation CreateResourceDownloader(int downloadingMaxNumber, int failedTryAgain)
	{
		return _defaultPackage.CreateResourceDownloader(downloadingMaxNumber, failedTryAgain);
	}

	public static ResourceDownloaderOperation CreateResourceDownloader(string tag, int downloadingMaxNumber, int failedTryAgain)
	{
		return _defaultPackage.CreateResourceDownloader(new string[1] { tag }, downloadingMaxNumber, failedTryAgain);
	}

	public static ResourceDownloaderOperation CreateResourceDownloader(string[] tags, int downloadingMaxNumber, int failedTryAgain)
	{
		return _defaultPackage.CreateResourceDownloader(tags, downloadingMaxNumber, failedTryAgain);
	}

	public static ResourceDownloaderOperation CreateResourceDownloaderByDownloadTag(string downloadTag, int downloadingMaxNumber, int failedTryAgain)
	{
		return _defaultPackage.CreateResourceDownloaderByDownloadTag(downloadTag, downloadingMaxNumber, failedTryAgain);
	}

	public static ResourceDownloaderOperation CreateResourceDownloaderByDownloadTags(string[] downloadTags, int downloadingMaxNumber, int failedTryAgain)
	{
		return _defaultPackage.CreateResourceDownloaderByDownloadTags(downloadTags, downloadingMaxNumber, failedTryAgain);
	}

	public static ResourceDownloaderOperation CreateBundleDownloader(string location, int downloadingMaxNumber, int failedTryAgain)
	{
		return _defaultPackage.CreateBundleDownloader(location, downloadingMaxNumber, failedTryAgain);
	}

	public static ResourceDownloaderOperation CreateBundleDownloader(string[] locations, int downloadingMaxNumber, int failedTryAgain)
	{
		return _defaultPackage.CreateBundleDownloader(locations, downloadingMaxNumber, failedTryAgain);
	}

	public static ResourceDownloaderOperation CreateBundleDownloader(AssetInfo assetInfo, int downloadingMaxNumber, int failedTryAgain)
	{
		return _defaultPackage.CreateBundleDownloader(assetInfo, downloadingMaxNumber, failedTryAgain);
	}

	public static ResourceDownloaderOperation CreateBundleDownloader(AssetInfo[] assetInfos, int downloadingMaxNumber, int failedTryAgain)
	{
		return _defaultPackage.CreateBundleDownloader(assetInfos, downloadingMaxNumber, failedTryAgain);
	}

	public static ResourceUnpackerOperation CreateResourceUnpacker(int unpackingMaxNumber, int failedTryAgain)
	{
		return _defaultPackage.CreateResourceUnpacker(unpackingMaxNumber, failedTryAgain);
	}

	public static ResourceUnpackerOperation CreateResourceUnpacker(string tag, int unpackingMaxNumber, int failedTryAgain)
	{
		return _defaultPackage.CreateResourceUnpacker(tag, unpackingMaxNumber, failedTryAgain);
	}

	public static ResourceUnpackerOperation CreateResourceUnpacker(string[] tags, int unpackingMaxNumber, int failedTryAgain)
	{
		return _defaultPackage.CreateResourceUnpacker(tags, unpackingMaxNumber, failedTryAgain);
	}

	public static ResourceImporterOperation CreateResourceImporter(string[] filePaths, int importerMaxNumber, int failedTryAgain)
	{
		return _defaultPackage.CreateResourceImporter(filePaths, importerMaxNumber, failedTryAgain);
	}

	[Conditional("DEBUG")]
	private static void DebugCheckDefaultPackageValid()
	{
		if (_defaultPackage == null)
		{
			throw new Exception("Default package is null. Please use SetDefaultPackage !");
		}
	}
}
