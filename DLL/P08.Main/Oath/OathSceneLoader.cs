using System;
using System.Collections;
using Cinemachine;
using P08Main.Loading;
using Qworld.Runtime.SceneDither;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;

namespace Oath;

public class OathSceneLoader : NScene
{
	private OathSceneContext _context;

	private static OathSceneLoader mScene;

	public OathSceneContext context
	{
		get
		{
			if (_context == null)
			{
				_context = new OathSceneContext();
			}
			return _context;
		}
		set
		{
			_context = value;
		}
	}

	public static OathSceneLoader Scene => mScene;

	public override float ShowLoadUIDuration()
	{
		return 2f;
	}

	public override float EndLoadUIDuration()
	{
		return 0.5f;
	}

	public override float CloseLoadUIDuration()
	{
		return 0.5f;
	}

	public override void ShowLoadUI()
	{
		CustomLoadingManager.inst.ShowLoadUI(LoadingImpl.Oath_Loading);
	}

	protected virtual void SetUIProgress(float value)
	{
	}

	public override void CloseLoadUI()
	{
		CustomLoadingManager.inst.CloseLoadUI(LoadingImpl.Oath_Loading);
	}

	public override IEnumerator OnSceneReadyCoroutine()
	{
		yield return null;
	}

	public override void OnSceneEnter()
	{
		base.OnSceneEnter();
		EnterScene();
	}

	public override void OnSceneLoaded()
	{
		try
		{
			SetUIProgress(100f);
		}
		catch (Exception ex)
		{
			Debug.Log(ex.Message);
		}
	}

	public override void OnSceneExit(NScene nextScene)
	{
		int num = context.sceneName.LastIndexOf('/');
		string text = context.sceneName.Substring(num + 1);
		AudioManager.Instance.StopAll();
		context.Dispose();
		context = null;
		base.OnSceneExit(nextScene);
		if (OathGameLoading.Instance != null)
		{
			OathGameLoading.Instance.SetFinishCallback(delegate
			{
				OathGameLoading.Instance.ExitWorld();
				LuaHelper.CallFunction("OathToLuaBridge.OathEmitterEvent", "OATH_SCENE_ENTER_HOME_VIEW");
			});
		}
		GameObject[] rootGameObjects = SceneManager.GetSceneByName(text).GetRootGameObjects();
		for (int num2 = 0; num2 < rootGameObjects.Length; num2++)
		{
			UnityEngine.Object.DestroyImmediate(rootGameObjects[num2]);
		}
	}

	public override IEnumerator OnLoadCoroutine()
	{
		yield return null;
		AssetBundleLoadOperation ops = Asset.LoadLevelAsync(context.sceneName, isAddtive: true);
		while (!ops.IsDone())
		{
			yield return null;
		}
		Scene sceneByName = SceneManager.GetSceneByName("Common");
		if (sceneByName.IsValid())
		{
			SceneManager.SetActiveScene(sceneByName);
		}
		else
		{
			Debug.LogError("can't find scene by path: " + context.sceneName);
		}
		yield return null;
	}

	public void EnterScene()
	{
		mScene = this;
		LuaHelper.CallFunction("OathToLuaBridge.OathEnterScene", (int)context.sceneMode);
		context.chineBrain = U3DUtil.Get<CinemachineBrain>(Camera.main.gameObject);
		U3DUtil.Get<PhysicsRaycaster>(Camera.main.gameObject);
		LoadBySceneMode();
	}

	public void ExitScene()
	{
		mScene = null;
		context.captureManager?.Dispose();
		context = null;
	}

	public void Update()
	{
		if (context != null)
		{
			context.interationManager?.Tick();
		}
	}

	public void LateUpdate()
	{
		if (context != null)
		{
			context.captureManager?.LateTick();
		}
	}

	public void LoadBySceneMode()
	{
		switch (context.sceneMode)
		{
		case OathConst.OathSceneMode.CAPTURE:
			LoadCapture();
			break;
		case OathConst.OathSceneMode.BOOK_RE:
			LoadCapture();
			break;
		case OathConst.OathSceneMode.SHARE:
			LoadCapture();
			break;
		case OathConst.OathSceneMode.OATH:
			LoadInteration();
			break;
		}
	}

	public void LoadCapture()
	{
		context.captureManager = new OathCaptureManager();
		context.captureManager.EnterCaptureMode();
		LuaHelper.CallFunction("OathToLuaBridge.OathLoadModel", context.captureManager.captureContext.modelObj);
	}

	private void InitOathData()
	{
		object[] array = LuaHelper.CallFunction("OathToLuaBridge.IsOath");
		bool isAlreadyOath = array != null && array.Length != 0 && (bool)array[0];
		context.isAlreadyOath = isAlreadyOath;
	}

	public void LoadInteration()
	{
		context.interationManager = new OathInterationManager();
		context.interationManager.Init();
		InitOathData();
	}

	public void ChangeToCaptureMode()
	{
		ExitInteration();
		context.sceneMode = OathConst.OathSceneMode.CAPTURE;
		LuaHelper.CallFunction("OathToLuaBridge.OathEnterScene", (int)context.sceneMode, true);
		LoadCapture();
		RefreshDither();
	}

	private void RefreshDither()
	{
		int num = context.sceneName.LastIndexOf('/');
		GameObject[] rootGameObjects = SceneManager.GetSceneByName(context.sceneName.Substring(num + 1)).GetRootGameObjects();
		for (int i = 0; i < rootGameObjects.Length; i++)
		{
			QWSceneDitherComponennt[] componentsInChildren = rootGameObjects[i].GetComponentsInChildren<QWSceneDitherComponennt>(includeInactive: true);
			if (componentsInChildren != null && componentsInChildren.Length != 0)
			{
				QWSceneDitherComponennt[] array = componentsInChildren;
				foreach (QWSceneDitherComponennt obj in array)
				{
					obj.enabled = false;
					obj.enabled = true;
				}
			}
		}
	}

	public void ExitInteration()
	{
		context.interationManager?.Dispose();
		context.interationManager = null;
	}
}
