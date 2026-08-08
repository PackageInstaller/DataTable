using System.Collections;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ZumaGame;

public class ZumaSceneLoader : NScene
{
	public ZumaDataForExchange exchangeData;

	public ZumaGamePlay zumaGamePlay;

	public override IEnumerator OnLoadCoroutine()
	{
		yield return null;
		AssetBundleLoadOperation ops = Asset.LoadLevelAsync("Levels/X108", isAddtive: true);
		while (!ops.IsDone())
		{
			yield return null;
		}
		Camera.main.gameObject.AddComponent<PhysicsRaycaster>();
		yield return null;
		LuaHelper.CallFunction("ZumaToLuaBridge.SetUpZuma");
		yield return null;
		zumaGamePlay = Object.FindObjectOfType<ZumaGamePlay>();
		zumaGamePlay.InitConfig(exchangeData);
		yield return null;
	}

	public override void OnSceneLoaded()
	{
		LuaHelper.CallFunction("ZumaToLuaBridge.OnZumaSceneLoaded");
	}

	public override void OnSceneExit(NScene nextScene)
	{
		zumaGamePlay.ExitGame();
		base.OnSceneExit(nextScene);
		LuaHelper.CallFunction("ZumaToLuaBridge.OnZumaSceneExit");
	}

	public void StartZumaGame()
	{
		zumaGamePlay.StartGame();
	}

	public void SetGameConfig(ZumaDataForExchange data)
	{
		exchangeData = data;
	}

	public void PauseZumaGame()
	{
		zumaGamePlay.PauseZumaGame();
	}

	public void ReStartZumaGame()
	{
		zumaGamePlay.ReStartZumaGame();
	}

	public void ReChallengeZumaGame(ZumaDataForExchange data)
	{
		zumaGamePlay.ReChallengeZumaGame(data);
	}

	public void UseZumaSkill()
	{
		zumaGamePlay.UseZumaSkill();
	}

	public void SetZumaGameCountdownUI(Animator timeAni, Text timeCountdownUI, Text skillCountdownUI, Image skillProgressImg)
	{
		zumaGamePlay.SetZumaGameCountdownUI(timeAni, timeCountdownUI, skillCountdownUI, skillProgressImg);
	}

	public float GetCurTime()
	{
		return zumaGamePlay.GetCurTime();
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
