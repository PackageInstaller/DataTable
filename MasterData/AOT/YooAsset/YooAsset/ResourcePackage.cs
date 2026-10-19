using System;
using System.Collections.Generic;
using System.Diagnostics;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace YooAsset;

public class ResourcePackage
{
	private bool _isInitialize;

	private string _initializeError = string.Empty;

	private EOperationStatus _initializeStatus;

	private EPlayMode _playMode;

	private ResourceManager _resourceManager;

	private IBundleQuery _bundleQuery;

	private IPlayMode _playModeImpl;

	public readonly string PackageName;

	public EOperationStatus InitializeStatus => _initializeStatus;

	public bool PackageValid
	{
		get
		{
			if (_playModeImpl == null)
			{
				return false;
			}
			return _playModeImpl.ActiveManifest != null;
		}
	}

	internal ResourcePackage(string packageName)
	{
		PackageName = packageName;
	}

	internal void DestroyPackage()
	{
		if (_isInitialize)
		{
			_isInitialize = false;
			_initializeError = string.Empty;
			_initializeStatus = EOperationStatus.None;
			if (_resourceManager != null)
			{
				_resourceManager.Destroy();
				_resourceManager = null;
			}
			if (_playModeImpl != null)
			{
				_playModeImpl.DestroyFileSystem();
			}
			_bundleQuery = null;
			_playModeImpl = null;
		}
	}

	public InitializationOperation InitializeAsync(InitializeParameters parameters)
	{
		ResetInitializeAfterFailed();
		CheckInitializeParameters(parameters);
		if (_resourceManager != null)
		{
			_resourceManager.Destroy();
			_resourceManager = null;
		}
		_resourceManager = new ResourceManager(PackageName);
		PlayModeImpl playModeImpl = (PlayModeImpl)(_playModeImpl = (IPlayMode)(_bundleQuery = new PlayModeImpl(PackageName, _playMode)));
		_resourceManager.Initialize(parameters, _bundleQuery);
		InitializationOperation initializationOperation;
		if (_playMode == EPlayMode.EditorSimulateMode)
		{
			EditorSimulateModeParameters editorSimulateModeParameters = parameters as EditorSimulateModeParameters;
			initializationOperation = playModeImpl.InitializeAsync(editorSimulateModeParameters.EditorFileSystemParameters);
		}
		else if (_playMode == EPlayMode.OfflinePlayMode)
		{
			OfflinePlayModeParameters offlinePlayModeParameters = parameters as OfflinePlayModeParameters;
			initializationOperation = playModeImpl.InitializeAsync(offlinePlayModeParameters.BuildinFileSystemParameters);
		}
		else if (_playMode == EPlayMode.HostPlayMode)
		{
			HostPlayModeParameters hostPlayModeParameters = parameters as HostPlayModeParameters;
			initializationOperation = playModeImpl.InitializeAsync(hostPlayModeParameters.BuildinFileSystemParameters, hostPlayModeParameters.CacheFileSystemParameters);
		}
		else if (_playMode == EPlayMode.WebPlayMode)
		{
			WebPlayModeParameters webPlayModeParameters = parameters as WebPlayModeParameters;
			initializationOperation = playModeImpl.InitializeAsync(webPlayModeParameters.WebServerFileSystemParameters, webPlayModeParameters.WebRemoteFileSystemParameters);
		}
		else
		{
			if (_playMode != EPlayMode.CustomPlayMode)
			{
				throw new NotImplementedException();
			}
			CustomPlayModeParameters customPlayModeParameters = parameters as CustomPlayModeParameters;
			initializationOperation = playModeImpl.InitializeAsync(customPlayModeParameters.FileSystemParameterList);
		}
		_isInitialize = true;
		OperationSystem.StartOperation(PackageName, initializationOperation);
		initializationOperation.Completed += InitializeOperation_Completed;
		return initializationOperation;
	}

	private void ResetInitializeAfterFailed()
	{
		if (_isInitialize && _initializeStatus == EOperationStatus.Failed)
		{
			_isInitialize = false;
			_initializeStatus = EOperationStatus.None;
			_initializeError = string.Empty;
		}
	}

