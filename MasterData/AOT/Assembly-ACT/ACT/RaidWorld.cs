using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.MissionSystem;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.UI;
using ACT.Utility;
using ACT.World;
using ACT.World.Asset;
using ACT.World.SceneChunks;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.World.SceneChunks;
using UnityEngine;

namespace ACT;

internal class RaidWorld : WorldBase
{
	internal override SceneStatus SceneStatus => SceneStatus.Raid;

	private int _raidId => Model<RaidModel>.Interface.CurrentRaidId;

	internal override void InitWorldData(WorldData data)
	{
		_worldData = data;
		_worldData.WorldID = _raidId;
		if (RuntimeConfigs.data.raids.TryGetValue(_raidId, out var _))
		{
			_worldData.WorldConfigId = RuntimeConfigs.data.gameWorlds[_raidId].config;
			_worldData.WorldConfigPath = $"World/{_worldData.WorldConfigId}";
			_worldData.UseWorldSpawnPosition = true;
			_worldData.TeamInfo = G.localPlayer.teamInfo.Teams[(int)SceneStatus].Teams[_worldData.TeamIndex];
		}
		Model<RaidModel>.Interface.SetRaidInfo(_worldData.IsReconnect);
		ACT.Game.Data.Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(_raidId);
		Model<RaidModel>.Interface.RecordChallengeInfo(raidInfo?.Target);
		if (Model<TeamTeachingModel>.Interface.TryPrepareCurrentRaid(_raidId))
		{
			if (Model<BattleMainModel>.HasInstance())
			{
				Model<BattleMainModel>.Interface.ChangeHudType(HudType.TeamTeaching);
			}
		}
		else
		{
			PrepareRaidChallengeTargets();
		}
	}

	internal override void UninitWorldData()
	{
		if (Model<ChallengeTargetTrackerModel>.HasInstance())
		{
			Model<ChallengeTargetTrackerModel>.Interface.StopTracking();
		}
	}

	internal override void Update()
	{
		base.Update();
		Model<TeamTeachingModel>.Interface.UpdateNonBlueprintChallengeTracking();
	}

	internal override void OnWorldRuntimeFixedTick()
	{
		Model<TeamTeachingModel>.Interface.TickChallengeRuntime();
	}

	internal override void OnCharacterDie(Entity beahve)
	{
		if (TryChangeToAliveEntity(out var entityBehave) && entityBehave.IsValid)
		{
			MonoECS.instance.ChangeCharacter(entityBehave);
			if (Model<RaidModel>.Interface.IsParkourRaid)
			{
				OnRaidTrapRecovery();
			}
		}
	}

	private void OnMissionSuccess(BaseEventContent evt)
	{
		if (evt is MissionNSuccessEvt missionNSuccessEvt)
		{
			RuntimeConfigs.data.raids.TryGetValue(Model<RaidModel>.Interface.CurrentRaidId, out var value);
			if (value != null && value.bindMissionGroupId != 0 && RuntimeConfigs.data.missionRGroups.TryGetValue(value.bindMissionGroupId, out var value2) && Singleton<MissionManager>.instance.GetMissionData(missionNSuccessEvt.missionId).Config.Group == value2 && missionNSuccessEvt.missionId == value2.lastMission)
			{
				Model<RaidModel>.Interface.RaidSettlement();
			}
		}
	}

	private void OnMissionFailure(BaseEventContent evt)
	{
		if (evt is MissionNFailureEvt missionNFailureEvt)
		{
			RuntimeConfigs.data.raids.TryGetValue(Model<RaidModel>.Interface.CurrentRaidId, out var value);
			if (value != null && value.bindMissionGroupId != 0 && Singleton<MissionManager>.instance.GetMissionData(missionNFailureEvt.missionId).Config.MissionBase.groupID == value.bindMissionGroupId)
			{
				WorldChallengeState = WorldChallengeState.Fail;
			}
		}
	}

