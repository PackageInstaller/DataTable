using System;
using System.Collections.Generic;
using TrueSync;

public class StarTowerRoom_Challenge_Miniboss : StarTowerRoom
{
	private int totalTime;

	private FP timeing = 0;

	private bool isPause;

	private FP delayTimeing;

	private bool isDelayEnd;

	public override void InitRoom(GameplayRoomData data, Action<HotfixEnum.levelState, int> levelStateCallback)
	{
		base.InitRoom(data, levelStateCallback);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_MONSTER_CLEARED", MonsterClear);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_PLAYER_DIED", PlayerDeath);
		totalTime = 0;
	}

	public override void EntryRoom()
	{
		base.EntryRoom();
		FRRData.ports.ActiveTeleporter(isOpen: false);
	}

	public override void UpdateLogic(FP logicDeltaTime)
	{
		base.UpdateLogic(logicDeltaTime);
		if ((!FRRData.isReconnected || (FRRData.isReconnected && !FRRData.isBattleFinish)) && !isPause && isDelayEnd)
		{
			timeing += logicDeltaTime;
			if (timeing >= 1)
			{
				CountUp();
				timeing = 0;
			}
		}
	}

	public override void Pause()
	{
		base.Pause();
		isPause = true;
	}

	public override void Resume()
	{
		base.Resume();
		isPause = false;
	}

	public override void LeaveRoom()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_CLEARED", MonsterClear);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_PLAYER_DIED", PlayerDeath);
	}

	private void MonsterClear(IEvent evt)
	{
		HotfixEnum.starTowerRoomType roomType = RoomType;
		if (roomType != HotfixEnum.starTowerRoomType.BattleRoom && roomType != HotfixEnum.starTowerRoomType.BossRoom && roomType != HotfixEnum.starTowerRoomType.DangerRoom && roomType != HotfixEnum.starTowerRoomType.HorrorRoom && roomType != HotfixEnum.starTowerRoomType.EliteBattleRoom && roomType != HotfixEnum.starTowerRoomType.FinalBossRoom)
		{
			return;
		}
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
		if (num > 0)
		{
			isStartTime = false;
			LevelStateCallback?.Invoke(HotfixEnum.levelState.Success, (int)(long)levelTime);
		}
	}

	private void PlayerDeath(IEvent evt)
	{
		HotfixEnum.starTowerRoomType roomType = RoomType;
		if (roomType == HotfixEnum.starTowerRoomType.BattleRoom || roomType == HotfixEnum.starTowerRoomType.BossRoom || roomType == HotfixEnum.starTowerRoomType.DangerRoom || roomType == HotfixEnum.starTowerRoomType.HorrorRoom || roomType == HotfixEnum.starTowerRoomType.EliteBattleRoom || roomType == HotfixEnum.starTowerRoomType.FinalBossRoom)
		{
			isStartTime = false;
			LevelStateCallback?.Invoke(HotfixEnum.levelState.Failed, (int)(long)levelTime);
		}
	}

	private new void StartTiming(IEvent evt)
	{
		if (!FRRData.isReconnected || (FRRData.isReconnected && !FRRData.isBattleFinish))
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("Roguelike_BossMonster_CountUp", 0);
			isDelayEnd = true;
		}
	}

	public override void StartTime()
	{
		base.StartTime();
		MonoSingleton<LuaManager>.Instance.FireEvent("Roguelike_BossMonster_CountUp", 0);
		isDelayEnd = true;
	}

	private void CountUp()
	{
		totalTime++;
		MonoSingleton<LuaManager>.Instance.FireEvent("Roguelike_BossMonster_CountUp", totalTime);
	}
}