	private void CheckInitializeParameters(InitializeParameters parameters)
	{
		if (_isInitialize)
		{
			throw new Exception("ResourcePackage is initialized yet.");
		}
		if (parameters == null)
		{
			throw new Exception("ResourcePackage create parameters is null.");
		}
		if (parameters is EditorSimulateModeParameters)
		{
			throw new Exception("Editor simulate mode only support unity editor.");
		}
		if (parameters.BundleLoadingMaxConcurrency <= 0)
		{
			throw new Exception("BundleLoadingMaxConcurrency value must be greater than zero.");
		}
		if (parameters is EditorSimulateModeParameters)
		{
			_playMode = EPlayMode.EditorSimulateMode;
		}
		else if (parameters is OfflinePlayModeParameters)
		{
			_playMode = EPlayMode.OfflinePlayMode;
		}
		else if (parameters is HostPlayModeParameters)
		{
			_playMode = EPlayMode.HostPlayMode;
		}
		else if (parameters is WebPlayModeParameters)
		{
			_playMode = EPlayMode.WebPlayMode;
		}
		else
		{
			if (!(parameters is CustomPlayModeParameters))
			{
				throw new NotImplementedException();
			}
			_playMode = EPlayMode.CustomPlayMode;
		}
		if (_playMode != EPlayMode.EditorSimulateMode && _playMode == EPlayMode.WebPlayMode)
		{
			throw new Exception("WebPlayMode only support WebGL plateform !");
		}
	}

	private void InitializeOperation_Completed(AsyncOperationBase op)
	{
		_initializeStatus = op.Status;
		_initializeError = op.Error;
		if (_initializeStatus != EOperationStatus.Succeed)
		{
			YooLogger.Error(_initializeError);
		}
	}

	public DestroyOperation DestroyAsync()
	{
		DestroyOperation destroyOperation = new DestroyOperation(this);
		OperationSystem.StartOperation(null, destroyOperation);
		return destroyOperation;
	}

	public RequestPackageVersionOperation RequestPackageVersionAsync(bool appendTimeTicks = true, int timeout = 60)
	{
		RequestPackageVersionOperation requestPackageVersionOperation = _playModeImpl.RequestPackageVersionAsync(appendTimeTicks, timeout);
		OperationSystem.StartOperation(PackageName, requestPackageVersionOperation);
		return requestPackageVersionOperation;
	}

	public UpdatePackageManifestOperation UpdatePackageManifestAsync(string packageVersion, int timeout = 60)
	{
		if (_resourceManager.HasAnyLoader())
		{
			YooLogger.Warning("Found loaded bundle before update manifest ! Recommended to call the  UnloadAllAssetsAsync method to release loaded bundle !");
		}
		UpdatePackageManifestOperation updatePackageManifestOperation = _playModeImpl.UpdatePackageManifestAsync(packageVersion, timeout);
		OperationSystem.StartOperation(PackageName, updatePackageManifestOperation);
		return updatePackageManifestOperation;
	}

	public PreDownloadContentOperation PreDownloadContentAsync(string packageVersion, int timeout = 60)
	{
		PreDownloadContentOperation preDownloadContentOperation = _playModeImpl.PreDownloadContentAsync(packageVersion, timeout);
		OperationSystem.StartOperation(PackageName, preDownloadContentOperation);
		return preDownloadContentOperation;
	}

	public ClearCacheFilesOperation ClearCacheFilesAsync(EFileClearMode clearMode, object clearParam = null)
	{
		ClearCacheFilesOptions clearCacheFilesOptions = new ClearCacheFilesOptions();
		clearCacheFilesOptions.ClearMode = clearMode.ToString();
		clearCacheFilesOptions.ClearParam = clearParam;
		ClearCacheFilesOperation clearCacheFilesOperation = _playModeImpl.ClearCacheFilesAsync(clearCacheFilesOptions);
		OperationSystem.StartOperation(PackageName, clearCacheFilesOperation);
		return clearCacheFilesOperation;
	}