	protected override void AddListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AllCharacterDieEnd, AllCharacterDie);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.WorldSuccess, OnWorldSuccess);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.RaidCountDownEnd, OnRaidCountDownEnd);
	}

	protected override void RemoveListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AllCharacterDieEnd, AllCharacterDie);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.WorldSuccess, OnWorldSuccess);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RaidCountDownEnd, OnRaidCountDownEnd);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_Success, OnMissionSuccess);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_Failure, OnMissionFailure);
	}

	protected override async void OnFail()
	{
		G.service.RaidFailure(null);
		await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_COMMONWORLDFAIL);
	}

	protected override async UniTask OnAfterEnterWorld()
	{
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Raid_Enter, null);
		if (Model<RaidModel>.Interface.IsParkourRaid)
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.RaidTrapRecovery, OnRaidTrapRecovery);
		}
		Model<RaidModel>.Interface.ResetTimer();
		StartRaidChallengeTracking();
		if (Model<TeamTeachingModel>.Interface.IsTeamTeachingRaid() && LuminApplication.LogEnabled)
		{
			Debug.Log($"[TeamTeaching][ChallengeTarget] 副本加载完成 raidId={Model<RaidModel>.Interface.CurrentRaidId}, " + "targetIds=[" + string.Join(",", Model<TeamTeachingModel>.Interface.TargetConditionIds) + "], " + $"monsterPointCount={Model<TeamTeachingModel>.Interface.ActiveMonsterPointCount}, " + $"hasWorldBlueprint={HasConfiguredWorldBlueprint()}, " + $"hasLevelBlueprint={HasConfiguredLevelBlueprint()}, " + $"tracking={Model<ChallengeTargetTrackerModel>.Interface.IsTracking}");
		}
		ReportOnRaidStart();
		await LoadOpeingSettlementResource();
	}

	private void PrepareRaidChallengeTargets()
	{
		if (!Model<ChallengeTargetTrackerModel>.HasInstance() || RuntimeConfigs.data?.raids == null || RuntimeConfigs.data.ruless == null || !RuntimeConfigs.data.raids.TryGetValue(_raidId, out var value) || value?.firstReward == null)
		{
			if (Model<ChallengeTargetTrackerModel>.HasInstance())
			{
				Model<ChallengeTargetTrackerModel>.Interface.Clear();
			}
			return;
		}
		List<ChallengeTargetDefinition> list = new List<ChallengeTargetDefinition>(value.firstReward.Count);
		foreach (ItemKv item in value.firstReward)
		{
			int num = item?.id ?? 0;
			if (num > 0 && RuntimeConfigs.data.ruless.TryGetValue(num, out var value2) && value2 != null)
			{
				list.Add(new ChallengeTargetDefinition(num, value2));
			}
		}
		Model<ChallengeTargetTrackerModel>.Interface.Prepare(list);
	}

	private static void StartRaidChallengeTracking()
	{
		Model<TeamTeachingModel>.Interface.TryPrepareCurrentRaid(Model<RaidModel>.Interface.CurrentRaidId);
		if (!Model<ChallengeTargetTrackerModel>.HasInstance() || Model<ChallengeTargetTrackerModel>.Interface.IsTracking)
		{
			return;
		}
		if (Model<TeamTeachingModel>.Interface.IsTeamTeachingRaid())
		{
			if (Model<TeamTeachingModel>.Interface.RequiresAutomaticSceneTracking && !HasConfiguredWorldBlueprint() && (!HasConfiguredLevelBlueprint() || !Model<TeamTeachingModel>.Interface.HasActiveMonsterPoint))
			{
				Model<TeamTeachingModel>.Interface.BeginNonBlueprintChallengeTracking();
			}
		}
		else
		{
			Model<ChallengeTargetTrackerModel>.Interface.BeginTracking();
		}
	}

	private static bool HasConfiguredWorldBlueprint()
	{
		ConfigWorldPartition_v2 configWorldPartition_v = Singleton<GameManager>.instance.worldManager.ChunkModule?.ActivePartition;
		if (configWorldPartition_v == null)
		{
			return false;
		}
		YooAssetReference worldBluePrintAssetID = configWorldPartition_v.WorldBluePrintAssetID;
		if (worldBluePrintAssetID != null)
		{
			return !string.IsNullOrEmpty(worldBluePrintAssetID.GUID);
		}
		return false;
	}

	private static bool HasConfiguredLevelBlueprint()
	{
		if (!(Singleton<GameManager>.instance.worldManager.ActiveChunk is SceneChunkRuntimeControlBase { Data: var data } sceneChunkRuntimeControlBase) || data?.SubScenes == null)
		{
			return true;
		}
		SceneBlock[] subScenes = sceneChunkRuntimeControlBase.Data.SubScenes;
		for (int i = 0; i < subScenes.Length; i++)
		{
			YooAssetReference yooAssetReference = subScenes[i]?.LevelBlueprintAssetRef;
			if (yooAssetReference != null && !string.IsNullOrEmpty(yooAssetReference.GUID))
			{
				return true;
			}
		}
		return false;
	}

	internal override Character GetCharacter(int characterId)
	{
		return null;
	}

	protected override async UniTask OnBeforeLeaveWorld()
	{
		bool isFail = Singleton<GameState>.instance.PlayerAlive != PlayerLiveState.Normal;
		ReportOnRaidLeave(isFail);
		MonoECS.instance.IsLoadSubScene = true;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Raid_Exit, null);
	}

	protected override async UniTask OnAfterLeaveWorld()
	{
		if (Model<RaidModel>.Interface.IsParkourRaid)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RaidTrapRecovery, OnRaidTrapRecovery);
		}
		Model<RaidModel>.Interface.LeaveParkourRaid();
	}

	protected override async UniTask OnBeforeReopenWorld()
	{
		bool needRespawn = Singleton<GameState>.instance.PlayerAlive != PlayerLiveState.Normal;
		ReportOnRaidRestart(needRespawn);
	}

	protected override async UniTask OnAfterReopenWorld()
	{
		ReportOnRaidStart();
	}

	private void ReportOnRaidStart()
	{
		RuntimeConfigs.data.raids.TryGetValue(Model<RaidModel>.Interface.CurrentRaidId, out var value);
		if (value != null && value.bindMissionGroupId != 0)
		{
			RuntimeConfigs.data.missionRGroups.TryGetValue(value.bindMissionGroupId, out var missionRGroup);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_Success, OnMissionSuccess);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_Failure, OnMissionFailure);
			for (int i = 0; i < missionRGroup.missions.Length; i++)
			{
				int missionId = missionRGroup.missions[i];
				Singleton<MissionManager>.instance.RequestFailureMission(missionId);
			}
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_Success, OnMissionSuccess);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_Failure, OnMissionFailure);
			Singleton<MissionManager>.instance.RequestAcceptMission(missionRGroup.firstMission, (bool r) =>
			{
				if (r)
				{
					Singleton<MissionManager>.instance.RequestTracingMission(missionRGroup.firstMission);
				}
			}).Forget();
		}
		if (Model<BattleMainModel>.Interface.isCharacterTutorial)
		{
			TeachingTrainGround evt = EventTrackSolver.Instance.GetEvt<TeachingTrainGround>();
			evt.status = 1;
			evt.result = 1;
			evt.processId = 0;
			EventTrackSolver.Instance.Dispatch(evt);
		}
		else
		{
			_ = Singleton<GameState>.instance.WorldLoadState;
			if (Model<RaidModel>.Interface.IsParkourRaid)
			{
				RuntimeConfigs.data.raidParkourDatas.TryGetValue(Model<RaidModel>.Interface.CurrentRaidId, out var _);
			}
		}
	}

	private void ReportOnRaidLeave(bool isFail)
	{
		bool flag = (Singleton<GameState>.instance.WorldLoadState & WorldLoadState.GiveUp) > WorldLoadState.None;
		float eventDuration = (float)(System.DateTime.Now - _worldStartTime).TotalSeconds;
		if (Model<BattleMainModel>.Interface.isCharacterTutorial)
		{
			TeachingTrainGround evt = EventTrackSolver.Instance.GetEvt<TeachingTrainGround>();
			evt.status = 4;
			evt.result = ((!flag) ? 1 : 2);
			evt.eventDuration = eventDuration;
			evt.processId = 0;
			EventTrackSolver.Instance.Dispatch(evt);
			return;
		}
		_ = Singleton<GameState>.instance.WorldLoadState;
		if (Model<RaidModel>.Interface.IsParkourRaid)
		{
			RuntimeConfigs.data.raidParkourDatas.TryGetValue(Model<RaidModel>.Interface.CurrentRaidId, out var _);
		}
		MovementEvent evt2 = EventTrackSolver.Instance.GetEvt<MovementEvent>();
		evt2.pos = MonoECS.instance.mainEntity.GetCompTransform().physicsPosition;
		evt2.eventType = 5;
		evt2.swid = 0f;
		EventTrackSolver.Instance.Dispatch(evt2);
	}

	private void ReportOnRaidRestart(bool needRespawn)
	{
		RuntimeConfigs.data.raids.TryGetValue(Model<RaidModel>.Interface.CurrentRaidId, out var value);
		if (value != null && value.bindMissionGroupId != 0)
		{
			RuntimeConfigs.data.missionRGroups.TryGetValue(value.bindMissionGroupId, out var missionRGroup);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_Success, OnMissionSuccess);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_Failure, OnMissionFailure);
			for (int i = 0; i < missionRGroup.missions.Length; i++)
			{
				int missionId = missionRGroup.missions[i];
				Singleton<MissionManager>.instance.RequestFailureMission(missionId);
			}
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_Success, OnMissionSuccess);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_Failure, OnMissionFailure);
			Singleton<MissionManager>.instance.RequestAcceptMission(missionRGroup.firstMission, (bool r) =>
			{
				if (r)
				{
					Singleton<MissionManager>.instance.RequestTracingMission(missionRGroup.firstMission);
				}
			}).Forget();
		}
		float eventDuration = (float)(System.DateTime.Now - _worldStartTime).TotalSeconds;
		if (Model<BattleMainModel>.Interface.isCharacterTutorial)
		{
			TeachingTrainGround evt = EventTrackSolver.Instance.GetEvt<TeachingTrainGround>();
			evt.status = 4;
			evt.result = ((!needRespawn) ? 1 : 2);
			evt.eventDuration = eventDuration;
			EventTrackSolver.Instance.Dispatch(evt);
		}
		else
		{
			_ = Singleton<GameState>.instance.WorldLoadState;
			_ = Model<RaidModel>.Interface.IsParkourRaid;
		}
	}

	internal void OnRaidTrapRecovery(BaseEventContent evt)
	{
		OnRaidTrapRecovery();
	}

	internal async void OnRaidTrapRecovery()
	{
		Entity entity = MonoECS.instance.mainEntity;
		if (Singleton<GameState>.instance.MainPlayerState == MainPlayerState.InTrapTp || !Model<RaidModel>.Interface.IsParkourRaid || (entity.GetCompAbility().hp <= 0 && IsAllCharacterDead()))
		{
			return;
		}
		Singleton<GameState>.instance.SeMainPlayerState(MainPlayerState.InTrapTp);
		entity.GetCompBehave().EntityTags.AddTag(EntityTag.IgnoreAttack);
		Model<RaidModel>.Interface.ParkourTrapTimes++;
		Model<ChallengeTargetTrackerModel>.Interface.OnTriggerTrap();
		if (!RuntimeConfigs.data.raidParkourDatas.TryGetValue(_raidId, out var value) || (value.defaultLimit > 0 && Model<RaidModel>.Interface.ParkourTrapTimes >= value.defaultLimit))
		{
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_COMMONWORLDFAIL);
			return;
		}
		int checkPosUid = G.localPlayer.Profile.SceneInfos[(int)MonoECS.instance.sceneStatus].CheckPosUid;
		RaidCheckPointData raidCheckPointData = ((checkPosUid == 0) ? null : (Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(checkPosUid) as RaidCheckPointData));
		int state = 0;
		Vector3 targetPos;
		if (raidCheckPointData == null)
		{
			state = 1;
			targetPos = Singleton<GameManager>.instance.worldManager.ActiveWorld.GetSpawnPosition();
		}
		else
		{
			state = raidCheckPointData.trapState;
			targetPos = raidCheckPointData.initPos;
		}
		RaidTrapStopChange raidTrapStop = new RaidTrapStopChange
		{
			isStop = true
		};
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.RaidTrapStopChange, raidTrapStop);
		TeleportParams teleportParams = new TeleportParams
		{
			targetPos = targetPos,
			faceLeft = false,
			forceToFloor = true,
			revive = false
		};
		BlackScreenParams blackScreenParams = new BlackScreenParams
		{
			leastDuration = 1f,
			fadeInDuration = 0.5f,
			fadeOutDuration = 0.5f
		};
		await TeleportUtility.TeleportWithBlackScreen(Singleton<GameManager>.instance.worldManager.ActiveChunkId, teleportParams, blackScreenParams, () => RaidTrapTriggerEvent(state));
		raidTrapStop.isStop = false;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.RaidTrapStopChange, raidTrapStop);
		entity.GetCompBehave().EntityTags.RemoveTag(EntityTag.IgnoreAttack);
		Singleton<GameState>.instance.SeMainPlayerState(MainPlayerState.None);
	}

	private UniTask RaidTrapTriggerEvent(int state)
	{
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.RaidTrapTriggerEvent, new RaidTrapTriggerEvt
		{
			state = state
		});
		return UniTask.CompletedTask;
	}

	private bool IsAllCharacterDead()
	{
		MPPlayer localPlayer = MonoECS.instance.localPlayer;
		Entity switchCharacter = localPlayer.GetSwitchCharacter(0);
		Entity switchCharacter2 = localPlayer.GetSwitchCharacter(1);
		if (!switchCharacter.IsAlive())
		{
			return !switchCharacter2.IsAlive();
		}
		return false;
	}

	private void AllCharacterDie(BaseEventContent evt)
	{
		WorldChallengeState = WorldChallengeState.Fail;
	}

	private void OnRaidCountDownEnd(BaseEventContent evt)
	{
		WorldChallengeState = WorldChallengeState.Fail;
	}

	private void OnWorldSuccess(BaseEventContent baseEventContent)
	{
		WorldChallengeState = WorldChallengeState.Success;
	}

	private async UniTask LoadOpeingSettlementResource()
	{
		int worldID = _worldData.WorldID;
		if (Model<RaidModel>.Interface.GetRaidType(worldID) == 7)
		{
			_ = CoreUtils.GetData(worldID, RuntimeConfigs.data.raids).belongEntranceData;
			_ = 101;
		}
	}
}
