#define ENABLE_ERROR_AND_ABOVE_LOG
#define ENABLE_WARNING_AND_ABOVE_LOG
using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Threading;
using Cysharp.Text;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.SceneManagement;
using YooAsset;

namespace GameFramework.Resource;

internal sealed class ResourceManager : GameFrameworkModule, IResourceManager
{
	private abstract class HandleBase : IReference
	{
		public abstract UniTask<bool> Release();

		public virtual void Clear()
		{
		}
	}

	private class SingleAssetHandle : HandleBase
	{
		private AssetHandle handle;

		public static SingleAssetHandle Create(AssetHandle assetHandle)
		{
			SingleAssetHandle singleAssetHandle = ReferencePool.Acquire<SingleAssetHandle>();
			singleAssetHandle.handle = assetHandle;
			return singleAssetHandle;
		}

		public T GetAsset<T>() where T : UnityEngine.Object
		{
			if (handle == null)
			{
				return null;
			}
			if (!((HandleBase)handle).IsValid || handle.AssetObject == null)
			{
				Log.Error("Asset handle is invalid.");
				return null;
			}
			return handle.GetAssetObject<T>();
		}

		public override UniTask<bool> Release()
		{
			ReferencePool.Release(this);
			return UniTask.FromResult(value: true);
		}

		public override void Clear()
		{
			if (handle != null)
			{
				((HandleBase)handle).Release();
				handle = null;
			}
		}
	}

	private class MultipleAssetHandle : HandleBase
	{
		private AllAssetsHandle handle;

		public static MultipleAssetHandle Create(AllAssetsHandle assetHandle)
		{
			MultipleAssetHandle multipleAssetHandle = ReferencePool.Acquire<MultipleAssetHandle>();
			multipleAssetHandle.handle = assetHandle;
			return multipleAssetHandle;
		}

		public IReadOnlyList<T> GetAllAsset<T>() where T : UnityEngine.Object
		{
			if (handle == null)
			{
				return Array.Empty<T>();
			}
			T[] array = new T[handle.AllAssetObjects.Count];
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = handle.AllAssetObjects[i] as T;
			}
			return array;
		}

		public override UniTask<bool> Release()
		{
			ReferencePool.Release(this);
			return UniTask.FromResult(value: true);
		}