	public ClearCacheFilesOperation ClearCacheFilesAsync(string clearMode, object clearParam = null)
	{
		ClearCacheFilesOptions clearCacheFilesOptions = new ClearCacheFilesOptions();
		clearCacheFilesOptions.ClearMode = clearMode;
		clearCacheFilesOptions.ClearParam = clearParam;
		ClearCacheFilesOperation clearCacheFilesOperation = _playModeImpl.ClearCacheFilesAsync(clearCacheFilesOptions);
		OperationSystem.StartOperation(PackageName, clearCacheFilesOperation);
		return clearCacheFilesOperation;
	}

	public string GetPackageVersion()
	{
		return _playModeImpl.ActiveManifest.PackageVersion;
	}

	public string GetPackageNote()
	{
		return _playModeImpl.ActiveManifest.PackageNote;
	}

	public PackageDetails GetPackageDetails()
	{
		return _playModeImpl.ActiveManifest.GetPackageDetails();
	}

	public UnloadAllAssetsOperation UnloadAllAssetsAsync()
	{
		UnloadAllAssetsOptions options = new UnloadAllAssetsOptions();
		return UnloadAllAssetsAsync(options);
	}

	public UnloadAllAssetsOperation UnloadAllAssetsAsync(UnloadAllAssetsOptions options)
	{
		UnloadAllAssetsOperation unloadAllAssetsOperation = new UnloadAllAssetsOperation(_resourceManager, options);
		OperationSystem.StartOperation(PackageName, unloadAllAssetsOperation);
		return unloadAllAssetsOperation;
	}

	public UnloadUnusedAssetsOperation UnloadUnusedAssetsAsync(int loopCount = 10)
	{
		UnloadUnusedAssetsOperation unloadUnusedAssetsOperation = new UnloadUnusedAssetsOperation(_resourceManager, loopCount);
		OperationSystem.StartOperation(PackageName, unloadUnusedAssetsOperation);
		return unloadUnusedAssetsOperation;
	}

	public void TryUnloadUnusedAsset(string location)
	{
		AssetInfo assetInfo = ConvertLocationToAssetInfo(location, null);
		_resourceManager.TryUnloadUnusedAsset(assetInfo);
	}

	public void TryUnloadUnusedAsset(AssetInfo assetInfo)
	{
		_resourceManager.TryUnloadUnusedAsset(assetInfo);
	}

	public bool IsNeedDownloadFromRemote(string location)
	{
		AssetInfo assetInfo = ConvertLocationToAssetInfo(location, null);
		return IsNeedDownloadFromRemoteInternal(assetInfo);
	}

	public bool IsNeedDownloadFromRemote(AssetInfo assetInfo)
	{
		return IsNeedDownloadFromRemoteInternal(assetInfo);
	}

	public AssetInfo[] GetAllAssetInfos()
	{
		return _playModeImpl.ActiveManifest.GetAllAssetInfos();
	}

	public AssetInfo[] GetAssetInfos(string tag)
	{
		string[] tags = new string[1] { tag };
		return _playModeImpl.ActiveManifest.GetAssetInfosByTags(tags);
	}

	public AssetInfo[] GetAssetInfos(string[] tags)
	{
		return _playModeImpl.ActiveManifest.GetAssetInfosByTags(tags);
	}

	public AssetInfo[] GetAssetInfosByAllTags(string[] tags)
	{
		return _playModeImpl.ActiveManifest.GetAssetInfosByAllTags(tags);
	}

	public AssetInfo GetAssetInfo(string location)
	{
		return ConvertLocationToAssetInfo(location, null);
	}

	public AssetInfo GetAssetInfo(string location, Type type)
	{
		return ConvertLocationToAssetInfo(location, type);
	}

	public AssetInfo GetAssetInfoByGUID(string assetGUID)
	{
		return ConvertLocationToAssetInfo(assetGUID, null);
	}

	public AssetInfo GetAssetInfoByGUID(string assetGUID, Type type)
	{
		return ConvertLocationToAssetInfo(assetGUID, type);
	}

	public bool CheckLocationValid(string location)
	{
		string value = ((!CheckGUID.IsUnityGUID(location)) ? _playModeImpl.ActiveManifest.TryMappingToAssetPath(location) : _playModeImpl.ActiveManifest.TryMappingGUIDToAssetPath(location));
		return !string.IsNullOrEmpty(value);
	}

