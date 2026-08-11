#define ENABLE_FATAL_AND_ABOVE_LOG
#define ENABLE_INFO_AND_ABOVE_LOG
#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;
using GameFramework.Resource;
using UnityEngine;
using YooAsset;

namespace GameFramework.Runtime;

[DisallowMultipleComponent]
[AddComponentMenu("Game Framework/Resource")]
public class ResourceComponent : GameFrameworkComponent
{
	private Dictionary<string, string> m_ResourceVersionDic;

	private IResourceManager m_ResourceManager;

	private bool m_ForceUnloadUnusedAssets;

	private bool m_ForceUnloadResourceUnusedAssets;

	private bool m_PreorderUnloadUnusedAssets;

	private bool m_PerformGCCollect;

	private AsyncOperation m_AsyncOperation;

	private float m_LastUnloadUnusedAssetsOperationElapseSeconds;

	[SerializeField]
	private float m_MinUnloadUnusedAssetsInterval;

	[SerializeField]
	private float m_MaxUnloadUnusedAssetsInterval;

	[SerializeField]
	private string m_ResourceHelperTypeName;

	public string PackageName;

	public EPlayMode PlayMode;

	public EFileVerifyLevel VerifyLevel;

	[SerializeField]
	private ReadWritePathType m_ReadWritePathType;

	[SerializeField]
	public long Milliseconds;

	[SerializeField]
	public int BundleLoadingMaxConcurrency;

	public int m_DownloadingMaxNum;

	private IResourceHelper resourceHelper;

	public int m_FailedTryAgain;

	public string PackageVersion { get; set; }

	public int DownloadingMaxNum
	{
		get
		{
			return m_DownloadingMaxNum;
		}
		set
		{
			m_DownloadingMaxNum = value;
		}
	}

	public int FailedTryAgain
	{
		get
		{
			return m_FailedTryAgain;
		}
		set
		{
			m_FailedTryAgain = value;
		}
	}

	public string ApplicableGameVersion => m_ResourceManager?.ApplicableGameVersion ?? "<Unknown>";

	public int InternalResourceVersion => m_ResourceManager?.InternalResourceVersion ?? 0;

	public ReadWritePathType ReadWritePathType => m_ReadWritePathType;

	public float MinUnloadUnusedAssetsInterval
	{
		get
		{
			return m_MinUnloadUnusedAssetsInterval;
		}
		set
		{
			m_MinUnloadUnusedAssetsInterval = value;
		}
	}

	public float MaxUnloadUnusedAssetsInterval
	{
		get
		{
			return m_MaxUnloadUnusedAssetsInterval;
		}
		set
		{
			m_MaxUnloadUnusedAssetsInterval = value;
		}
	}

	public float LastUnloadUnusedAssetsOperationElapseSeconds => m_LastUnloadUnusedAssetsOperationElapseSeconds;

	public ResourceDownloaderOperation Downloader { get; set; }

	public override void Init()
	{
		//IL_005b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0060: Unknown result type (might be due to invalid IL or missing references)
		//IL_0065: Unknown result type (might be due to invalid IL or missing references)
		//IL_0083: Unknown result type (might be due to invalid IL or missing references)
		//IL_0095: Unknown result type (might be due to invalid IL or missing references)
		BaseComponent component = GameEntryRuntime.GetComponent<BaseComponent>();
		if (component == null)
		{
			Log.Fatal("Base component is invalid.");
			return;
		}
		m_ResourceManager = GameFrameworkEntry.GetModule<IResourceManager>();
		if (m_ResourceManager == null)
		{
			Log.Fatal("YooAssetsManager component is invalid.");
			return;
		}
		InitResourceHelper();
		PlayMode = resourceHelper.GetResourcePlayMode(PlayMode);
		m_ResourceManager.PackageName = PackageName;
		m_ResourceManager.PlayMode = PlayMode;
		m_ResourceManager.VerifyLevel = VerifyLevel;
		m_ResourceManager.Milliseconds = Milliseconds;
		m_ResourceManager.BundleLoadingMaxConcurrency = BundleLoadingMaxConcurrency;
		m_ResourceManager.InstanceRoot = base.transform;
		m_ResourceManager.Initialize();
	}

	private void InitResourceHelper()
	{
		if (string.IsNullOrEmpty(m_ResourceHelperTypeName))
		{
			return;
		}
		Type type = Utility.Assembly.GetType(m_ResourceHelperTypeName);
		if (type == null)
		{
			Log.Error("Can not find Resource helper type '{0}'.", m_ResourceHelperTypeName);
			return;
		}
		resourceHelper = (IResourceHelper)Activator.CreateInstance(type);
		if (resourceHelper == null)
		{
			Log.Error("Can not create Resource helper instance '{0}'.", m_ResourceHelperTypeName);
		}
		else
		{
			m_ResourceManager.SetResourceHelper(resourceHelper);
		}
	}

