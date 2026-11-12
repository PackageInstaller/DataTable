using System;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using XLua;

public class StarTowerRoom_Regular : StarTowerRoom
{
	private StarTowerSpecialMode fixedRoguelikeSpecialMode;

	private int totalTime;

	private FP timeing = 0;

	private bool isPause;

	private FP delayTimeing;

	private bool isDelayEnd;

	private bool isBossInDying;

	public override bool isComplete
	{
		get
		{
			if (fixedRoguelikeSpecialMode != null)
			{
				return fixedRoguelikeSpecialMode.isComplete;
			}
			return true;
		}
	}

	public override void InitRoom(GameplayRoomData data, Action<HotfixEnum.levelState, int> levelStateCallback)
	{
		base.InitRoom(data, levelStateCallback);
		Debug.Log("特殊事件ID：" + data.eventId);
		if (data.eventId != 0)
		{
			if (!data.isReconnected || (data.isReconnected && !data.isBattleFinish))
			{
				StarTowerSpecificCombat starTowerSpecificCombat = Singleton<HotfixDataController>.Instance.GetStarTowerSpecificCombat(data.eventId);
				StarTowerCombatEvent starTowerCombatEvent = Singleton<HotfixDataController>.Instance.GetStarTowerCombatEvent(starTowerSpecificCombat.EventId);
				Debug.Log("特殊事件Event ID：" + starTowerSpecificCombat.EventId);
				if (starTowerCombatEvent != null)
				{
					switch ((HotfixEnum.specificCombatType)starTowerCombatEvent.Type)
					{
					case HotfixEnum.specificCombatType.Timelimited:
						fixedRoguelikeSpecialMode = new StarTowerSpecialMode_TimeLimit();
						break;
					case HotfixEnum.specificCombatType.RobberGoblin:
						fixedRoguelikeSpecialMode = new StarTowerSpecialMode_Goblin();
						break;
					case HotfixEnum.specificCombatType.EscapeInjury:
						fixedRoguelikeSpecialMode = new StarTowerSpecialMode_HitCount();
						break;
					case HotfixEnum.specificCombatType.ContinuousKilling:
						fixedRoguelikeSpecialMode = new StarTowerSpecialMode_KillStreak();
						break;
					case HotfixEnum.specificCombatType.KillMonster:
						fixedRoguelikeSpecialMode = new StarTowerSpecialMode_KillMonster();
						break;
					case HotfixEnum.specificCombatType.DisturbMonster:
						fixedRoguelikeSpecialMode = new StarTowerSpecialMode_DisturbMonster();
						break;
					}
					fixedRoguelikeSpecialMode?.InitRoom(data, starTowerCombatEvent);
				}
				else
				{
					fixedRoguelikeSpecialMode = new StarTowerSpecialMode();
					fixedRoguelikeSpecialMode.InitRoom(data, null);
				}
			}
		}
		else
		{
			fixedRoguelikeSpecialMode = new StarTowerSpecialMode();
			fixedRoguelikeSpecialMode.InitRoom(data, null);
		}
		HotfixEnum.starTowerRoomType roomType = RoomType;
		if (roomType == HotfixEnum.starTowerRoomType.BossRoom || roomType == HotfixEnum.starTowerRoomType.FinalBossRoom)
		{
			if (!data.isReconnected || (data.isReconnected && !data.isBattleFinish))
			{
				totalTime = 0;
			}
			Singleton<EventDispatchManager>.Instance?.AddEventListener("GM_SET_LEVEL_COUNTTIMR", GMSetLevelCountTime);
		}
	}

	public override void EntryRoom()
	{
		FRRData.ports.ActiveTeleporter(isOpen: false);
		fixedRoguelikeSpecialMode?.EntryRoom(RoomEventComplete);
	}

	public override void UpdateLogic(FP logicDeltaTime)
	{
		base.UpdateLogic(logicDeltaTime);
		if (fixedRoguelikeSpecialMode != null && !fixedRoguelikeSpecialMode.isComplete)
		{
			fixedRoguelikeSpecialMode.UpdateLogic(logicDeltaTime);
		}
		if ((!FRRData.isReconnected || (FRRData.isReconnected && !FRRData.isBattleFinish)) && !isPause && isDelayEnd && !isBossInDying)
		{
			timeing += logicDeltaTime;
			if (timeing >= 1)
			{
				CountUp();
				timeing -= (FP)1;
			}
		}
	}

	public override void Pause()
	{
		fixedRoguelikeSpecialMode?.Pause();
		isPause = true;
	}

	public override void Resume()
	{
		fixedRoguelikeSpecialMode?.Resume();
		isPause = false;
	}

	public override void LeaveRoom()
	{
		HotfixEnum.starTowerRoomType roomType = RoomType;
		if (roomType == HotfixEnum.starTowerRoomType.BossRoom || roomType == HotfixEnum.starTowerRoomType.FinalBossRoom)
		{
			Singleton<EventDispatchManager>.Instance?.RemoveEventListener("GM_SET_LEVEL_COUNTTIMR", GMSetLevelCountTime);
		}
		fixedRoguelikeSpecialMode?.LeaveRoom();
		fixedRoguelikeSpecialMode = null;
	}

	private void RoomEventComplete(HotfixEnum.levelState state)
	{
		isStartTime = false;
		LevelStateCallback?.Invoke(state, (int)(long)levelTime);
	}

	public override void StartTime()
	{
		base.StartTime();
		MonoSingleton<LuaManager>.Instance.FireEvent("CSHARP2LUA_SHOW_UI_TIPS", 1);
		MonoSingleton<LuaManager>.Instance.FireEvent("Roguelike_BossMonster_CountUp", 0);
		isDelayEnd = true;
	}

	private void CountUp()
	{
		totalTime++;
		MonoSingleton<LuaManager>.Instance.FireEvent("Roguelike_BossMonster_CountUp", totalTime);
	}

	private void GMSetLevelCountTime(IEvent ievent)
	{
		if (isStartTime && (!FRRData.isReconnected || (FRRData.isReconnected && !FRRData.isBattleFinish)) && !isPause && isDelayEnd && !isBossInDying && ievent is GeneralEvent generalEvent)
		{
			CommonHelper.TryParseStringParamToInt((generalEvent.data as LuaTable).get_Item((object)1).ToString(), out var intValue);
			totalTime = intValue;
			levelTime = totalTime;
			MonoSingleton<LuaManager>.Instance.FireEvent("Roguelike_BossMonster_CountUp", totalTime);
		}
	}
}