	private bool IsNeedDownloadFromRemoteInternal(AssetInfo assetInfo)
	{
		if (assetInfo.IsInvalid)
		{
			YooLogger.Warning(assetInfo.Error);
			return false;
		}
		if (_bundleQuery.GetMainBundleInfo(assetInfo).IsNeedDownloadFromRemote())
		{
			return true;
		}
		BundleInfo[] dependBundleInfos = _bundleQuery.GetDependBundleInfos(assetInfo);
		for (int i = 0; i < dependBundleInfos.Length; i++)
		{
			if (dependBundleInfos[i].IsNeedDownloadFromRemote())
			{
				return true;
			}
		}
		return false;
	}

	public RawFileHandle LoadRawFileSync(AssetInfo assetInfo)
	{
		return LoadRawFileInternal(assetInfo, waitForAsyncComplete: true, 0u);
	}

	public RawFileHandle LoadRawFileSync(string location)
	{
		AssetInfo assetInfo = ConvertLocationToAssetInfo(location, null);
		return LoadRawFileInternal(assetInfo, waitForAsyncComplete: true, 0u);
	}

	public RawFileHandle LoadRawFileAsync(AssetInfo assetInfo, uint priority = 0u)
	{
		return LoadRawFileInternal(assetInfo, waitForAsyncComplete: false, priority);
	}

	public RawFileHandle LoadRawFileAsync(string location, uint priority = 0u)
	{
		AssetInfo assetInfo = ConvertLocationToAssetInfo(location, null);
		return LoadRawFileInternal(assetInfo, waitForAsyncComplete: false, priority);
	}

	private RawFileHandle LoadRawFileInternal(AssetInfo assetInfo, bool waitForAsyncComplete, uint priority)
	{
		RawFileHandle rawFileHandle = _resourceManager.LoadRawFileAsync(assetInfo, priority);
		if (waitForAsyncComplete)
		{
			rawFileHandle.WaitForAsyncComplete();
		}
		return rawFileHandle;
	}

	public SceneHandle LoadSceneSync(string location, LoadSceneMode sceneMode = LoadSceneMode.Single, LocalPhysicsMode physicsMode = LocalPhysicsMode.None)
	{
		AssetInfo assetInfo = ConvertLocationToAssetInfo(location, null);
		return LoadSceneInternal(assetInfo, waitForAsyncComplete: true, sceneMode, physicsMode, suspendLoad: false, 0u);
	}

	public SceneHandle LoadSceneSync(AssetInfo assetInfo, LoadSceneMode sceneMode = LoadSceneMode.Single, LocalPhysicsMode physicsMode = LocalPhysicsMode.None)
	{
		return LoadSceneInternal(assetInfo, waitForAsyncComplete: true, sceneMode, physicsMode, suspendLoad: false, 0u);
	}

	public SceneHandle LoadSceneAsync(string location, LoadSceneMode sceneMode = LoadSceneMode.Single, LocalPhysicsMode physicsMode = LocalPhysicsMode.None, bool suspendLoad = false, uint priority = 0u)
	{
		AssetInfo assetInfo = ConvertLocationToAssetInfo(location, null);
		return LoadSceneInternal(assetInfo, waitForAsyncComplete: false, sceneMode, physicsMode, suspendLoad, priority);
	}

	public SceneHandle LoadSceneAsync(AssetInfo assetInfo, LoadSceneMode sceneMode = LoadSceneMode.Single, LocalPhysicsMode physicsMode = LocalPhysicsMode.None, bool suspendLoad = false, uint priority = 0u)
	{
		return LoadSceneInternal(assetInfo, waitForAsyncComplete: false, sceneMode, physicsMode, suspendLoad, priority);
	}

	private SceneHandle LoadSceneInternal(AssetInfo assetInfo, bool waitForAsyncComplete, LoadSceneMode sceneMode, LocalPhysicsMode physicsMode, bool suspendLoad, uint priority)
	{
		assetInfo.LoadMethod = AssetInfo.ELoadMethod.LoadScene;
		LoadSceneParameters loadSceneParams = new LoadSceneParameters(sceneMode, physicsMode);
		SceneHandle sceneHandle = _resourceManager.LoadSceneAsync(assetInfo, loadSceneParams, suspendLoad, priority);
		if (waitForAsyncComplete)
		{
			sceneHandle.WaitForAsyncComplete();
		}
		return sceneHandle;
	}