	private string GetPackageName(string customPackageName)
	{
		if (string.IsNullOrEmpty(customPackageName))
		{
			return PackageName;
		}
		return customPackageName;
	}

	public void AddResourceVersion(string customPackageName, string customVersion)
	{
		m_ResourceVersionDic[customPackageName] = customVersion;
	}

	public string GetResourceVersion(string customPackageName)
	{
		m_ResourceVersionDic.TryGetValue(customPackageName, out var value);
		return value;
	}

	public async UniTask<InitializationOperation> InitPackage(string packageName = "")
	{
		if (m_ResourceManager == null)
		{
			Log.Fatal("Resource component is invalid.");
			return null;
		}
		return await m_ResourceManager.InitPackage(GetPackageName(packageName));
	}

	public async UniTask<bool> ClearCacheBundleFiles(string packageName, EFileClearMode clearMode, object clearParam = null)
	{
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		if (m_ResourceManager == null)
		{
			Log.Fatal("Resource component is invalid.");
			return false;
		}
		return await m_ResourceManager.ClearCacheBundleFiles(GetPackageName(packageName), clearMode, clearParam);
	}

	public UniTask RemoveAllPackage()
	{
		return m_ResourceManager.RemoveAllPackage();
	}

	public string GetPackageVersion(string customPackageName = "")
	{
		ResourcePackage package = YooAssets.GetPackage(GetPackageName(customPackageName));
		if (package == null)
		{
			return string.Empty;
		}
		return package.GetPackageVersion();
	}

	public RequestPackageVersionOperation UpdatePackageVersionAsync(bool appendTimeTicks = false, int timeout = 60, string customPackageName = "")
	{
		ResourcePackage package = YooAssets.GetPackage(GetPackageName(customPackageName));
		return package.RequestPackageVersionAsync(appendTimeTicks, timeout);
	}

	public UpdatePackageManifestOperation UpdatePackageManifestAsync(string packageVersion, bool autoSaveVersion = true, int timeout = 60, string customPackageName = "")
	{
		ResourcePackage package = YooAssets.GetPackage(GetPackageName(customPackageName));
		return package.UpdatePackageManifestAsync(packageVersion, timeout);
	}

	public ResourceDownloaderOperation CreateResourceDownloader(string customPackageName = "")
	{
		ResourcePackage package = YooAssets.GetPackage(GetPackageName(customPackageName));
		Downloader = package.CreateResourceDownloader(DownloadingMaxNum, FailedTryAgain);
		return Downloader;
	}

	public ResourceDownloaderOperation CreateResourceDownloader(string customPackageName = "", string assetTag = "")
	{
		return CreateResourceDownloader(customPackageName, new string[1] { assetTag });
	}

	public ResourceDownloaderOperation CreateResourceDownloader(string customPackageName, string[] assetTags)
	{
		ResourcePackage package = YooAssets.GetPackage(GetPackageName(customPackageName));
		Downloader = package.CreateResourceDownloader(assetTags, DownloadingMaxNum, FailedTryAgain);
		return Downloader;
	}

	public HasAssetResult HasAsset(string location, string customPackageName = "")
	{
		return m_ResourceManager.HasAsset(location, customPackageName);
	}

	public bool CheckLocationValid(string location, string customPackageName = "")
	{
		return m_ResourceManager.CheckLocationValid(location, customPackageName);
	}

	public AssetData[] GetAssetInfos(string resTag, string customPackageName = "")
	{
		return m_ResourceManager.GetAssetInfos(resTag, customPackageName);
	}

	public AssetData[] GetAssetInfos(string[] tags, string customPackageName = "")
	{
		return m_ResourceManager.GetAssetInfos(tags, customPackageName);
	}

	public T LoadAsset<T>(string location, string packageName = "") where T : UnityEngine.Object
	{
		if (string.IsNullOrEmpty(location))
		{
			Log.Error("Asset name is invalid.");
			return null;
		}
		return m_ResourceManager.LoadAsset<T>(location, packageName);
	}

	public UniTask<T> LoadAssetAsync<T>(string location) where T : UnityEngine.Object
	{
		return LoadAssetAsync<T>(location, string.Empty);
	}

	public UniTask<T> LoadAssetAsync<T>(string location, string packageName) where T : UnityEngine.Object
	{
		return LoadAssetAsync<T>(location, packageName, CancellationToken.None);
	}

	public async UniTask<T> LoadAssetAsync<T>(string location, string packageName, CancellationToken cancellationToken) where T : UnityEngine.Object
	{
		if (string.IsNullOrEmpty(location))
		{
			Log.Error("Asset name is invalid.");
			return null;
		}
		return await m_ResourceManager.LoadAssetAsync<T>(location, GetPackageName(packageName), cancellationToken);
	}

