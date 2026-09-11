using System.Collections;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ZumaGame;

public class BlisterGameSceneLoader : NScene
{
	public string mapName;

	public BlisterController gamePlay;

	public override void OnSceneReady()
	{
		BlisterController.Instance.LoadMap(mapName);
		BlisterController.Instance.StartGame();
		LuaHelper.CallFunction("BlisterToluaBridge.OnBlisterGameSceneReady");
	}

	public override IEnumerator OnLoadCoroutine()
	{
		yield return null;
		AssetBundleLoadOperation ops = Asset.LoadLevelAsync("Levels/X1098", isAddtive: true);
		while (!ops.IsDone())
		{
			yield return null;
		}
		Camera.main.gameObject.AddComponent<PhysicsRaycaster>();
		yield return null;
		LuaHelper.CallFunction("BlisterToluaBridge.SetBlisterCamParam");
	}

	public override void OnSceneLoaded()
	{
		LuaHelper.CallFunction("BlisterToluaBridge.OnBlisterGameSceneLoaded");
	}

	public override void OnSceneExit(NScene nextScene)
	{
		base.OnSceneExit(nextScene);
		LuaHelper.CallFunction("BlisterToluaBridge.OnBlisterGameSceneExit");
	}

	public void StartGame()
	{
	}

	public void SetGameConfig(string mapName)
	{
		this.mapName = mapName;
	}

	public void PauseGame()
	{
		BlisterController.Instance.PauseGame();
	}

	public void ReStartGame()
	{
		BlisterController.Instance.ReStartGame();
	}

	public float GetCurTime()
	{
		return 0.1f;
	}

	private void LateUpdate()
	{
		SetUIProgress(Progress);
	}

	public override void ShowLoadUI()
	{
		LoadingUIManager.inst.ShowLoadUI();
	}

	protected void SetUIProgress(float value)
	{
		LoadingUIManager.inst.SetUIProgress(value);
	}

	public override void CloseLoadUI()
	{
		LoadingUIManager.inst.CloseLoadUI();
	}
}
