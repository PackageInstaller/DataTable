using Cysharp.Threading.Tasks;
using GameFramework.Resource;
using UnityEngine.SceneManagement;

namespace GameFramework.Scene;

public interface ISceneManager
{
	void SetResourceManager(IResourceManager resourceManager);

	bool HasScene(string sceneName, string location, string packageName = "");

	void LoadScene(string sceneName, string location, string packageName = "", LoadSceneMode sceneMode = LoadSceneMode.Additive, LoadSceneCallbacks loadSceneCallbacks = null, object userData = null);

	void UnloadScene(string sceneName, string location, string packageName = "", UnloadSceneCallbacks unloadSceneCallbacks = null, object userData = null);

	UniTask LoadSceneAsync(string sceneName, string location, string packageName, LoadSceneMode sceneMode);

	UniTask UnloadSceneAsync(string sceneName, string location, string packageName);
}