	public AssetHandle LoadAssetSync(AssetInfo assetInfo)
	{
		return LoadAssetInternal(assetInfo, waitForAsyncComplete: true, 0u);
	}

	public AssetHandle LoadAssetSync<TObject>(string location) where TObject : UnityEngine.Object
	{
		AssetInfo assetInfo = ConvertLocationToAssetInfo(location, typeof(TObject));
		return LoadAssetInternal(assetInfo, waitForAsyncComplete: true, 0u);
	}

	public AssetHandle LoadAssetSync(string location, Type type)
	{
		AssetInfo assetInfo = ConvertLocationToAssetInfo(location, type);
		return LoadAssetInternal(assetInfo, waitForAsyncComplete: true, 0u);
	}

	public AssetHandle LoadAssetSync(string location)
	{
		Type typeFromHandle = typeof(UnityEngine.Object);
		AssetInfo assetInfo = ConvertLocationToAssetInfo(location, typeFromHandle);
		return LoadAssetInternal(assetInfo, waitForAsyncComplete: true, 0u);
	}

	public AssetHandle LoadAssetAsync(AssetInfo assetInfo, uint priority = 0u)
	{
		return LoadAssetInternal(assetInfo, waitForAsyncComplete: false, priority);
	}

	public AssetHandle LoadAssetAsync<TObject>(string location, uint priority = 0u) where TObject : UnityEngine.Object
	{
		AssetInfo assetInfo = ConvertLocationToAssetInfo(location, typeof(TObject));
		return LoadAssetInternal(assetInfo, waitForAsyncComplete: false, priority);
	}

	public AssetHandle LoadAssetAsync(string location, Type type, uint priority = 0u)
	{
		AssetInfo assetInfo = ConvertLocationToAssetInfo(location, type);
		return LoadAssetInternal(assetInfo, waitForAsyncComplete: false, priority);
	}

	public AssetHandle LoadAssetAsync(string location, uint priority = 0u)
	{
		Type typeFromHandle = typeof(UnityEngine.Object);
		AssetInfo assetInfo = ConvertLocationToAssetInfo(location, typeFromHandle);
		return LoadAssetInternal(assetInfo, waitForAsyncComplete: false, priority);
	}

	private AssetHandle LoadAssetInternal(AssetInfo assetInfo, bool waitForAsyncComplete, uint priority)
	{
		assetInfo.LoadMethod = AssetInfo.ELoadMethod.LoadAsset;
		AssetHandle assetHandle = _resourceManager.LoadAssetAsync(assetInfo, priority);
		if (waitForAsyncComplete)
		{
			assetHandle.WaitForAsyncComplete();
		}
		return assetHandle;
	}

	public SubAssetsHandle LoadSubAssetsSync(AssetInfo assetInfo)
	{
		return LoadSubAssetsInternal(assetInfo, waitForAsyncComplete: true, 0u);
	}

	public SubAssetsHandle LoadSubAssetsSync<TObject>(string location) where TObject : UnityEngine.Object
	{
		AssetInfo assetInfo = ConvertLocationToAssetInfo(location, typeof(TObject));
		return LoadSubAssetsInternal(assetInfo, waitForAsyncComplete: true, 0u);
	}

	public SubAssetsHandle LoadSubAssetsSync(string location, Type type)
	{
		AssetInfo assetInfo = ConvertLocationToAssetInfo(location, type);
		return LoadSubAssetsInternal(assetInfo, waitForAsyncComplete: true, 0u);
	}

	public SubAssetsHandle LoadSubAssetsSync(string location)
	{
		Type typeFromHandle = typeof(UnityEngine.Object);
		AssetInfo assetInfo = ConvertLocationToAssetInfo(location, typeFromHandle);
		return LoadSubAssetsInternal(assetInfo, waitForAsyncComplete: true, 0u);
	}

	public SubAssetsHandle LoadSubAssetsAsync(AssetInfo assetInfo, uint priority = 0u)
	{
		return LoadSubAssetsInternal(assetInfo, waitForAsyncComplete: false, priority);
	}

