using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT;

internal class TempleWorld : WorldBase
{
	private int _templeId;

	internal override SceneStatus SceneStatus => SceneStatus.Temple;

	internal override void InitWorldData(WorldData data)
	{
		_worldData = data;
		_templeId = Model<TempleModel>.Interface.CurChallengeTempleId;
		InstanceDungeon instanceDungeon = RuntimeConfigs.data.instanceDungeons[Model<TempleModel>.Interface.CurChallengeTempleId];
		_worldData.WorldID = instanceDungeon.id;
		_worldData.WorldConfigId = RuntimeConfigs.data.gameWorlds[instanceDungeon.id].config;
		_worldData.WorldConfigPath = $"World/{_worldData.WorldConfigId}";
		_worldData.SpawnPosition = GetLastPos();
		_worldData.TeamInfo = G.localPlayer.teamInfo.Teams[(int)SceneStatus].Teams[_worldData.TeamIndex];
		TempleData curChallengeTempleData = Model<TempleModel>.Interface.GetCurChallengeTempleData();
		Model<TempleModel>.Interface.RecordChallengeInfo(curChallengeTempleData?.stageChallengeTarget);
		Model<TempleModel>.Interface.ClearReceivedRobots();
		PrepareChallengeTargets();
	}

	internal override void UninitWorldData()
	{
		_templeId = 0;
		Model<TempleModel>.Interface.ClearReceivedRobots();
	}

	internal override void OnWorldRuntimeFixedTick()
	{
		if (Model<ChallengeTargetTrackerModel>.HasInstance() && Model<ChallengeTargetTrackerModel>.Interface.IsTracking)
		{
			Model<ChallengeTargetTrackerModel>.Interface.EvaluateRuntimeTargets();
		}
	}

	protected override void AddListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AllCharacterDieEnd, AllCharacterDie);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Game_Start, OnGameStart);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.WorldSuccess, OnWorldSuccess);
	}

	protected override void RemoveListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AllCharacterDieEnd, AllCharacterDie);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Game_Start, OnGameStart);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.WorldSuccess, OnWorldSuccess);
	}

	protected override async void OnFail()
	{
		G.service.TempleFailure(null);
		await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_COMMONWORLDFAIL);
	}

	protected override Vector3 GetLastPos()
	{
		Vector3 zero = Vector3.zero;
		_worldData.UseWorldSpawnPosition = true;
		return zero;
	}

	protected override async UniTask OnBeforeEnterWorld()
	{
		ReportEnterTeample();
	}

	protected override async UniTask OnAfterEnterWorld()
	{
		MonoECS.instance.PopPause();
		_ = RuntimeConfigs.data.instanceDungeons[Model<TempleModel>.Interface.CurChallengeTempleId];
		Model<TempleModel>.Interface.ResetTimer();
		Model<TempleModel>.Interface.AddBuffAfterEnterBattleTemple();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.ShowTargetRoot, null);
		StartChallengeTracking();
	}

	protected override async UniTask OnBeforeReopenWorld()
	{
		bool isFail = Singleton<GameState>.instance.PlayerAlive != PlayerLiveState.Normal;
		ReportReopenTemple(isFail);
	}

	protected override UniTask OnBeforeLeaveWorld()
	{
		bool isFail = Singleton<GameState>.instance.PlayerAlive != PlayerLiveState.Normal;
		ReportWorldLeave(isFail);
		return UniTask.CompletedTask;
	}

	internal override Character GetCharacter(int characterId)
	{
		throw new NotImplementedException();
	}

	private void PrepareChallengeTargets()
	{
		if (!Model<ChallengeTargetTrackerModel>.HasInstance() || RuntimeConfigs.data?.instanceDungeons == null || RuntimeConfigs.data.ruless == null || !RuntimeConfigs.data.instanceDungeons.TryGetValue(_templeId, out var value) || value?.reward == null)
		{
			if (Model<ChallengeTargetTrackerModel>.HasInstance())
			{
				Model<ChallengeTargetTrackerModel>.Interface.Clear();
			}
			return;
		}
		List<ChallengeTargetDefinition> list = new List<ChallengeTargetDefinition>(value.reward.Count);
		foreach (ItemKv item in value.reward)
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
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.TempleInteractRefresh, null);
		}
	}

	private void OnGameStart(BaseEventContent content)
	{
		Model<TempleModel>.Interface.OpenBuffSelectViewAfterEnterWorld();
	}

	private void ReportEnterTeample()
	{
	}

	private void ReportReopenTemple(bool isFail)
	{
	}

	private void ReportWorldLeave(bool isFail)
	{
		_ = Singleton<GameState>.instance.WorldLoadState;
		MovementEvent evt = EventTrackSolver.Instance.GetEvt<MovementEvent>();
		evt.pos = MonoECS.instance.mainEntity.GetCompTransform().physicsPosition;
		evt.eventType = 5;
		evt.swid = 0f;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	private void ReportFailTemple(bool isFail)
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
