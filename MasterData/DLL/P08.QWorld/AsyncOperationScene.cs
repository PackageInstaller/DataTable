using System;
using UnityEngine;
using UnityEngine.SceneManagement;

public class AsyncOperationScene : RefCounter
{
	private AssetBundleObject m_ab;

	private AsyncOperation m_scene_op;

	private string m_scenePath;

	private string m_bundleName;

	private LoadSceneMode m_mode;

	private bool m_allowSceneActivation;

	private bool m_isABMode;

	private AssetBundleManifest m_manifest;

	public AsyncOperationScene(string scenePath, string bundleName, LoadSceneMode mode, bool allowSceneActivation, AssetBundleManifest manifest)
	{
		m_scenePath = scenePath;
		m_bundleName = bundleName;
		m_isABMode = manifest != null;
		refCount = 0;
		m_allowSceneActivation = allowSceneActivation;
		m_mode = mode;
		m_manifest = manifest;
		if (m_isABMode)
		{
			if (!AssetBundleObject.s_bundleObjects.TryGetValue(m_bundleName, out m_ab))
			{
				m_ab = new AssetBundleObject(m_bundleName, manifest);
				AssetBundleObject.s_bundleObjects.Add(m_bundleName, m_ab);
			}
			StartLoad(m_ab);
		}
		else
		{
			OnABCompleted();
		}
	}

	private void StartLoad(AssetBundleObject bundleObject)
	{
		bundleObject.LoadAsync();
		if (bundleObject.m_IsDoneWithChildren)
		{
			OnABCompleted();
		}
		else
		{
			bundleObject.m_LoadCompeletedEvent = (Action)Delegate.Combine(bundleObject.m_LoadCompeletedEvent, new Action(OnABCompleted));
		}
	}

	private void OnABCompleted()
	{
		if (m_isABMode)
		{
			AssetBundleObject ab = m_ab;
			ab.m_LoadCompeletedEvent = (Action)Delegate.Remove(ab.m_LoadCompeletedEvent, new Action(OnABCompleted));
			m_scene_op = SceneManager.LoadSceneAsync(m_scenePath, m_mode);
		}
		else if (RefCounter.OnEditorSceneLoad != null)
		{
			m_scene_op = RefCounter.OnEditorSceneLoad(m_scenePath, new LoadSceneParameters(LoadSceneMode.Additive));
		}
		m_scene_op.allowSceneActivation = m_allowSceneActivation;
	}

	public void Release()
	{
		if (m_scene_op != null && !m_scene_op.isDone)
		{
			Debug.LogError("无法释放正在异步载入的资源！" + m_scenePath);
		}
		else if (m_isABMode)
		{
			if (m_ab != null)
			{
				AssetBundleObject ab = m_ab;
				ab.m_LoadCompeletedEvent = (Action)Delegate.Remove(ab.m_LoadCompeletedEvent, new Action(OnABCompleted));
			}
			SceneManager.UnloadSceneAsync(m_scenePath);
			m_ab.UnloadAsync();
		}
		else if (RefCounter.OnEditorSceneUnLoad != null)
		{
			RefCounter.OnEditorSceneUnLoad(m_scenePath);
		}
	}

	public bool IsDone()
	{
		if (m_isABMode && !m_ab.m_IsDoneWithChildren)
		{
			return false;
		}
		if (!m_allowSceneActivation)
		{
			if (m_scene_op.progress >= 0.9f)
			{
				return true;
			}
			return false;
		}
		if (!m_scene_op.isDone)
		{
			return false;
		}
		return true;
	}

	public void SetActive(bool isActive)
	{
		m_scene_op.allowSceneActivation = isActive;
	}
}
