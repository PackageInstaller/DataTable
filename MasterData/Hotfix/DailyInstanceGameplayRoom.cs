using System;
using System.Collections.Generic;
using Nova.Hotfix;
using TrueSync;

public class DailyInstanceGameplayRoom : GameplayRoom
{
	protected const string ZoomFreezeKey = "ZoomFreeze";

	protected const string ZoomDurationTimeKey = "ZoomInDurationTime";

	public FP levelTime;

	public bool isStartTime;

	public Action<HotfixEnum.levelState, int> LevelStateCallback;

	private DailyInstanceFloor floorData;

	private readonly List<int> starCondition = new List<int>();

	public int monsterId;

	private int killMonsterCount;

	private int levelTotalTime;

	private FP timeing = 0;

	private bool isTimeEndSettlement;

	private int starConditionType;

	private bool typeHpSendUidToLua;

	private float _zoomFreeze;

	private float _zoomDurationTime;

	private bool isAlreadySettled;

	public override void InitRoom(GameplayRoomData data, Action<HotfixEnum.levelState, int> levelStateCallback)
	{
		LevelStateCallback = levelStateCallback;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("LEVEL_START_TIMING", StartTiming);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_PLAYER_DIED", OnPlayerDied);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_SPAWN", MonsterSpawn);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDeath);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_MONSTER_DECLARE_DIED", MonsterDeclareDeath);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_MONSTER_CLEARED", MonsterClear);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_LEVEL_ON_TELEPORTER_TRIGGERED", TaskSettlement);
		floorData = Singleton<HotfixDataController>.Instance.GetDailyInstanceFloor(data.floorId);
		if (floorData != null)
		{
			initFloorMsg();
		}
	}

	public override void UpdateLogic(FP logicDeltaTime)
	{
		if (!isStartTime)
		{
			return;
		}
		levelTime += logicDeltaTime;
		timeing += logicDeltaTime;
		if (timeing >= 1)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("Daily_Instance_Gameplay_Time", (int)(long)levelTime);
			if (levelTotalTime != -1)
			{
				CountDown();
			}
			timeing -= (FP)1;
		}
	}

	public override void Pause()
	{
	}

	public override void Resume()
	{
	}

	public override void LeaveRoom()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("LEVEL_START_TIMING", StartTiming);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_PLAYER_DIED", OnPlayerDied);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_SPAWN", MonsterSpawn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDeath);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DECLARE_DIED", MonsterDeclareDeath);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_CLEARED", MonsterClear);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_LEVEL_ON_TELEPORTER_TRIGGERED", TaskSettlement);
	}

	private void initFloorMsg()
	{
		starConditionType = floorData.StarConditionType;
		starCondition.Add(floorData.OneStarCondition);
		starCondition.Add(floorData.TwoStarCondition);
		starCondition.Add(floorData.ThreeStarCondition);
		monsterId = floorData.MonsterId;
		levelTotalTime = floorData.LevelTotalTime;
		isTimeEndSettlement = floorData.TimeEndSettlement;
	}

	public void levelEnd(bool isSettlement = true)
	{
		if (isAlreadySettled)
		{
			return;
		}
		isAlreadySettled = true;
		bool flag = false;
		if (isSettlement)
		{
			List<bool> list = judgeStar();
			for (int i = 0; i < list.Count; i++)
			{
				if (list.get_Item(i))
				{
					flag = true;
					break;
				}
			}
			isStartTime = false;
			LevelStateCallback(HotfixEnum.levelState.Success, 0);
			levelEndSendMsg(list);
		}
		else
		{
			LevelStateCallback(HotfixEnum.levelState.Failed, 0);
			List<bool> starBool = new List<bool> { false, false, false };
			levelEndSendMsg(starBool);
		}
		if (!flag)
		{
			return;
		}
		List<LogicEntity> monsterActors = ModuleController<AdventureModuleController>.Instance.monsterActors;
		if (monsterActors == null)
		{
			return;
		}
		for (int j = 0; j < monsterActors.Count; j++)
		{
			MonsterAdventureActor monsterAdventureActor = monsterActors.get_Item(j) as MonsterAdventureActor;
			if (monsterAdventureActor != null && !monsterAdventureActor.isDead && monsterAdventureActor.monsterInfo.subType != HotfixEnum.monsterSubType.Trap)
			{
				monsterAdventureActor.DestroySelf();
			}
		}
	}

	private void levelEndSendMsg(List<bool> starBool)
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("DailyInstanceGameEnd", starBool);
		CommonHelper.TryParseStringParamToFloat(Singleton<GameDataController>.Instance.GetConfig("ZoomFreeze").Value, out _zoomFreeze);
		CommonHelper.TryParseStringParamToFloat(Singleton<GameDataController>.Instance.GetConfig("ZoomInDurationTime").Value, out _zoomDurationTime);
		ModuleController<AdventureModuleController>.Instance.FreezeFrame(_zoomFreeze, _zoomDurationTime, Action);
		static void Action()
		{
		}
	}

	private List<bool> judgeStar()
	{
		List<bool> list = new List<bool> { false, false, false };
		int num = 0;
		List<LogicEntity> monsterActors = ModuleController<AdventureModuleController>.Instance.monsterActors;
		for (int i = 0; i < monsterActors.Count; i++)
		{
			MonsterAdventureActor monsterAdventureActor = monsterActors.get_Item(i) as MonsterAdventureActor;
			if (monsterAdventureActor != null && !monsterAdventureActor.isDead && monsterAdventureActor.monsterInfo.subType != HotfixEnum.monsterSubType.Trap && monsterAdventureActor.dataID == monsterId)
			{
				num = (int)(long)(monsterAdventureActor.actorHealthInfo.hpPercentage * 100);
				break;
			}
		}
		for (int j = 0; j < starCondition.Count; j++)
		{
			int num2 = starCondition.get_Item(j);
			switch (starConditionType)
			{
			case 1:
				if (num <= num2)
				{
					list.set_Item(j, true);
				}
				break;
			case 2:
				if (killMonsterCount >= num2)
				{
					list.set_Item(j, true);
				}
				break;
			case 3:
				if (num2 != -1)
				{
					if (levelTime <= num2)
					{
						list.set_Item(j, true);
					}
				}
				else
				{
					list.set_Item(j, true);
				}
				break;
			}
		}
		return list;
	}

	private void MonsterSpawn(IEvent evt)
	{
		AdventureMonsterSpawnedEvent adventureMonsterSpawnedEvent = (AdventureMonsterSpawnedEvent)evt;
		if (adventureMonsterSpawnedEvent.dataID == monsterId && starConditionType == 1 && !typeHpSendUidToLua)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("Daily_Instance_Gameplay_TypeOne_UniqueID", adventureMonsterSpawnedEvent.id);
			typeHpSendUidToLua = true;
		}
	}

	public void MonsterDeath(IEvent evt)
	{
		if (((AdventureMonsterDiedEvent)evt).monsterID == monsterId && starConditionType == 2 && !isAlreadySettled)
		{
			killMonsterCount++;
			MonoSingleton<LuaManager>.Instance.FireEvent("Daily_Instance_Gameplay_TypeTwo_KillCount", killMonsterCount);
		}
	}

	public void MonsterDeclareDeath(IEvent evt)
	{
		if (((AdventureMonsterDeclareDiedEvent)evt).monsterID == monsterId && starConditionType == 1)
		{
			levelEnd();
		}
	}

	private void StartTiming(IEvent evt)
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("Daily_Instance_Gameplay_Time", 0);
		isStartTime = true;
	}

	private void OnPlayerDied(IEvent ievent)
	{
		isStartTime = false;
		levelEnd(isSettlement: false);
	}

	private void MonsterClear(IEvent evt)
	{
		levelEnd();
	}

	private void CountDown()
	{
		levelTotalTime--;
		if (levelTotalTime <= 0)
		{
			isStartTime = false;
			levelEnd(isTimeEndSettlement);
		}
	}

	protected void TaskSettlement(IEvent evt)
	{
		object data = ((GeneralEvent)evt).data;
		if (data != null)
		{
			AdventureLevelTeleporter.NextLevelData nextLevelData = (AdventureLevelTeleporter.NextLevelData)data;
			isStartTime = false;
			levelEnd(nextLevelData.levelSuccess);
		}
	}
}
