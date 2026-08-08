using System;
using System.Collections;
using UnityEngine;
using UnityEngine.EventSystems;

public class GuildActivitySPSceneLoader : NScene
{
	private GuildActivitySPDataForExchange _exchangeSpData;

	private GuildActivitySPManager _guildActivitySpManager;

	private Action onLoadSceneComplete;

	public void SetOnLoadSceneComplete(Action handler)
	{
		onLoadSceneComplete = handler;
	}

	public override IEnumerator OnLoadCoroutine()
	{
		yield return null;
		AssetBundleLoadOperation ops = Asset.LoadLevelAsync("Levels/GuildActivitySP", isAddtive: true);
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
		_guildActivitySpManager = GameObject.Find("GuildActivitySP").GetComponent<GuildActivitySPManager>();
		_guildActivitySpManager.LoadLevel(_exchangeSpData.level, _exchangeSpData.activityID);
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

	public void SetGameConfig(GuildActivitySPDataForExchange spData)
	{
		_exchangeSpData = spData;
	}

	public void StartGuildActivity(int enterNodeId)
	{
		_guildActivitySpManager.StartGame(enterNodeId);
	}

	public GuildActivitySPManager GetManager()
	{
		return _guildActivitySpManager;
	}
}
