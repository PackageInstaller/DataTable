#define ENABLE_FATAL_AND_ABOVE_LOG
#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework.Resource;
using GameFramework.Scene;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace GameFramework.Runtime;

[AddComponentMenu("Game Framework/Scene")]
[DisallowMultipleComponent]
public sealed class SceneComponent : GameFrameworkComponent
{
	private ISceneManager m_SceneManager = null;

	private readonly SortedDictionary<string, int> m_SceneOrder = new SortedDictionary<string, int>(StringComparer.Ordinal);

	private UnityEngine.SceneManagement.Scene m_GameFrameworkScene = default(UnityEngine.SceneManagement.Scene);

	protected override void Awake()
	{
		base.Awake();
		m_SceneManager = GameFrameworkEntry.GetModule<ISceneManager>();
		if (m_SceneManager == null)
		{
			Log.Fatal("Scene manager is invalid.");
			return;
		}
		m_GameFrameworkScene = SceneManager.GetSceneAt(0);
		if (!m_GameFrameworkScene.IsValid())
		{
			Log.Fatal("Game Framework scene is invalid.");
		}
	}

	public override void Init()
	{
		BaseComponent component = GameEntryRuntime.GetComponent<BaseComponent>();
		if (component == null)
		{
			Log.Fatal("Base component is invalid.");
		}
		else
		{
			m_SceneManager.SetResourceManager(GameFrameworkEntry.GetModule<IResourceManager>());
		}
	}

	public bool HasScene(string sceneName, string location, string packageName = "")
	{
		return m_SceneManager.HasScene(sceneName, location, packageName);
	}

	public void LoadScene(string sceneName, string location, string packageName = "", LoadSceneMode sceneMode = LoadSceneMode.Additive, LoadSceneCallbacks loadSceneCallbacks = null, object userData = null)
	{
		if (string.IsNullOrEmpty(sceneName))
		{
			Log.Error("Scene asset name is invalid.");
		}
		else
		{
			m_SceneManager.LoadScene(sceneName, location, packageName, sceneMode, loadSceneCallbacks, userData);
		}
	}

	public void LoadScene(string sceneName, string location, LoadSceneCallbacks loadSceneCallbacks = null, string packageName = "", LoadSceneMode sceneMode = LoadSceneMode.Additive, object userData = null)
	{
		if (string.IsNullOrEmpty(sceneName))
		{
			Log.Error("Scene asset name is invalid.");
		}
		else
		{
			m_SceneManager.LoadScene(sceneName, location, packageName, sceneMode, loadSceneCallbacks, userData);
		}
	}

	public void UnloadScene(string sceneName, string location, string packageName = "", UnloadSceneCallbacks unloadSceneCallbacks = null, object userData = null)
	{
		if (string.IsNullOrEmpty(sceneName))
		{
			Log.Error("Scene asset name is invalid.");
			return;
		}
		m_SceneManager.UnloadScene(sceneName, location, packageName, unloadSceneCallbacks, userData);
		m_SceneOrder.Remove(sceneName);
	}

	public UniTask LoadSceneAsync(string sceneName, string location, string packageName, LoadSceneMode sceneMode)
	{
		if (string.IsNullOrEmpty(sceneName))
		{
			Log.Error("Scene asset name is invalid.");
			return UniTask.CompletedTask;
		}
		return m_SceneManager.LoadSceneAsync(sceneName, location, packageName, sceneMode);
	}

	public UniTask UnloadSceneAsync(string sceneName, string location, string packageName = "")
	{
		if (string.IsNullOrEmpty(sceneName))
		{
			Log.Error("Scene asset name is invalid.");
			return UniTask.CompletedTask;
		}
		m_SceneOrder.Remove(sceneName);
		return m_SceneManager.UnloadSceneAsync(sceneName, location, packageName);
	}
}