	public SubAssetsHandle LoadSubAssetsAsync<TObject>(string location, uint priority = 0u) where TObject : UnityEngine.Object
	{
		AssetInfo assetInfo = ConvertLocationToAssetInfo(location, typeof(TObject));
		return LoadSubAssetsInternal(assetInfo, waitForAsyncComplete: false, priority);
	}

	public SubAssetsHandle LoadSubAssetsAsync(string location, Type type, uint priority = 0u)
	{
		AssetInfo assetInfo = ConvertLocationToAssetInfo(location, type);
		return LoadSubAssetsInternal(assetInfo, waitForAsyncComplete: false, priority);
	}

	public SubAssetsHandle LoadSubAssetsAsync(string location, uint priority = 0u)
	{
		Type typeFromHandle = typeof(UnityEngine.Object);
		AssetInfo assetInfo = ConvertLocationToAssetInfo(location, typeFromHandle);
		return LoadSubAssetsInternal(assetInfo, waitForAsyncComplete: false, priority);
	}

	private SubAssetsHandle LoadSubAssetsInternal(AssetInfo assetInfo, bool waitForAsyncComplete, uint priority)
	{
		assetInfo.LoadMethod = AssetInfo.ELoadMethod.LoadSubAssets;
		SubAssetsHandle subAssetsHandle = _resourceManager.LoadSubAssetsAsync(assetInfo, priority);
		if (waitForAsyncComplete)
		{
			subAssetsHandle.WaitForAsyncComplete();
		}
		return subAssetsHandle;
	}

	public AllAssetsHandle LoadAllAssetsSync(AssetInfo assetInfo)
	{
		return LoadAllAssetsInternal(assetInfo, waitForAsyncComplete: true, 0u);
	}

	public AllAssetsHandle LoadAllAssetsSync<TObject>(string location) where TObject : UnityEngine.Object
	{
		AssetInfo assetInfo = ConvertLocationToAssetInfo(location, typeof(TObject));
		return LoadAllAssetsInternal(assetInfo, waitForAsyncComplete: true, 0u);
	}

	public AllAssetsHandle LoadAllAssetsSync(string location, Type type)
	{
		AssetInfo assetInfo = ConvertLocationToAssetInfo(location, type);
		return LoadAllAssetsInternal(assetInfo, waitForAsyncComplete: true, 0u);
	}

	public AllAssetsHandle LoadAllAssetsSync(string location)
	{
		Type typeFromHandle = typeof(UnityEngine.Object);
		AssetInfo assetInfo = ConvertLocationToAssetInfo(location, typeFromHandle);
		return LoadAllAssetsInternal(assetInfo, waitForAsyncComplete: true, 0u);
	}

	public AllAssetsHandle LoadAllAssetsAsync(AssetInfo assetInfo, uint priority = 0u)
	{
		return LoadAllAssetsInternal(assetInfo, waitForAsyncComplete: false, priority);
	}

	public AllAssetsHandle LoadAllAssetsAsync<TObject>(string location, uint priority = 0u) where TObject : UnityEngine.Object
	{
		AssetInfo assetInfo = ConvertLocationToAssetInfo(location, typeof(TObject));
		return LoadAllAssetsInternal(assetInfo, waitForAsyncComplete: false, priority);
	}

	public AllAssetsHandle LoadAllAssetsAsync(string location, Type type, uint priority = 0u)
	{
		AssetInfo assetInfo = ConvertLocationToAssetInfo(location, type);
		return LoadAllAssetsInternal(assetInfo, waitForAsyncComplete: false, priority);
	}

	public AllAssetsHandle LoadAllAssetsAsync(string location, uint priority = 0u)
	{
		Type typeFromHandle = typeof(UnityEngine.Object);
		AssetInfo assetInfo = ConvertLocationToAssetInfo(location, typeFromHandle);
		return LoadAllAssetsInternal(assetInfo, waitForAsyncComplete: false, priority);
	}

