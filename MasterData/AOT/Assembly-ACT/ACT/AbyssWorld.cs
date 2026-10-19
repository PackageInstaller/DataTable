using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT;

internal class AbyssWorld : WorldBase
{
	internal override SceneStatus SceneStatus => SceneStatus.Abyss;

	internal override void InitWorldData(WorldData data)
	{
		_worldData = data;
		Model<AbyssModel>.Interface.InitAbyssData();
		int sceneStatus = (int)SceneStatus;
		SubabyssData subabyssData = RuntimeConfigs.data.subabyssDatas[Model<AbyssModel>.Interface.CurAbyssSubStageId];
		_worldData.WorldID = subabyssData.id;
		_worldData.WorldConfigId = RuntimeConfigs.data.gameWorlds[subabyssData.id].config;
		_worldData.WorldConfigPath = $"World/{subabyssData.sceneId}";
		_worldData.UseWorldSpawnPosition = true;
		_worldData.TeamIndex = Model<AbyssModel>.Interface.CurAbyssSubStageIndex;
		_worldData.TeamInfo = G.localPlayer.teamInfo.Teams[sceneStatus].Teams[Model<AbyssModel>.Interface.CurAbyssSubStageIndex];
		if (G.localPlayer.teamInfo.CharacterRepository.TryGetValue(sceneStatus, out var value))
		{
			CharacterRepositoryModel.SetCharacterRepository(sceneStatus, value);
		}
		if (!Model<ChallengeTargetTrackerModel>.Interface.IsTracking)
		{
			PrepareChallengeTargets();
			Model<AbyssModel>.Interface.RecordChallengeInfo(Model<AbyssModel>.Interface.AbyssStages[Model<AbyssModel>.Interface.CurAbyssStageIndex].Target);
		}
	}

	internal override void UninitWorldData()
	{
		Model<AbyssModel>.Interface.UnInitAbyssData();
	}

	internal override void OnWorldRuntimeFixedTick()
	{
		if (Model<ChallengeTargetTrackerModel>.HasInstance() && Model<ChallengeTargetTrackerModel>.Interface.IsTracking)
		{
			Model<ChallengeTargetTrackerModel>.Interface.EvaluateRuntimeTargets();
		}
	}

	internal override Character GetCharacter(int characterId)
	{
		throw new NotImplementedException();
	}

	protected override void AddListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AllCharacterDieEnd, AllCharacterDie);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.WorldSuccess, OnWorldSuccess);
	}

	protected override void RemoveListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AllCharacterDieEnd, AllCharacterDie);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.WorldSuccess, OnWorldSuccess);
	}

	protected override async UniTask OnAfterEnterWorld()
	{
		ReportAbyssEnter();
		Model<AbyssModel>.Interface.ResetTimer();
		Model<AbyssModel>.Interface.ResetSubStageTimer();
		if (!Model<ChallengeTargetTrackerModel>.Interface.IsTracking)
		{
			StartChallengeTracking();
		}
	}

	protected override async UniTask OnAfterLeaveWorld()
	{
		_ = Singleton<GameState>.instance.PlayerAlive;
	}

	protected override async void OnFail()
	{
		Model<AbyssModel>.Interface.CacheSettlementTime();
		G.service.AbyssFailure(null);
		await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_COMMONWORLDFAIL);
	}

	private void PrepareChallengeTargets()
	{
		if (!Model<ChallengeTargetTrackerModel>.HasInstance() || RuntimeConfigs.data?.instanceDungeons == null || RuntimeConfigs.data.ruless == null || !RuntimeConfigs.data.abyssDatas.TryGetValue(Model<AbyssModel>.Interface.CurAbyssStageId, out var value) || value?.abyssReward == null)
		{
			if (Model<ChallengeTargetTrackerModel>.HasInstance())
			{
				Model<ChallengeTargetTrackerModel>.Interface.Clear();
			}
			return;
		}
		List<ChallengeTargetDefinition> list = new List<ChallengeTargetDefinition>(value.abyssReward.Count);
		foreach (ItemKv item in value.abyssReward)
		{
			int num = item?.id ?? 0;
			if (num > 0 && RuntimeConfigs.data.ruless.TryGetValue(num, out var value2) && value2 != null)
			{
				list.Add(new ChallengeTargetDefinition(num, value2));
			}
		}
		Model<ChallengeTargetTrackerModel>.Interface.Prepare(list);
	}

	private static void StartChallengeTracking()
	{
		if (Model<ChallengeTargetTrackerModel>.HasInstance() && !Model<ChallengeTargetTrackerModel>.Interface.IsTracking)
		{
			Model<ChallengeTargetTrackerModel>.Interface.BeginTracking();
		}
	}

	private void ReportAbyssEnter()
	{
	}

	private void ReportAbyssExit(bool isFail, bool reportSettlement = true)
	{
	}

	private void AllCharacterDie(BaseEventContent evt)
	{
		WorldChallengeState = WorldChallengeState.Fail;
	}

	private void OnWorldSuccess(BaseEventContent baseEventContent)
	{
		WorldChallengeState = WorldChallengeState.Success;
	}

	private async UniTask OnLoadingProgressDone()
	{
		await GameUtility.PlayOpeningPreformance();
		await OpenPerformanceUI();
	}

	private async UniTask OpenPerformanceUI()
	{
		await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_BATTLEMAIN);
		OnHudCpEnqueue evt = Singleton<EventManager>.instance.GetEvt<OnHudCpEnqueue>();
		evt.position = UIPosition.UpperMiddle;
		evt.type = HudComponentType.RaidOpeningPerformance;
		evt.uiData = null;
		evt.timeOutDuration = 15f;
		evt.priorityInQueue = 4;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_HudUIEnqueue, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}
