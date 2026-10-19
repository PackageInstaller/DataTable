using System.Collections.Generic;
using ACT.Battle;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Net;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf;
using Lumin.LoungeSystem;
using Lumin.LoungeSystem.UI;
using Pb;

namespace ACT;

internal class LoungeWorld : WorldBase
{
	internal override SceneStatus SceneStatus => SceneStatus.Lounge;

	internal override void InitWorldData(WorldData data)
	{
		_worldData = data;
		_worldData.WorldID = 6;
		_worldData.WorldConfigId = data.WorldID;
		_worldData.SpawnPosition = GetLastPos();
	}

	internal override void UninitWorldData()
	{
		G.localPlayer.teamInfo.Teams.Remove((int)SceneStatus);
	}

	internal override void Update()
	{
	}

	internal override async UniTask EnterWorld(SceneLoadProgressHandle progressHandle = null)
	{
		LoungeEnterAck ackMsg = null;
		G.service.RequestEnterLounge((IMessage msg) =>
		{
			if (msg is LoungeEnterAck loungeEnterAck)
			{
				ackMsg = loungeEnterAck;
			}
		});
		UniTask waitRst = UniTask.WaitUntil(() => ackMsg != null);
		if (progressHandle != null)
		{
			progressHandle.AddStep(() => waitRst);
			progressHandle.AddStep(() => InitLoungeWorld(ackMsg));
			progressHandle.AddStep(OpenUI);
			progressHandle.AddStep(PopPause);
			progressHandle.AddStep(LoungeUIScene.Load);
			progressHandle.AddStep(AfterLoungeSceneLoaded);
			progressHandle.AddStep(Singleton<LoungeSystemManager>.instance.CheckGlobalStoryPlay);
			progressHandle.AddStep(OnAfterEnterWorld);
			await progressHandle.ExecuteAll();
		}
		else
		{
			await waitRst;
			await InitLoungeWorld(ackMsg);
			await OpenUI();
			await PopPause();
			await LoungeUIScene.Load();
			await AfterLoungeSceneLoaded();
			await Singleton<LoungeSystemManager>.instance.CheckGlobalStoryPlay();
			await OnAfterEnterWorld();
		}
	}

	private async UniTask PopPause()
	{
		MonoECS.instance.PopPause();
		await UniTask.CompletedTask;
	}

	protected override async UniTask OnAfterEnterWorld()
	{
		_worldStartTime = TimeManager.ServerTime.Now;
		Singleton<GameState>.instance.SetWorldState(WorldState.Normal);
		await UniTask.WaitForSeconds(0.5f);
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Backyard/Open");
	}

	private async UniTask InitLoungeWorld(LoungeEnterAck msg)
	{
		Model<LoungeModel>.Interface.OnLoungeNtf(msg.LoungeInfo);
		Singleton<GameState>.instance.SetWorldState(WorldState.Enter);
		Singleton<LoungeSystemManager>.CreateInstance();
		Singleton<LoungeSystemManager>.instance.Init();
		Singleton<NewUIManager>.instance.HudUITYPE = UI_TYPE.UI_LOUNGEMAIN;
	}

	internal override async UniTask LeaveWorld()
	{
		LoungeUIScene.instance.RecordExitLiveArea();
		Singleton<GameState>.instance.SetWorldState(WorldState.Leave);
		Singleton<NewUIManager>.instance.HudUITYPE = UI_TYPE.UI_BATTLEMAIN;
		await OnBeforeLeaveWorld();
		await DestroyWorld();
		await OnAfterLeaveWorld();
		RemoveListener();
		Singleton<GameState>.instance.SetWorldState(WorldState.None);
	}

	protected override void AddListener()
	{
	}

	protected override void RemoveListener()
	{
	}

	protected override async UniTask OnBeforeEnterWorld()
	{
		base.OnBeforeEnterWorld();
	}

	private async UniTask OpenUI()
	{
		await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_LOUNGEMAIN);
	}

	protected override async UniTask OnAfterLeaveWorld()
	{
		await LeaveLounge();
	}

	internal override Character GetCharacter(int characterId)
	{
		return null;
	}

	private async UniTask AfterLoungeSceneLoaded()
	{
		Singleton<LoungeSystemManager>.instance.SetCurrentLoungePoint(LoungeUIScene.instance.ModelsPointPosGroup);
		InitLoungeDataAndModel();
		LoungeUIScene.instance.RefreshMainViewInfo();
		LoungeUIScene.Push();
		await UniTask.CompletedTask;
	}

	private async UniTask LeaveLounge()
	{
		LoungeLeaveReq data = new LoungeLeaveReq();
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			_ = msg is LoungeLeaveAck;
		});
		Singleton<LoungeSystemManager>.DestroyInstance();
		LoungeUIScene.Pop();
		await LoungeUIScene.UnLoadPrefab();
		Model<LoungeModel>.Interface.ClearData();
	}

	private void InitLoungeDataAndModel()
	{
		Singleton<LoungeSystemManager>.instance.InitLoungeStoryTimeline();
		Dictionary<int, int> characterToIndex = Model<LoungeModel>.Interface.CharacterToIndex;
		foreach (int key in characterToIndex.Keys)
		{
			Singleton<LoungeSystemManager>.instance.CharacterManager.InitializeCharacter(key);
		}
		LoungeUIScene.instance.DoShowRandomModels(characterToIndex);
		Singleton<LoungeSystemManager>.instance.RefreshCharacterInteractions();
	}
}
