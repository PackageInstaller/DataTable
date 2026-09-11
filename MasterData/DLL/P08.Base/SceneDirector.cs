using System;
using System.Collections;
using UnityEngine;
using UnityEngine.SceneManagement;

public class SceneDirector : MonoBehaviour
{
	public NScene curScene;

	private Type curSceneType;

	private Type lastSceneType;

	protected float m_SliderProcessSpeed = 25f;

	public static SceneDirector Instance;

	public bool isHanding { get; private set; }

	public Type LastSceneType => lastSceneType;

	public event OnVoidHandler<NScene> OnSceneExitHandler;

	public event OnVoidHandler<NScene> OnSceneEnterHandler;

	public event OnVoidHandler<NScene> OnSceneReadyHandler;

	public static void Create()
	{
		if (!Instance)
		{
			GameObject obj = new GameObject("SceneDirector", typeof(SceneDirector));
			UnityEngine.Object.DontDestroyOnLoad(obj);
			Instance = obj.GetComponent<SceneDirector>();
			Instance.Init();
		}
	}

	internal void Init()
	{
	}

	public bool IsLoaded<T>()
	{
		if (curScene != null)
		{
			return curSceneType == typeof(T);
		}
		return false;
	}

	public void Restart(int sceneID, bool showLoadUI = true)
	{
		if (curScene == null || !curScene.isReady)
		{
			Debug.LogError("场景还没有准备好！不要可以restart");
		}
		else
		{
			StartCoroutine(RestartHandler(sceneID, showLoadUI));
		}
	}

	private IEnumerator RestartHandler(int sceneID, bool showLoadUI)
	{
		curScene.ShowLoadUI();
		if (!showLoadUI)
		{
			LoadingUIManager.inst.DontShowAnything(flag: true);
		}
		IEnumerator handler = curScene.OnSceneRestartCoroutine(sceneID);
		while (handler != null && handler.MoveNext())
		{
			yield return null;
		}
		yield return null;
		curScene.CloseLoadUI();
	}

	public T Load<T>(Type t) where T : NScene
	{
		if (isHanding)
		{
			return null;
		}
		isHanding = true;
		T val = null;
		val = base.gameObject.AddComponent<T>();
		val.OnBeginLoad();
		StartCoroutine(LoadHandler(val, t));
		return val;
	}

	public NScene Load(Type t)
	{
		if (isHanding)
		{
			return null;
		}
		isHanding = true;
		NScene nScene = null;
		nScene = base.gameObject.AddComponent(t) as NScene;
		nScene.OnBeginLoad();
		StartCoroutine(LoadHandler(nScene, t));
		return nScene;
	}

	public void Reload()
	{
		StartCoroutine(LoadHandler(curScene, curSceneType));
	}

	public void FastReload()
	{
		StartCoroutine(FastReloadHandler(curScene, curSceneType));
	}

	private IEnumerator FastReloadHandler(NScene scene, Type t)
	{
		scene.Progress = 1f;
		scene.isLoaded = false;
		Debug.Log("SCENE  === " + scene);
		scene.ShowLoadUI();
		if (curScene != null)
		{
			curScene.OnSceneExit(scene);
			curScene.isLoaded = false;
			Debug.Log("set ready == " + curScene.isReady);
			curScene.isReady = false;
		}
		scene.Progress = 5f;
		U3DUtil.ClearMemory();
		curScene = scene;
		curSceneType = t;
		curScene.isReady = false;
		curScene.OnSceneEnter();
		float maxLoadingProgress = 100f;
		float updateProgress = 0.1f;
		_ = Time.realtimeSinceStartup;
		float updateLoadingTime = Time.realtimeSinceStartup;
		IEnumerator handler = curScene.OnSceneReadyCoroutine();
		while (handler != null && handler.MoveNext())
		{
			if (Time.realtimeSinceStartup - updateLoadingTime > updateProgress && scene.Progress < maxLoadingProgress)
			{
				updateLoadingTime = Time.realtimeSinceStartup;
				scene.Progress += 10f;
				if (scene.Progress > maxLoadingProgress)
				{
					scene.Progress = maxLoadingProgress;
				}
			}
			yield return null;
		}
		curScene.OnSceneReady();
		curScene.isReady = true;
		scene.Progress = 100f;
		yield return new WaitForSeconds(0.1f);
		Debug.Log("==============Director CloseLoadUI=================");
		curScene.CloseLoadUI();
		isHanding = false;
	}

	public void LoadEmptyScene(Action action)
	{
		StartCoroutine(LoadEmpty(action));
	}

	public IEnumerator LoadEmpty(Action action)
	{
		LoadingUIManager.inst.ShowLoadUI();
		LoadingUIManager.inst.DontShowAnything(flag: true);
		yield return 1;
		if (curScene != null)
		{
			if (OnSceneExitHandler != null)
			{
				OnSceneExitHandler(curScene);
			}
			curScene.OnSceneExit(null);
			curScene.isLoaded = false;
			curScene.isReady = false;
			lastSceneType = curSceneType;
			UnityEngine.Object.DestroyImmediate(curScene);
			curScene = null;
		}
		yield return 1;
		SceneManager.LoadScene("Common");
		yield return 1;
		SceneForLua.clearLuaMemoryHandler?.Invoke();
		AtlasManager.UnloadAllSprite();
		Asset.UnloadAllAssetBundles();
		yield return 1;
		action();
		LoadingUIManager.inst.CloseLoadUI();
	}