	private AllAssetsHandle LoadAllAssetsInternal(AssetInfo assetInfo, bool waitForAsyncComplete, uint priority)
	{
		assetInfo.LoadMethod = AssetInfo.ELoadMethod.LoadAllAssets;
		AllAssetsHandle allAssetsHandle = _resourceManager.LoadAllAssetsAsync(assetInfo, priority);
		if (waitForAsyncComplete)
		{
			allAssetsHandle.WaitForAsyncComplete();
		}
		return allAssetsHandle;
	}

	public ResourceDownloaderOperation CreateResourceDownloader(int downloadingMaxNumber, int failedTryAgain, int timeout = 60)
	{
		return _playModeImpl.CreateResourceDownloaderByAll(downloadingMaxNumber, failedTryAgain, timeout);
	}

	public ResourceDownloaderOperation CreateResourceDownloader(string tag, int downloadingMaxNumber, int failedTryAgain, int timeout = 60)
	{
		return _playModeImpl.CreateResourceDownloaderByTags(new string[1] { tag }, downloadingMaxNumber, failedTryAgain, timeout);
	}

	public ResourceDownloaderOperation CreateResourceDownloader(string[] tags, int downloadingMaxNumber, int failedTryAgain, int timeout = 60)
	{
		return _playModeImpl.CreateResourceDownloaderByTags(tags, downloadingMaxNumber, failedTryAgain, timeout);
	}

	public ResourceDownloaderOperation CreateResourceDownloaderByDownloadTag(string downloadTag, int downloadingMaxNumber, int failedTryAgain, int timeout = 60)
	{
		return _playModeImpl.CreateResourceDownloaderByDownloadTag(downloadTag, downloadingMaxNumber, failedTryAgain, timeout);
	}

	public ResourceDownloaderOperation CreateResourceDownloaderByDownloadTags(string[] downloadTags, int downloadingMaxNumber, int failedTryAgain, int timeout = 60)
	{
		return _playModeImpl.CreateResourceDownloaderByDownloadTags(downloadTags, downloadingMaxNumber, failedTryAgain, timeout);
	}

	public ResourceDownloaderOperation CreateBundleDownloader(string location, bool recursiveDownload, int downloadingMaxNumber, int failedTryAgain, int timeout = 60)
	{
		AssetInfo assetInfo = ConvertLocationToAssetInfo(location, null);
		AssetInfo[] assetInfos = new AssetInfo[1] { assetInfo };
		return _playModeImpl.CreateResourceDownloaderByPaths(assetInfos, recursiveDownload, downloadingMaxNumber, failedTryAgain, timeout);
	}

	public ResourceDownloaderOperation CreateBundleDownloader(string location, int downloadingMaxNumber, int failedTryAgain, int timeout = 60)
	{
		return CreateBundleDownloader(location, recursiveDownload: false, downloadingMaxNumber, failedTryAgain, timeout);
	}

	public ResourceDownloaderOperation CreateBundleDownloader(string[] locations, bool recursiveDownload, int downloadingMaxNumber, int failedTryAgain, int timeout = 60)
	{
		List<AssetInfo> list = new List<AssetInfo>(locations.Length);
		foreach (string location in locations)
		{
			AssetInfo item = ConvertLocationToAssetInfo(location, null);
			list.Add(item);
		}
		return _playModeImpl.CreateResourceDownloaderByPaths(list.ToArray(), recursiveDownload, downloadingMaxNumber, failedTryAgain, timeout);
	}

	public ResourceDownloaderOperation CreateBundleDownloader(string[] locations, int downloadingMaxNumber, int failedTryAgain, int timeout = 60)
	{
		return CreateBundleDownloader(locations, recursiveDownload: false, downloadingMaxNumber, failedTryAgain, timeout);
	}

	public ResourceDownloaderOperation CreateBundleDownloader(AssetInfo assetInfo, bool recursiveDownload, int downloadingMaxNumber, int failedTryAgain, int timeout = 60)
	{
		AssetInfo[] assetInfos = new AssetInfo[1] { assetInfo };
		return _playModeImpl.CreateResourceDownloaderByPaths(assetInfos, recursiveDownload, downloadingMaxNumber, failedTryAgain, timeout);
	}

	public ResourceDownloaderOperation CreateBundleDownloader(AssetInfo assetInfo, int downloadingMaxNumber, int failedTryAgain, int timeout = 60)
	{
		return CreateBundleDownloader(assetInfo, recursiveDownload: false, downloadingMaxNumber, failedTryAgain, timeout);
	}

