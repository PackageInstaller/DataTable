#define ENABLE_ERROR_AND_ABOVE_LOG
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Resource;
using GameFramework.Runtime;
using UnityEngine.SceneManagement;

namespace Ase;

public static class SceneExtension
{
	public static bool SceneIsLoaded(this SceneComponent sceneComponent, string sceneName)
	{
		if (string.IsNullOrEmpty(sceneName))
		{
			throw new GameFrameworkException("Scene asset name is invalid.");
		}
		return SceneManager.GetSceneByName(sceneName).isLoaded;
	}

	public static bool HasScene(this SceneComponent sceneComponent, string sceneName)
	{
		if (string.IsNullOrEmpty(sceneName))
		{
			throw new GameFrameworkException("Scene asset name is invalid.");
		}
		return sceneComponent.HasScene(sceneName, AssetUtility.GetSceneAsset(sceneName), string.Empty);
	}

	public static void LoadScene(this SceneComponent sceneComponent, string sceneAssetName, LoadSceneMode loadSceneMode, LoadSceneCallbacks loadSceneCallbacks, object userData = null)
	{
		if (string.IsNullOrEmpty(sceneAssetName))
		{
			Log.Error("Scene asset name is invalid.");
		}
		else
		{
			sceneComponent.LoadScene(sceneAssetName, sceneAssetName, string.Empty, loadSceneMode, loadSceneCallbacks, userData);
		}
	}

	public static void LoadSceneByPackage(this SceneComponent sceneComponent, string sceneAssetName, string packageName, LoadSceneMode loadSceneMode, LoadSceneCallbacks loadSceneCallbacks, object userData = null)
	{
		if (string.IsNullOrEmpty(sceneAssetName))
		{
			Log.Error("Scene asset name is invalid.");
		}
		else
		{
			sceneComponent.LoadScene(sceneAssetName, sceneAssetName, packageName, loadSceneMode, loadSceneCallbacks, userData);
		}
	}

	public static void UnloadScene(this SceneComponent sceneComponent, string sceneAssetName, UnloadSceneCallbacks unloadSceneCallbacks = null, object userData = null)
	{
		if (string.IsNullOrEmpty(sceneAssetName))
		{
			Log.Error("Scene asset name is invalid.");
		}
		else
		{
			sceneComponent.UnloadScene(sceneAssetName, sceneAssetName, string.Empty, unloadSceneCallbacks, userData);
		}
	}

	public static void UnloadSceneByPackage(this SceneComponent sceneComponent, string sceneAssetName, string packageName, UnloadSceneCallbacks unloadSceneCallbacks = null, object userData = null)
	{
		if (string.IsNullOrEmpty(sceneAssetName))
		{
			Log.Error("Scene asset name is invalid.");
		}
		else
		{
			sceneComponent.UnloadScene(sceneAssetName, sceneAssetName, packageName, unloadSceneCallbacks, userData);
		}
	}

	public static UniTask LoadSceneAsync(this SceneComponent sceneComponent, string sceneName, string packageName = "", LoadSceneMode sceneMode = LoadSceneMode.Additive)
	{
		if (string.IsNullOrEmpty(sceneName))
		{
			Log.Error("Scene asset name is invalid.");
			return UniTask.CompletedTask;
		}
		return sceneComponent.LoadSceneAsync(sceneName, AssetUtility.GetSceneAsset(sceneName), packageName, sceneMode);
	}

	public static UniTask UnloadSceneAsync(this SceneComponent sceneComponent, string sceneName, string packageName = "")
	{
		if (string.IsNullOrEmpty(sceneName))
		{
			Log.Error("Scene asset name is invalid.");
			return UniTask.CompletedTask;
		}
		return sceneComponent.UnloadSceneAsync(sceneName, AssetUtility.GetSceneAsset(sceneName), packageName);
	}
}
