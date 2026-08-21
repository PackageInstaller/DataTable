#define ENABLE_ERROR_AND_ABOVE_LOG
using Cysharp.Threading.Tasks;
using GameFramework.Resource;
using UnityEngine.SceneManagement;

namespace GameFramework.Scene;

internal sealed class SceneManager : GameFrameworkModule, ISceneManager
{
	private IResourceManager m_ResourceManager;

	internal override int Priority => 2;

	public SceneManager()
	{
		m_ResourceManager = null;
	}

	internal override void Update(float elapseSeconds, float realElapseSeconds)
	{
	}

	internal override void Shutdown()
	{
	}

	public void SetResourceManager(IResourceManager resourceManager)
	{
		if (resourceManager == null)
		{
			throw new GameFrameworkException("Resource manager is invalid.");
		}
		m_ResourceManager = resourceManager;
	}

	public bool HasScene(string sceneName, string location, string packageName = "")
	{
		return m_ResourceManager.HasAsset(location, packageName) != HasAssetResult.NotExist;
	}

	public void LoadScene(string sceneName, string location, string packageName = "", LoadSceneMode sceneMode = LoadSceneMode.Additive, LoadSceneCallbacks loadSceneCallbacks = null, object userData = null)
	{
		if (string.IsNullOrEmpty(sceneName))
		{
			Log.Error("Scene asset name is invalid.");
			return;
		}
		if (m_ResourceManager == null)
		{
			throw new GameFrameworkException("You must set resource manager first.");
		}
		m_ResourceManager.LoadScene(sceneName, location, packageName, sceneMode, loadSceneCallbacks, userData);
	}

	public void UnloadScene(string sceneName, string location, string packageName = "", UnloadSceneCallbacks unloadSceneCallbacks = null, object userData = null)
	{
		if (string.IsNullOrEmpty(sceneName))
		{
			throw new GameFrameworkException("Scene asset name is invalid.");
		}
		if (m_ResourceManager == null)
		{
			throw new GameFrameworkException("You must set resource manager first.");
		}
		m_ResourceManager.UnloadScene(sceneName, location, packageName, unloadSceneCallbacks, userData);
	}

	public UniTask LoadSceneAsync(string sceneName, string location, string packageName, LoadSceneMode sceneMode)
	{
		if (string.IsNullOrEmpty(sceneName))
		{
			throw new GameFrameworkException("Scene asset name is invalid.");
		}
		if (m_ResourceManager == null)
		{
			throw new GameFrameworkException("You must set resource manager first.");
		}
		return m_ResourceManager.LoadSceneAsync(location, packageName, sceneMode);
	}

	public UniTask UnloadSceneAsync(string sceneName, string location, string packageName)
	{
		if (string.IsNullOrEmpty(sceneName))
		{
			throw new GameFrameworkException("Scene asset name is invalid.");
		}
		if (m_ResourceManager == null)
		{
			throw new GameFrameworkException("You must set resource manager first.");
		}
		return m_ResourceManager.UnloadSceneAsync(location, packageName);
	}
}