		public override void Clear()
		{
			if (handle != null)
			{
				((HandleBase)handle).Release();
				handle = null;
			}
		}
	}

	private class InstantiateHandle : HandleBase
	{
		private AssetHandle handle;

		public static InstantiateHandle Create(AssetHandle assetHandle)
		{
			InstantiateHandle instantiateHandle = ReferencePool.Acquire<InstantiateHandle>();
			instantiateHandle.handle = assetHandle;
			return instantiateHandle;
		}

		public T GetAsset<T>() where T : UnityEngine.Object
		{
			if (handle == null)
			{
				return null;
			}
			if (!((HandleBase)handle).IsValid || handle.AssetObject == null)
			{
				Log.Error("Asset handle is invalid.");
				return null;
			}
			return handle.GetAssetObject<T>();
		}

		public override UniTask<bool> Release()
		{
			ReferencePool.Release(this);
			return UniTask.FromResult(value: true);
		}

		public override void Clear()
		{
			if (handle != null)
			{
				((HandleBase)handle).Release();
				handle = null;
			}
		}
	}

	private class SceneAssetHandle : HandleBase
	{
		private SceneHandle handle;

		public static SceneAssetHandle Create(SceneHandle sceneHandle)
		{
			SceneAssetHandle sceneAssetHandle = ReferencePool.Acquire<SceneAssetHandle>();
			sceneAssetHandle.handle = sceneHandle;
			return sceneAssetHandle;
		}

		public override async UniTask<bool> Release()
		{
			if (handle == null)
			{
				return false;
			}
			UnloadSceneOperation unloadAsync = handle.UnloadAsync();
			while (!((AsyncOperationBase)unloadAsync).IsDone)
			{
				await UniTask.Yield(PlayerLoopTiming.LastPostLateUpdate);
			}
			handle = null;
			ReferencePool.Release(this);
			return true;
		}

		public override void Clear()
		{
			if (handle != null)
			{
				((HandleBase)handle).Release();
				handle = null;
			}
		}
	}

	private sealed class AssetToken
	{
		public int TokenId { get; set; }

		public string Key { get; set; }

		public int InstanceId { get; set; }

		public HandleBase Handle { get; set; }

		public bool Alive { get; set; }
	}

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private EPlayMode _003CPlayMode_003Ek__BackingField;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private EFileVerifyLevel _003CVerifyLevel_003Ek__BackingField;

	private IResourceHelper m_ResourceHelper;

	private string m_ApplicableGameVersion;

	private int m_InternalResourceVersion;

	private YooObjectHub refManager;

	private readonly List<AssetToken> _entries = new List<AssetToken>();

	private readonly Stack<int> _freeIds = new Stack<int>();

	private readonly Dictionary<string, HashSet<int>> _byKey = new Dictionary<string, HashSet<int>>();

	private readonly Dictionary<int, HashSet<int>> _byInstance = new Dictionary<int, HashSet<int>>();

	public string PackageName { get; set; } = "DefaultPackage";

	public EPlayMode PlayMode
	{
		[CompilerGenerated]
		get
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return _003CPlayMode_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			//IL_0002: Unknown result type (might be due to invalid IL or missing references)
			_003CPlayMode_003Ek__BackingField = value;
		}
	}

	public EFileVerifyLevel VerifyLevel
	{
		[CompilerGenerated]
		get
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return _003CVerifyLevel_003Ek__BackingField;
		}
		[CompilerGenerated]
		set
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			//IL_0002: Unknown result type (might be due to invalid IL or missing references)
			_003CVerifyLevel_003Ek__BackingField = value;
		}
	}

	public long Milliseconds { get; set; }

	public int BundleLoadingMaxConcurrency { get; set; }

	internal override int Priority => 4;

	public Transform InstanceRoot { get; set; }

	public ResourceHelper ResourceHelper { get; private set; }

	public CancellationToken CancellationToken { get; private set; }

	public string ApplicableGameVersion => m_ApplicableGameVersion;

	public int InternalResourceVersion => m_InternalResourceVersion;

	public int DownloadingMaxNum { get; set; }

	public int FailedTryAgain { get; set; }

	internal ResourcePackage DefaultPackage { get; private set; }

	private Dictionary<string, ResourcePackage> m_PackageMap { get; } = new Dictionary<string, ResourcePackage>();

	public T LoadAsset<T>(string location, string packageName = "") where T : UnityEngine.Object
	{
		if (string.IsNullOrEmpty(location))
		{
			Log.Error("Asset location is invalid.");
			return null;
		}
		packageName = GetPackageName(packageName);
		ResourcePackage package = YooAssets.GetPackage(packageName);
		if (package == null)
		{
			Log.Error("Package not found: " + packageName);
			return null;
		}
		AssetHandle val = package.LoadAssetSync<T>(location);
		if (val == null)
		{
			return null;
		}
		SingleAssetHandle singleAssetHandle = SingleAssetHandle.Create(val);
		T asset = singleAssetHandle.GetAsset<T>();
		RegisterToken(location, packageName, asset.GetInstanceID(), singleAssetHandle);
		return asset;
	}

	public async void LoadAssetAsync(string location, LoadAssetCallbacks loadAssetCallbacks, object userData, string packageName = "")
	{
		if (loadAssetCallbacks == null)
		{
			throw new GameFrameworkException("Load asset callbacks is invalid.");
		}
		try
		{
			float duration = Time.time;
			UnityEngine.Object asset = await LoadAssetAsync<UnityEngine.Object>(location, packageName, CancellationToken);
			loadAssetCallbacks.LoadAssetSuccessCallback(location, packageName, asset, Time.time - duration, userData);
		}
		catch (Exception ex)
		{
			loadAssetCallbacks.LoadAssetFailureCallback(location, LoadResourceStatus.AssetError, ex.Message, userData);
		}
	}

	public async UniTask<T> LoadAssetAsync<T>(string location, string packageName = "", CancellationToken cancellationToken = default(CancellationToken)) where T : UnityEngine.Object
	{
		if (string.IsNullOrEmpty(location))
		{
			throw new GameFrameworkException("Asset name is invalid.");
		}
		packageName = GetPackageName(packageName);
		AssetHandle handle = await LoadAssetCore<T>(location, packageName, cancellationToken);
		if (handle == null)
		{
			return null;
		}
		SingleAssetHandle assetHandle = SingleAssetHandle.Create(handle);
		T asset = assetHandle.GetAsset<T>();
		RegisterToken(location, packageName, asset.GetInstanceID(), assetHandle);
		return asset;
	}

	public async UniTask<IReadOnlyList<T>> LoadAllAssetAsync<T>(string location, string packageName = "", CancellationToken cancellationToken = default(CancellationToken)) where T : UnityEngine.Object
	{
		if (string.IsNullOrEmpty(location))
		{
			throw new GameFrameworkException("Asset name is invalid.");
		}
		packageName = GetPackageName(packageName);
		ResourcePackage package = YooAssets.GetPackage(packageName);
		if (package == null)
		{
			throw new GameFrameworkException("The package does not exist. Package Name :" + packageName);
		}
		AllAssetsHandle handle = package.LoadAllAssetsAsync<T>(location, 0u);
		if (await ((HandleBase)(object)handle).ToUniTask().AttachExternalCancellation(cancellationToken).SuppressCancellationThrow())
		{
			((HandleBase)handle).Release();
			return Array.Empty<T>();
		}
		MultipleAssetHandle assetObject = MultipleAssetHandle.Create(handle);
		RegisterToken(location, packageName, 0, assetObject);
		return assetObject.GetAllAsset<T>();
	}

	public void UnloadAsset(string location, string packageName = "")
	{
		if (!string.IsNullOrEmpty(location))
		{
			packageName = GetPackageName(packageName);
			UnloadToken(location, packageName);
		}
	}

	public void UnloadAsset(UnityEngine.Object obj)
	{
		if (obj == null)
		{
			Log.Warning("Unloaded asset fail~ object is invalid.");
		}
		else
		{
			UnloadToken(obj);
		}
	}

	private async UniTask<AssetHandle> LoadAssetCore<T>(string location, string packageName = "", CancellationToken cancellationToken = default(CancellationToken)) where T : UnityEngine.Object
	{
		if (string.IsNullOrEmpty(location))
		{
			Log.Error("Asset location is invalid.");
			return null;
		}
		packageName = GetPackageName(packageName);
		ResourcePackage pkg = YooAssets.GetPackage(packageName);
		if (pkg == null)
		{
			Log.Error("Package not found: " + packageName);
			return null;
		}
		AssetHandle handle = pkg.LoadAssetAsync<T>(location, 0u);
		await ((IEnumerator)handle).ToUniTask(PlayerLoopTiming.Update, cancellationToken);
		return handle;
	}

	public ResourceManager()
	{
		m_ResourceHelper = null;
	}

	public void Initialize()
	{
		if (!YooAssets.Initialized)
		{
			YooAssets.Initialize((ILogger)null);
		}
		YooAssets.SetOperationSystemMaxTimeSlice(Milliseconds);
		string packageName = PackageName;
		ResourcePackage val = YooAssets.TryGetPackage(packageName);
		if (val == null)
		{
			val = YooAssets.CreatePackage(packageName);
			YooAssets.SetDefaultPackage(val);
			DefaultPackage = val;
		}
		ResourceHelper = InstanceRoot.gameObject.AddComponent<ResourceHelper>();
		CancellationToken = ResourceHelper.GetCancellationTokenOnDestroy();
		refManager = new YooObjectHub(packageName, 5f);
	}

	public void SetResourceHelper(IResourceHelper resourceHelper)
	{
		if (resourceHelper == null)
		{
			throw new GameFrameworkException("Resource helper is invalid.");
		}
		m_ResourceHelper = resourceHelper;
	}

	public async UniTask<InitializationOperation> InitPackage(string packageName)
	{
		if (m_PackageMap.ContainsKey(packageName))
		{
			Log.Error("ResourceSystem has already init package : " + packageName);
			return null;
		}
		ResourcePackage package = YooAssets.TryGetPackage(packageName);
		if (package == null)
		{
			package = YooAssets.CreatePackage(packageName);
		}
		m_PackageMap[packageName] = package;
		InitializationOperation initializationOperation = null;
		if ((int)PlayMode == 0)
		{
			PackageInvokeBuildResult buildResult = EditorSimulateModeHelper.SimulateBuild(packageName);
			string packageRoot = buildResult.PackageRootDirectory;
			EditorSimulateModeParameters createParameters = new EditorSimulateModeParameters();
			createParameters.EditorFileSystemParameters = FileSystemParameters.CreateDefaultEditorFileSystemParameters(packageRoot);
			initializationOperation = package.InitializeAsync((InitializeParameters)(object)createParameters);
		}
		if ((int)PlayMode == 1)
		{
			OfflinePlayModeParameters createParameters2 = new OfflinePlayModeParameters();
			createParameters2.BuildinFileSystemParameters = FileSystemParameters.CreateDefaultBuildinFileSystemParameters((IDecryptionServices)null, (string)null);
			initializationOperation = package.InitializeAsync((InitializeParameters)(object)createParameters2);
		}
		if ((int)PlayMode == 2)
		{
			string defaultHostServer = m_ResourceHelper.GetRemoteMainURL(packageName);
			string fallbackHostServer = m_ResourceHelper.GetRemoteFallbackURL(packageName);
			IRemoteServices remoteServices = m_ResourceHelper.GetRemoteServices(defaultHostServer, fallbackHostServer);
			HostPlayModeParameters createParameters3 = new HostPlayModeParameters();
			((InitializeParameters)createParameters3).BundleLoadingMaxConcurrency = BundleLoadingMaxConcurrency;
			createParameters3.BuildinFileSystemParameters = FileSystemParameters.CreateDefaultBuildinFileSystemParameters((IDecryptionServices)null, (string)null);
			createParameters3.CacheFileSystemParameters = FileSystemParameters.CreateDefaultCacheFileSystemParameters(remoteServices, (IDecryptionServices)null, (string)null);
			createParameters3.BuildinFileSystemParameters.AddParameter("FILE_VERIFY_LEVEL", (object)VerifyLevel);
			createParameters3.CacheFileSystemParameters.AddParameter("FILE_VERIFY_LEVEL", (object)VerifyLevel);
			initializationOperation = package.InitializeAsync((InitializeParameters)(object)createParameters3);
		}
		if ((int)PlayMode == 3)
		{
			WebPlayModeParameters createParameters4 = new WebPlayModeParameters();
			createParameters4.WebServerFileSystemParameters = FileSystemParameters.CreateDefaultWebServerFileSystemParameters(m_ResourceHelper.GetWebDecryption(), false);
			initializationOperation = package.InitializeAsync((InitializeParameters)(object)createParameters4);
		}
		await ((AsyncOperationBase)(object)initializationOperation).ToUniTask();
		return initializationOperation;
	}

	public async UniTask<bool> ClearCacheBundleFiles(string packageName, EFileClearMode clearMode, object clearParam = null)
	{
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		ResourcePackage package = YooAssets.GetPackage(packageName);
		ClearCacheFilesOperation operation = package.ClearCacheFilesAsync(clearMode, clearParam);
		await (AsyncOperationBase)(object)operation;
		if ((int)((AsyncOperationBase)operation).Status == 2)
		{
			return true;
		}
		throw new GameFrameworkException(packageName + " ClearCacheBundleFiles is failed.");
	}

	public async UniTask RemovePackage(string packageName)
	{
		if (!m_PackageMap.ContainsKey(packageName))
		{
			Log.Error("ResourceSystem has not init package : " + packageName);
			return;
		}
		ResourcePackage package = YooAssets.TryGetPackage(packageName);
		if (package != null)
		{
			m_PackageMap.Remove(packageName);
			await (AsyncOperationBase)(object)package.DestroyAsync();
			YooAssets.RemovePackage(package);
		}
	}

	public async UniTask RemoveAllPackage()
	{
		try
		{
			foreach (KeyValuePair<string, ResourcePackage> package in m_PackageMap)
			{
				await (AsyncOperationBase)(object)package.Value.DestroyAsync();
				YooAssets.RemovePackage(package.Value);
			}
			m_PackageMap.Clear();
		}
		catch (Exception ex)
		{
			Exception e = ex;
			Log.Error(e);
		}
	}

	internal override void Update(float elapseSeconds, float realElapseSeconds)
	{
		if (refManager != null)
		{
			refManager.SweepIdleAsync();
		}
	}

	internal override void Shutdown()
	{
		ForceUnloadAllAssets();
		RemoveAllPackage();
		refManager.ShutdownAsync();
	}

	public bool IsNeedDownloadFromRemote(string location, string packageName = "")
	{
		if (string.IsNullOrEmpty(packageName))
		{
			return YooAssets.IsNeedDownloadFromRemote(location);
		}
		ResourcePackage package = YooAssets.GetPackage(packageName);
		return package.IsNeedDownloadFromRemote(location);
	}

	public AssetData[] GetAssetInfos(string tag, string packageName = "")
	{
		if (string.IsNullOrWhiteSpace(tag))
		{
			return Array.Empty<AssetData>();
		}
		if (string.IsNullOrEmpty(packageName))
		{
			return GetAssetDatas(YooAssets.GetAssetInfos(tag));
		}
		ResourcePackage package = YooAssets.GetPackage(packageName);
		if (package == null)
		{
			return Array.Empty<AssetData>();
		}
		return GetAssetDatas(package.GetAssetInfos(tag));
	}

	public AssetData[] GetAssetInfos(string[] tags, string packageName = "")
	{
		if (tags == null || tags.Length == 0)
		{
			return Array.Empty<AssetData>();
		}
		if (string.IsNullOrEmpty(packageName))
		{
			return GetAssetDatas(YooAssets.GetAssetInfos(tags));
		}
		ResourcePackage package = YooAssets.GetPackage(packageName);
		if (package == null)
		{
			return Array.Empty<AssetData>();
		}
		return GetAssetDatas(package.GetAssetInfos(tags));
	}

	private AssetData[] GetAssetDatas(AssetInfo[] assetInfos)
	{
		if (assetInfos == null || assetInfos.Length == 0)
		{
			return Array.Empty<AssetData>();
		}
		AssetData[] array = new AssetData[assetInfos.Length];
		for (int i = 0; i < assetInfos.Length; i++)
		{
			AssetInfo val = assetInfos[i];
			if (val.IsInvalid)
			{
				array[i] = new AssetData(val.PackageName, val.Error);
			}
			else
			{
				array[i] = new AssetData(val.PackageName, val.AssetPath, val.Address, val.AssetType);
			}
		}
		return array;
	}

	public AssetInfo GetAssetInfo(string location, string packageName = "")
	{
		if (string.IsNullOrEmpty(location))
		{
			throw new GameFrameworkException("Asset name is invalid.");
		}
		if (string.IsNullOrEmpty(packageName))
		{
			return YooAssets.GetAssetInfo(location);
		}
		ResourcePackage package = YooAssets.GetPackage(packageName);
		if (package == null)
		{
			throw new GameFrameworkException("The package does not exist. Package Name :" + packageName);
		}
		return package.GetAssetInfo(location);
	}

	public HasAssetResult HasAsset(string location, string packageName = "")
	{
		if (string.IsNullOrEmpty(location))
		{
			throw new GameFrameworkException("Asset name is invalid.");
		}
		AssetInfo assetInfo = GetAssetInfo(location, packageName);
		if (!CheckLocationValid(location, packageName))
		{
			return HasAssetResult.Valid;
		}
		if (assetInfo == null)
		{
			return HasAssetResult.NotExist;
		}
		if (IsNeedDownloadFromRemote(assetInfo, packageName))
		{
			return HasAssetResult.AssetOnline;
		}
		return HasAssetResult.AssetOnDisk;
	}

	public bool CheckLocationValid(string location, string packageName = "")
	{
		if (string.IsNullOrEmpty(packageName))
		{
			return YooAssets.CheckLocationValid(location);
		}
		ResourcePackage package = YooAssets.GetPackage(packageName);
		return package.CheckLocationValid(location);
	}

	public bool IsNeedDownloadFromRemote(string location)
	{
		return YooAssets.IsNeedDownloadFromRemote(location);
	}

	public bool IsNeedDownloadFromRemote(AssetInfo assetInfo, string packageName = "")
	{
		if (string.IsNullOrEmpty(packageName))
		{
			return YooAssets.IsNeedDownloadFromRemote(assetInfo);
		}
		ResourcePackage package = YooAssets.GetPackage(packageName);
		return package.IsNeedDownloadFromRemote(assetInfo);
	}

	public AssetInfo[] GetAssetInfos(string tag)
	{
		return YooAssets.GetAssetInfos(tag);
	}

	public AssetInfo[] GetAssetInfos(string[] tags)
	{
		return YooAssets.GetAssetInfos(tags);
	}

	public AssetInfo GetAssetInfo(string location)
	{
		return YooAssets.GetAssetInfo(location);
	}

	public bool CheckLocationValid(string location)
	{
		return YooAssets.CheckLocationValid(location);
	}

	private string GetPackageName(string customPackageName)
	{
		if (string.IsNullOrEmpty(customPackageName))
		{
			return PackageName;
		}
		return customPackageName;
	}

	public void UnloadAllAssetHandler(string location, string packageName)
	{
		if (!string.IsNullOrEmpty(location) && string.IsNullOrEmpty(packageName))
		{
			packageName = PackageName;
		}
	}

	public void UnloadUnusedAssets()
	{
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Invalid comparison between Unknown and I4
		foreach (ResourcePackage value in m_PackageMap.Values)
		{
			if (value != null && (int)value.InitializeStatus == 2)
			{
				value.UnloadUnusedAssetsAsync(10);
			}
		}
	}

	public void ForceUnloadAllAssets()
	{
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Invalid comparison between Unknown and I4
		foreach (ResourcePackage value in m_PackageMap.Values)
		{
			if (value != null && (int)value.InitializeStatus == 2)
			{
				value.UnloadAllAssetsAsync();
			}
		}
	}

	private int RegisterToken(string location, string packageName, int instanceId, HandleBase handle)
	{
		string assetPath = GetAssetPath(location, packageName);
		return Register(assetPath, instanceId, handle);
	}

	private async UniTask<bool> UnloadToken(string location, string packageName = "")
	{
		string key = GetAssetPath(location, packageName);
		if (!_byKey.TryGetValue(key, out HashSet<int> setK) || setK.Count == 0)
		{
			return false;
		}
		if (!TryTakeOne(setK, out var id))
		{
			_byKey.Remove(key);
			return false;
		}
		AssetToken e = _entries[id];
		if (!e.Alive)
		{
			return false;
		}
		if (e.InstanceId != 0 && _byInstance.TryGetValue(e.InstanceId, out HashSet<int> setI))
		{
			setI.Remove(id);
			if (setI.Count == 0)
			{
				_byInstance.Remove(e.InstanceId);
			}
		}
		bool result = await Kill(e);
		if (setK.Count == 0)
		{
			_byKey.Remove(key);
		}
		return result;
	}

	private async UniTask<bool> UnloadToken(UnityEngine.Object obj)
	{
		if (obj == null)
		{
			return false;
		}
		int iid = obj.GetInstanceID();
		if (!_byInstance.TryGetValue(iid, out HashSet<int> setI) || setI.Count == 0)
		{
			return false;
		}
		if (!TryTakeOne(setI, out var id))
		{
			_byInstance.Remove(iid);
			return false;
		}
		AssetToken e = _entries[id];
		if (!e.Alive)
		{
			return false;
		}
		if (_byKey.TryGetValue(e.Key, out HashSet<int> setK))
		{
			setK.Remove(id);
			if (setK.Count == 0)
			{
				_byKey.Remove(e.Key);
			}
		}
		bool result = await Kill(e);
		if (setI.Count == 0)
		{
			_byInstance.Remove(iid);
		}
		return result;
	}

	public int UnloadAll(string location, string packageName = "")
	{
		string assetPath = GetAssetPath(location, packageName);
		if (!_byKey.TryGetValue(assetPath, out HashSet<int> value) || value.Count == 0)
		{
			return 0;
		}
		int num = 0;
		int id;
		while (TryTakeOne(value, out id))
		{
			AssetToken assetToken = _entries[id];
			if (!assetToken.Alive)
			{
				continue;
			}
			if (assetToken.InstanceId != 0 && _byInstance.TryGetValue(assetToken.InstanceId, out HashSet<int> value2))
			{
				value2.Remove(id);
				if (value2.Count == 0)
				{
					_byInstance.Remove(assetToken.InstanceId);
				}
			}
			Kill(assetToken);
			num++;
		}
		_byKey.Remove(assetPath);
		return num;
	}

	private int Register(string key, int instanceId, HandleBase handle)
	{
		int num = NewEntryId();
		AssetToken assetToken = EnsureEntrySlot(num);
		assetToken.TokenId = num;
		assetToken.Key = key;
		assetToken.InstanceId = instanceId;
		assetToken.Handle = handle;
		assetToken.Alive = true;
		if (!_byKey.TryGetValue(key, out HashSet<int> value))
		{
			value = (_byKey[key] = new HashSet<int>());
		}
		value.Add(num);
		if (instanceId != 0)
		{
			if (!_byInstance.TryGetValue(instanceId, out HashSet<int> value2))
			{
				value2 = (_byInstance[instanceId] = new HashSet<int>());
			}
			value2.Add(num);
		}
		return num;
	}

	private UniTask<bool> Kill(AssetToken e)
	{
		if (!e.Alive)
		{
			return UniTask.FromResult(value: false);
		}
		e.Alive = false;
		try
		{
			return e.Handle?.Release() ?? UniTask.FromResult(value: false);
		}
		finally
		{
			e.Handle = null;
			_freeIds.Push(e.TokenId);
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	private int NewEntryId()
	{
		return (_freeIds.Count > 0) ? _freeIds.Pop() : _entries.Count;
	}

	[MethodImpl((MethodImplOptions)256)]
	private static bool TryTakeOne(HashSet<int> set, out int id)
	{
		using (HashSet<int>.Enumerator enumerator = set.GetEnumerator())
		{
			if (enumerator.MoveNext())
			{
				set.Remove(id = enumerator.Current);
				return true;
			}
		}
		id = -1;
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	private AssetToken EnsureEntrySlot(int id)
	{
		if (id == _entries.Count)
		{
			AssetToken assetToken = new AssetToken();
			_entries.Add(assetToken);
			return assetToken;
		}
		return _entries[id];
	}

	[MethodImpl((MethodImplOptions)256)]
	private string GetAssetPath(string location, string packageName)
	{
		return ZString.Format("{0}-{1}", location, packageName);
	}

	public async UniTask<GameObject> InstantiateSync(string location, string packageName, InstantiateData data, CancellationToken cancellationToken = default(CancellationToken))
	{
		AssetHandle handle = await LoadAssetCore<GameObject>(location, packageName, cancellationToken);
		if (handle == null)
		{
			return null;
		}
		if (data == null)
		{
			Log.Error("Instantiate data is null.");
			return null;
		}
		return handle.InstantiateSync(data.SetPositionAndRotation, data.Position, data.Rotation, data.Parent, data.WorldStay);
	}

	public UniTask<GameObject> InstantiateAsync(string location, InstantiateData data, CancellationToken cancellationToken = default(CancellationToken))
	{
		return InstantiateAsync(location, PackageName, data, cancellationToken);
	}

	public async UniTask<GameObject> InstantiateAsync(string location, string packageName, InstantiateData data, CancellationToken cancellationToken = default(CancellationToken))
	{
		if (data == null)
		{
			Log.Error("Instantiate data is null.");
			return null;
		}
		AssetHandle handle = null;
		GameObject result = null;
		try
		{
			cancellationToken.ThrowIfCancellationRequested();
			packageName = GetPackageName(packageName);
			handle = await LoadAssetCore<GameObject>(location, packageName, cancellationToken);
			if (handle == null || handle.AssetObject == null)
			{
				throw new Exception("LoadAsset failed: " + location);
			}
			InstantiateOperation op = handle.InstantiateAsync(data.SetPositionAndRotation, data.Position, data.Rotation, data.Parent, data.WorldStay, data.Active);
			await ((AsyncOperationBase)op).Task;
			if ((int)((AsyncOperationBase)op).Status != 2 || op.Result == null)
			{
				throw new Exception("Instantiate failed: " + location);
			}
			result = op.Result;
			if (cancellationToken.IsCancellationRequested)
			{
				throw new OperationCanceledException(cancellationToken);
			}
			if (data.AutoLifecycle)
			{
				ObjectContextLifecycle lifecycle = result.AddComponent<ObjectContextLifecycle>();
				lifecycle.Initialize(this, location, packageName);
			}
			RegisterToken(location, packageName, result.GetInstanceID(), InstantiateHandle.Create(handle));
			return result;
		}
		catch (OperationCanceledException)
		{
			if ((bool)result)
			{
				UnityEngine.Object.Destroy(result);
			}
			AssetHandle obj = handle;
			if (obj != null)
			{
				((HandleBase)obj).Release();
			}
			return null;
		}
		catch (Exception ex2)
		{
			Exception e = ex2;
			Log.Error(e.ToString());
			if ((bool)result)
			{
				UnityEngine.Object.Destroy(result);
			}
			AssetHandle obj2 = handle;
			if (obj2 != null)
			{
				((HandleBase)obj2).Release();
			}
			return null;
		}
		finally
		{
			data.Dispose();
		}
	}

	public async void LoadScene(string sceneName, string location, string packageName = "", LoadSceneMode sceneMode = LoadSceneMode.Additive, LoadSceneCallbacks loadSceneCallbacks = null, object userData = null)
	{
		if (string.IsNullOrEmpty(location))
		{
			throw new GameFrameworkException("Scene name is invalid.");
		}
		packageName = GetPackageName(packageName);
		float duration = Time.time;
		ResourcePackage package = YooAssets.GetPackage(packageName);
		if (package == null)
		{
			throw new GameFrameworkException("The package does not exist. Package Name :" + packageName);
		}
		SceneHandle handle = package.LoadSceneAsync(location, sceneMode, LocalPhysicsMode.None, false, 0u);
		while (!((HandleBase)handle).IsDone)
		{
			if ((int)((HandleBase)handle).Status == 1)
			{
				loadSceneCallbacks?.LoadSceneUpdateCallback?.Invoke(sceneName, ((HandleBase)handle).Progress, userData);
			}
			await UniTask.Yield(PlayerLoopTiming.LastPostLateUpdate);
		}
		if ((int)((HandleBase)handle).Status == 3)
		{
			_ = Time.time - duration;
			loadSceneCallbacks?.LoadSceneFailureCallback?.Invoke(sceneName, LoadResourceStatus.AssetError, ((HandleBase)handle).LastError, userData);
		}
		else
		{
			RegisterToken(location, packageName, 0, SceneAssetHandle.Create(handle));
			duration = Time.time - duration;
			loadSceneCallbacks?.LoadSceneSuccessCallback?.Invoke(sceneName, duration, userData);
		}
	}

	public async void UnloadScene(string sceneName, string location, string packageName = "", UnloadSceneCallbacks unloadSceneCallbacks = null, object userData = null)
	{
		if (string.IsNullOrEmpty(location))
		{
			throw new GameFrameworkException("Scene name is invalid.");
		}
		packageName = GetPackageName(packageName);
		if (!(await UnloadToken(location, packageName)))
		{
			unloadSceneCallbacks?.UnloadSceneFailureCallback?.Invoke(location, userData);
		}
		else
		{
			unloadSceneCallbacks?.UnloadSceneSuccessCallback?.Invoke(location, userData);
		}
	}

	public async UniTask<UnityEngine.SceneManagement.Scene> LoadSceneAsync(string sceneName, string packageName, LoadSceneMode sceneMode = LoadSceneMode.Additive)
	{
		if (string.IsNullOrEmpty(sceneName))
		{
			throw new GameFrameworkException("Scene name is invalid.");
		}
		packageName = GetPackageName(packageName);
		ResourcePackage package = YooAssets.GetPackage(packageName);
		if (package == null)
		{
			throw new GameFrameworkException("The package does not exist. Package Name :" + packageName);
		}
		SceneHandle handle = package.LoadSceneAsync(sceneName, sceneMode, LocalPhysicsMode.None, false, 0u);
		await ((HandleBase)(object)handle).ToUniTask().SuppressCancellationThrow();
		if ((int)((HandleBase)handle).Status == 3)
		{
			return default(UnityEngine.SceneManagement.Scene);
		}
		RegisterToken(sceneName, packageName, 0, SceneAssetHandle.Create(handle));
		return handle.SceneObject;
	}

	public async UniTask UnloadSceneAsync(string sceneName, string packageName = "")
	{
		if (string.IsNullOrEmpty(sceneName))
		{
			throw new GameFrameworkException("Scene name is invalid.");
		}
		packageName = GetPackageName(packageName);
		await UnloadToken(sceneName, packageName);
	}
}
