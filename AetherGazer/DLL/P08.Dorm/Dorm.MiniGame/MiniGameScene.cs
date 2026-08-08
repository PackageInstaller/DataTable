using System.Collections;
using Cinemachine;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Dorm.MiniGame;

internal class MiniGameScene : NScene
{
	public CinemachineBrain cinemachineBrain;

	private float loadProgress;

	public override float Progress
	{
		get
		{
			return loadProgress;
		}
		set
		{
			loadProgress = value;
			LoadingUIManager.inst.SetUIProgress(value);
		}
	}

	public override void ShowLoadUI()
	{
		LoadingUIManager.inst.ShowLoadUI();
	}

	public override void CloseLoadUI()
	{
		LoadingUIManager.inst.CloseLoadUI();
	}

	public override IEnumerator OnLoadCoroutine()
	{
		AssetBundleLoadOperation op = Asset.LoadLevelAsync("Levels/" + sceneName, isAddtive: true);
		while (!op.IsDone())
		{
			yield return null;
		}
		Camera main = Camera.main;
		U3DUtil.Get<PhysicsRaycaster>(main.gameObject).eventMask = -5;
		cinemachineBrain = U3DUtil.Get<CinemachineBrain>(main.gameObject);
		DormCameraManager.SetCinemachineBrainParams(cinemachineBrain);
		cinemachineBrain.enabled = false;
		RoomWallTag.mainCameraTrs = main.transform;
		yield return null;
		GameObject gameObject = GameObject.Find("UICamera/Canvas/UIScreenTap");
		if ((bool)gameObject)
		{
			Asset.InstantiateWithoutCache("UI/ScreenTapUI", gameObject.transform);
		}
	}

	public override void OnSceneReady()
	{
		DormTagBase.Collect(GameObject.FindGameObjectsWithTag("Scene"));
		LuaHelper.GetFunc("OnEnterMiniGameScene")?.Call(sceneName);
	}

	public override void OnSceneExit(NScene nextScene)
	{
		string arg = (nextScene ? nextScene.sceneName : "");
		LuaHelper.GetFunc("OnExitMiniGameScene")?.Call(sceneName, arg);
		DormTagBase.Cleanup();
		cinemachineBrain = null;
	}
}