	public async UniTask<IReadOnlyList<T>> LoadAllAssetAsync<T>(string location, string packageName = "", CancellationToken cancellationToken = default(CancellationToken)) where T : UnityEngine.Object
	{
		if (string.IsNullOrEmpty(location))
		{
			Log.Error("Asset name is invalid.");
			return Array.Empty<T>();
		}
		return await m_ResourceManager.LoadAllAssetAsync<T>(location, GetPackageName(packageName), cancellationToken);
	}

	public UniTask<GameObject> InstantiateAsync(string location, InstantiateData data, CancellationToken cancellationToken = default(CancellationToken))
	{
		return m_ResourceManager.InstantiateAsync(location, PackageName, data, cancellationToken);
	}

	public UniTask<GameObject> InstantiateAsync(string location, string packageName, InstantiateData data, CancellationToken cancellationToken = default(CancellationToken))
	{
		return m_ResourceManager.InstantiateAsync(location, packageName, data, cancellationToken);
	}

	public void UnloadAsset(string location, string packageName = "")
	{
		m_ResourceManager.UnloadAsset(location, GetPackageName(packageName));
	}

	public void UnloadUnusedAssets(bool performGCCollect = true, bool unloadResourceUnusedAssets = false)
	{
		m_ForceUnloadUnusedAssets = true;
		m_ForceUnloadResourceUnusedAssets = unloadResourceUnusedAssets;
		if (performGCCollect)
		{
			m_PerformGCCollect = true;
		}
	}

	public void ForceUnloadUnusedAssets(bool performGCCollect, bool unloadResourceUnusedAssets = false)
	{
		m_ForceUnloadUnusedAssets = true;
		m_ForceUnloadResourceUnusedAssets = false;
		if (performGCCollect)
		{
			m_PerformGCCollect = true;
		}
	}

	public void ForceUnloadAllAssets(bool unloadResourceUnusedAssets = false)
	{
		m_ResourceManager.ForceUnloadAllAssets();
		if (unloadResourceUnusedAssets)
		{
			Resources.UnloadUnusedAssets();
		}
	}

	private void Update()
	{
		m_LastUnloadUnusedAssetsOperationElapseSeconds += Time.unscaledDeltaTime;
		if (m_AsyncOperation == null && (m_ForceUnloadUnusedAssets || m_LastUnloadUnusedAssetsOperationElapseSeconds >= m_MaxUnloadUnusedAssetsInterval || (m_PreorderUnloadUnusedAssets && m_LastUnloadUnusedAssetsOperationElapseSeconds >= m_MinUnloadUnusedAssetsInterval)))
		{
			m_ForceUnloadUnusedAssets = false;
			m_PreorderUnloadUnusedAssets = false;
			m_LastUnloadUnusedAssetsOperationElapseSeconds = 0f;
			if (!m_ForceUnloadResourceUnusedAssets)
			{
				m_ResourceManager.UnloadUnusedAssets();
				TryPerformGCCollect();
			}
			else
			{
				m_ForceUnloadResourceUnusedAssets = false;
				m_AsyncOperation = Resources.UnloadUnusedAssets();
			}
		}
		if (m_AsyncOperation != null && m_AsyncOperation.isDone)
		{
			m_ResourceManager.UnloadUnusedAssets();
			m_AsyncOperation = null;
			TryPerformGCCollect();
		}
	}

	private void TryPerformGCCollect()
	{
		if (m_PerformGCCollect)
		{
			m_PerformGCCollect = false;
			GC.Collect();
		}
	}

	public ResourceComponent()
	{
		//IL_0067: Unknown result type (might be due to invalid IL or missing references)
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		m_ResourceVersionDic = new Dictionary<string, string>();
		m_ForceUnloadUnusedAssets = false;
		m_ForceUnloadResourceUnusedAssets = false;
		m_PreorderUnloadUnusedAssets = false;
		m_PerformGCCollect = false;
		m_AsyncOperation = null;
		m_LastUnloadUnusedAssetsOperationElapseSeconds = 0f;
		m_MinUnloadUnusedAssetsInterval = 60f;
		m_MaxUnloadUnusedAssetsInterval = 300f;
		m_ResourceHelperTypeName = "GameFramework.Runtime.DefaultResourceIHelper";
		PackageName = "DefaultPackage";
		PlayMode = (EPlayMode)0;
		VerifyLevel = (EFileVerifyLevel)2;
		m_ReadWritePathType = ReadWritePathType.Unspecified;
		Milliseconds = 30L;
		BundleLoadingMaxConcurrency = 10;
		m_DownloadingMaxNum = 2;
		m_FailedTryAgain = 3;
		base._002Ector();
	}
}
