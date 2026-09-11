using System.Collections;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Dorm.Illu;

internal class DormIlluScene : NScene
{
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
		U3DUtil.Get<PhysicsRaycaster>(Camera.main.gameObject).eventMask = -5;
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
		LuaHelper.GetFunc("OnEnterDormIlluScene")?.Call(sceneName);
	}

	public override void OnSceneExit(NScene nextScene)
	{
		LuaHelper.GetFunc("OnExitDormIlluScene")?.Call(sceneName, nextScene.sceneName);
		DormTagBase.Cleanup();
	}
}
