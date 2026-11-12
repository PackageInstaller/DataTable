using System;
using System.Collections.Generic;
using TrueSync;

public class StarTowerRoom_Challenge_Survive : StarTowerRoom
{
	private int totalTime;

	private FP timeing = 0;

	private bool isPause;

	public override void InitRoom(GameplayRoomData data, Action<HotfixEnum.levelState, int> levelStateCallback)
	{
		base.InitRoom(data, levelStateCallback);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_PLAYER_DIED", PlayerDeath);
	}

	public override void EntryRoom()
	{
		base.EntryRoom();
		FRRData.ports.ActiveTeleporter(isOpen: false);
		if (!FRRData.isReconnected || (FRRData.isReconnected && !FRRData.isBattleFinish))
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("Roguelike_SurviveRoom_CountDown", totalTime);
		}
	}

	public override void UpdateLogic(FP logicDeltaTime)
	{
		base.UpdateLogic(logicDeltaTime);
		if ((!FRRData.isReconnected || (FRRData.isReconnected && !FRRData.isBattleFinish)) && !isPause && totalTime > 0)
		{
			timeing += logicDeltaTime;
			if (timeing >= 1)
			{
				CountDown();
				timeing = 0;
			}
		}
	}

	public override void Pause()
	{
		isPause = true;
	}

	public override void Resume()
	{
		isPause = false;
	}

	public override void LeaveRoom()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_PLAYER_DIED", PlayerDeath);
	}

	private void CountDown()
	{
		totalTime--;
		if (totalTime <= 0)
		{
			List<LogicEntity> playerActors = ModuleController<AdventureModuleController>.Instance.playerActors;
			int num = 0;
			for (int i = 0; i < playerActors.Count; i++)
			{
				PlayerAdventureActor playerAdventureActor = playerActors.get_Item(i) as PlayerAdventureActor;
				if (null != playerAdventureActor && !playerAdventureActor.isDead)
				{
					num++;
				}
			}
			if (num != 0)
			{
				ClearAllMonster();
				isStartTime = false;
				LevelStateCallback?.Invoke(HotfixEnum.levelState.Success, (int)(long)levelTime);
			}
		}
		MonoSingleton<LuaManager>.Instance.FireEvent("Roguelike_SurviveRoom_CountDown", totalTime);
	}

	private void PlayerDeath(IEvent evt)
	{
		HotfixEnum.starTowerRoomType roomType = RoomType;
		if ((roomType == HotfixEnum.starTowerRoomType.BattleRoom || roomType == HotfixEnum.starTowerRoomType.BossRoom || roomType == HotfixEnum.starTowerRoomType.DangerRoom || roomType == HotfixEnum.starTowerRoomType.HorrorRoom || roomType == HotfixEnum.starTowerRoomType.EliteBattleRoom || roomType == HotfixEnum.starTowerRoomType.FinalBossRoom) && LevelStateCallback != null)
		{
			isStartTime = false;
			LevelStateCallback(HotfixEnum.levelState.Failed, (int)(long)levelTime);
			isPause = true;
		}
	}

	private void ClearAllMonster()
	{
		AdventureLevelController levelInstance = ModuleController<AdventureModuleController>.Instance.levelInstance;
		if (null != levelInstance)
		{
			(levelInstance as StarTowerLevelController).DeActiveVirtualMonsterSpawnWaves();
		}
		List<LogicEntity> monsterActors = ModuleController<AdventureModuleController>.Instance.monsterActors;
		if (monsterActors == null)
		{
			return;
		}
		for (int i = 0; i < monsterActors.Count; i++)
		{
			MonsterAdventureActor monsterAdventureActor = monsterActors.get_Item(i) as MonsterAdventureActor;
			if (!monsterAdventureActor.isDead && monsterAdventureActor.monsterInfo.subType != HotfixEnum.monsterSubType.Trap)
			{
				monsterAdventureActor.DestroySelf();
			}
		}
	}
}