	private IEnumerator LoadHandler(NScene scene, Type t)
	{
		scene.Progress = 1f;
		scene.isLoaded = false;
		Debug.Log("准备进入场景  === " + scene);
		LoadingTime.GetInstance().startTime = Time.realtimeSinceStartup;
		scene.ShowLoadUI();
		if (scene.ShowLoadUIDuration() > 0f)
		{
			yield return new WaitForSeconds(scene.ShowLoadUIDuration());
		}
		if (curScene != null)
		{
			if (OnSceneExitHandler != null)
			{
				OnSceneExitHandler(curScene);
			}
			curScene.OnSceneExit(scene);
			curScene.isLoaded = false;
			Debug.Log("退出当前场景 == " + curScene);
			curScene.isReady = false;
			lastSceneType = curSceneType;
			if (scene != curScene)
			{
				UnityEngine.Object.DestroyImmediate(curScene);
				curScene = null;
			}
		}
		scene.Progress = 5f;
		yield return new WaitForEndOfFrame();
		LoadingTime.GetInstance().lastSceneExitTime = Time.realtimeSinceStartup;
		yield return new WaitForEndOfFrame();
		Debug.Log("准备在空场景上加载新场景资源");
		SceneManager.LoadScene("Common");
		yield return 1;
		SceneForLua.clearLuaMemoryHandler?.Invoke();
		AtlasManager.UnloadAllSprite();
		Asset.UnloadAllAssetBundles();
		LoadingTime.GetInstance().enterEmptySceneAndClearMemoryTime = Time.realtimeSinceStartup;
		curScene = scene;
		curSceneType = t;
		curScene.isReady = false;
		curScene.OnSceneEnter();
		if (OnSceneEnterHandler != null)
		{
			OnSceneEnterHandler(curScene);
		}
		LoadingTime.GetInstance().onSceneEnterFinishedTime = Time.realtimeSinceStartup;
		Debug.Log("============开始加载场景============" + Time.realtimeSinceStartup);
		scene.Progress = 20f;
		float updateProgress = 0.1f;
		_ = Time.realtimeSinceStartup;
		float updateLoadingTime = Time.realtimeSinceStartup;
		float maxLoadingProgress = 90f;
		IEnumerator handler = curScene.OnLoadCoroutine();
		while (handler != null && handler.MoveNext())
		{
			_ = Time.realtimeSinceStartup;
			if (scene.Progress < maxLoadingProgress)
			{
				updateLoadingTime = Time.realtimeSinceStartup;
				float num = scene.Progress + Time.smoothDeltaTime * m_SliderProcessSpeed;
				if (num > maxLoadingProgress)
				{
					num = maxLoadingProgress;
				}
				scene.Progress = num;
			}
			yield return null;
		}
		scene.Progress = maxLoadingProgress;
		LoadingTime.GetInstance().onLoadCoroutineFinishedTime = Time.realtimeSinceStartup;
		curScene.isLoaded = true;
		curScene.OnSceneLoaded();
		maxLoadingProgress = 100f;
		Debug.Log("============结束加载场景============" + Time.realtimeSinceStartup);
		LoadingTime.GetInstance().clearMemoryAndOnSceneLoadedFinishedTime = Time.realtimeSinceStartup;
		Debug.Log("============启动场景准备============" + Time.realtimeSinceStartup);
		handler = curScene.OnSceneReadyCoroutine();
		while (handler != null && handler.MoveNext())
		{
			if (Time.realtimeSinceStartup - updateLoadingTime > updateProgress && scene.Progress < maxLoadingProgress)
			{
				updateLoadingTime = Time.realtimeSinceStartup;
				scene.Progress += 2f;
				if (scene.Progress > maxLoadingProgress)
				{
					scene.Progress = maxLoadingProgress;
				}
			}
			yield return null;
		}
		curScene.OnSceneReady();
		curScene.isReady = true;
		if (OnSceneReadyHandler != null)
		{
			OnSceneReadyHandler(curScene);
		}
		Debug.Log("============结束场景准备============" + Time.realtimeSinceStartup);
		scene.Progress = maxLoadingProgress;
		yield return new WaitForEndOfFrame();
		yield return new WaitForEndOfFrame();
		yield return new WaitForEndOfFrame();
		if (scene.EndLoadUIDuration() > 0f)
		{
			yield return new WaitForSeconds(scene.EndLoadUIDuration());
		}
		curScene.CloseLoadUI();
		if (scene.CloseLoadUIDuration() > 0f)
		{
			yield return new WaitForSeconds(scene.CloseLoadUIDuration());
		}
		LoadingTime.GetInstance().finishedTime = Time.realtimeSinceStartup;
		isHanding = false;
		LoadingTime.GetInstance().PrintResult();
	}
}