	public ResourceDownloaderOperation CreateBundleDownloader(AssetInfo[] assetInfos, bool recursiveDownload, int downloadingMaxNumber, int failedTryAgain, int timeout = 60)
	{
		return _playModeImpl.CreateResourceDownloaderByPaths(assetInfos, recursiveDownload, downloadingMaxNumber, failedTryAgain, timeout);
	}

	public ResourceDownloaderOperation CreateBundleDownloader(AssetInfo[] assetInfos, int downloadingMaxNumber, int failedTryAgain, int timeout = 60)
	{
		return CreateBundleDownloader(assetInfos, recursiveDownload: false, downloadingMaxNumber, failedTryAgain, timeout);
	}

	public ResourceUnpackerOperation CreateResourceUnpacker(int unpackingMaxNumber, int failedTryAgain)
	{
		return _playModeImpl.CreateResourceUnpackerByAll(unpackingMaxNumber, failedTryAgain, int.MaxValue);
	}

	public ResourceUnpackerOperation CreateResourceUnpacker(string tag, int unpackingMaxNumber, int failedTryAgain)
	{
		return _playModeImpl.CreateResourceUnpackerByTags(new string[1] { tag }, unpackingMaxNumber, failedTryAgain, int.MaxValue);
	}

	public ResourceUnpackerOperation CreateResourceUnpacker(string[] tags, int unpackingMaxNumber, int failedTryAgain)
	{
		return _playModeImpl.CreateResourceUnpackerByTags(tags, unpackingMaxNumber, failedTryAgain, int.MaxValue);
	}

	public ResourceImporterOperation CreateResourceImporter(string[] filePaths, int importerMaxNumber, int failedTryAgain)
	{
		return _playModeImpl.CreateResourceImporterByFilePaths(filePaths, importerMaxNumber, failedTryAgain, int.MaxValue);
	}

	private AssetInfo ConvertLocationToAssetInfo(string location, Type assetType)
	{
		AssetInfo assetInfo = null;
		if (CheckGUID.IsUnityGUID(location))
		{
			return ConvertAssetGUIDToAssetInfo(location, assetType);
		}
		return ConvertAddressToAssetInfo(location, assetType);
	}

	private AssetInfo ConvertAddressToAssetInfo(string assetGUID, Type assetType)
	{
		return _playModeImpl.ActiveManifest.ConvertLocationToAssetInfo(assetGUID, assetType);
	}

	private AssetInfo ConvertAssetGUIDToAssetInfo(string assetGUID, Type assetType)
	{
		return _playModeImpl.ActiveManifest.ConvertAssetGUIDToAssetInfo(assetGUID, assetType);
	}

	[Conditional("DEBUG")]
	private void DebugCheckInitialize(bool checkActiveManifest = true)
	{
		if (_initializeStatus == EOperationStatus.None)
		{
			throw new Exception("Package initialize not completed !");
		}
		if (_initializeStatus == EOperationStatus.Failed)
		{
			throw new Exception("Package initialize failed ! " + _initializeError);
		}
		if (checkActiveManifest && _playModeImpl.ActiveManifest == null)
		{
			throw new Exception("Can not found active package manifest !");
		}
	}

	[Conditional("DEBUG")]
	private void DebugCheckAssetLoadType(Type type)
	{
		if (!(type == null))
		{
			if (typeof(Behaviour).IsAssignableFrom(type))
			{
				throw new Exception("Load asset type is invalid : " + type.FullName + " !");
			}
			if (!typeof(UnityEngine.Object).IsAssignableFrom(type))
			{
				throw new Exception("Load asset type is invalid : " + type.FullName + " !");
			}
		}
	}

	internal DebugPackageData GetDebugPackageData()
	{
		return new DebugPackageData
		{
			PackageName = PackageName,
			ProviderInfos = _resourceManager.GetDebugProviderInfos(),
			BundleInfos = _resourceManager.GetDebugBundleInfos(),
			OperationInfos = OperationSystem.GetDebugOperationInfos(PackageName)
		};
	}
}
