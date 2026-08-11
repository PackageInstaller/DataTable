using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.SceneManagement;
using YooAsset;

namespace GameFramework.Resource;

public interface IResourceManager
{
	string ApplicableGameVersion { get; }

	int InternalResourceVersion { get; }

	int DownloadingMaxNum { get; set; }

	int FailedTryAgain { get; set; }

	string PackageName { get; set; }

	EPlayMode PlayMode { get; set; }

	EFileVerifyLevel VerifyLevel { get; set; }

	long Milliseconds { get; set; }

	int BundleLoadingMaxConcurrency { get; set; }

	Transform InstanceRoot { get; set; }

	void Initialize();

	UniTask<InitializationOperation> InitPackage(string packageName);

	UniTask<bool> ClearCacheBundleFiles(string packageName, EFileClearMode clearMode, object clearParam = null);

	UniTask RemovePackage(string packageName);

	UniTask RemoveAllPackage();

	void SetResourceHelper(IResourceHelper resourceHelper);

	HasAssetResult HasAsset(string location, string packageName = "");

	bool CheckLocationValid(string location, string packageName = "");

	AssetData[] GetAssetInfos(string resTag, string packageName = "");

	AssetData[] GetAssetInfos(string[] tags, string packageName = "");

	T LoadAsset<T>(string location, string packageName = "") where T : Object;

	void LoadAssetAsync(string location, LoadAssetCallbacks loadAssetCallbacks, object userData, string packageName = "");

	UniTask<T> LoadAssetAsync<T>(string location, string packageName = "", CancellationToken cancellationToken = default(CancellationToken)) where T : Object;

	UniTask<IReadOnlyList<T>> LoadAllAssetAsync<T>(string location, string packageName = "", CancellationToken cancellationToken = default(CancellationToken)) where T : Object;

	UniTask<GameObject> InstantiateAsync(string location, InstantiateData data, CancellationToken cancellationToken = default(CancellationToken));

	UniTask<GameObject> InstantiateAsync(string location, string packageName, InstantiateData data, CancellationToken cancellationToken = default(CancellationToken));

	void LoadScene(string sceneName, string location, string packageName = "", LoadSceneMode sceneMode = LoadSceneMode.Additive, LoadSceneCallbacks loadSceneCallbacks = null, object userData = null);

	void UnloadScene(string sceneName, string location, string packageName = "", UnloadSceneCallbacks unloadSceneCallbacks = null, object userData = null);

	UniTask<UnityEngine.SceneManagement.Scene> LoadSceneAsync(string sceneName, string packageName, LoadSceneMode sceneMode = LoadSceneMode.Additive);

	UniTask UnloadSceneAsync(string sceneName, string packageName = "");

	void UnloadAsset(string location, string packageName = "");

	void UnloadAsset(Object obj);

	void UnloadUnusedAssets();

	void ForceUnloadAllAssets();
}
