using System;
using System.Collections;
using UnityEngine;
using UnityEngine.EventSystems;

public class GuildActivitySceneLoader : NScene
{
	private GuildActivityDataForExchange exchangeData;

	private GuildActivityManager guildActivityManager;

	private Action onLoadSceneComplete;

	public void SetOnLoadSceneComplete(Action handler)
	{
		onLoadSceneComplete = handler;
	}

	public override IEnumerator OnLoadCoroutine()
	{
		yield return null;
		AssetBundleLoadOperation ops = Asset.LoadLevelAsync("Levels/GuildActivity", isAddtive: true);
		while (!ops.IsDone())
		{
			yield return null;
		}
		ops = Asset.LoadLevelAsync("Levels/X100", isAddtive: true);
		while (!ops.IsDone())
		{
			yield return null;
		}
		Camera.main.gameObject.AddComponent<PhysicsRaycaster>();
		yield return null;
		guildActivityManager = GameObject.Find("gameRoot").GetComponent<GuildActivityManager>();
		guildActivityManager.LoadLevel(exchangeData.level);
		yield return null;
		onLoadSceneComplete?.Invoke();
		onLoadSceneComplete = null;
		yield return null;
	}

	public override void ShowLoadUI()
	{
		LoadingUIManager.inst.ShowLoadUI();
	}

	protected void SetUIProgress(float value)
	{
		LoadingUIManager.inst.SetUIProgress(value);
	}

	private void LateUpdate()
	{
		SetUIProgress(Progress);
	}

	public override void CloseLoadUI()
	{
		LoadingUIManager.inst.CloseLoadUI();
	}

	public void SetGameConfig(GuildActivityDataForExchange data)
	{
		exchangeData = data;
	}

	public void StartGuildActivity(int enterNodeId)
	{
		guildActivityManager.StartGame(enterNodeId);
	}

	public GuildActivityManager GetManager()
	{
		return guildActivityManager;
	}
}
