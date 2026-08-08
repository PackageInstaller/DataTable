using System.Collections;
using Cinemachine;
using UnityEngine;

public class CooperateSkillSceneLoader : NScene
{
	public override IEnumerator OnLoadCoroutine()
	{
		yield return null;
		AssetBundleLoadOperation ops = Asset.LoadLevelAsync("Levels/X109", isAddtive: true);
		while (!ops.IsDone())
		{
			yield return null;
		}
		Camera.main.gameObject.AddComponent<CinemachineBrain>();
		yield return null;
		LuaHelper.CallFunction("HeroCooperationBridge.SetUpCooperation");
		yield return null;
	}

	public override void OnSceneLoaded()
	{
		LuaHelper.CallFunction("HeroCooperationBridge.OnCooperationSceneLoaded");
	}

	public override void OnSceneExit(NScene nextScene)
	{
		base.OnSceneExit(nextScene);
		LuaHelper.CallFunction("HeroCooperationBridge.OnCooperationSceneExit");
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
