using System;
using System.Collections.Generic;
using Nova.Hotfix;
using TrueSync;

public class StarTowerSpecialMode
{
	protected GameplayRoomData roomData;

	protected StarTowerCombatEvent eventData;

	protected Action<HotfixEnum.levelState> completeCallback;

	protected bool isActived;

	protected HotfixEnum.combatActivePointType activeTime = HotfixEnum.combatActivePointType.LevelStart;

	protected HotfixEnum.combatActiveType activeType = HotfixEnum.combatActiveType.Automatic;

	protected bool finalWaveActived;

	protected bool finalWaveCleared;

	public bool isComplete { get; protected set; } = true;

	protected int totalAlivePlayerActorCount
	{
		get
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
			return num;
		}
	}

	protected HotfixEnum.starTowerRoomType roomType
	{
		get
		{
			if (roomData != null)
			{
				return (HotfixEnum.starTowerRoomType)(roomData.starTowerStage?.RoomType).Value;
			}
			return HotfixEnum.starTowerRoomType.BattleRoom;
		}
	}

	public virtual void InitRoom(GameplayRoomData roomData, StarTowerCombatEvent eventData)
	{
		this.roomData = roomData;
		this.eventData = eventData;
		if (eventData != null)
		{
			activeTime = (HotfixEnum.combatActivePointType)eventData.Active;
			activeType = (HotfixEnum.combatActiveType)eventData.Start;
		}
	}

	public virtual void LeaveRoom()
	{
		roomData = null;
		eventData = null;
		completeCallback = null;
		isComplete = false;
		isActived = false;
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_CLEARED", MonsterClear);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_PLAYER_DIED", PlayerDeath);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("FIXED_RANDOM_WAVE_ACTIVED", EveryWaveActived);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("FIXED_RANDOM_WAVE_CLEARED", EveryWaveCleared);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", ActorDied);
	}

	public virtual void EntryRoom(Action<HotfixEnum.levelState> callback)
	{
		isComplete = false;
		isActived = false;
		completeCallback = callback;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_MONSTER_CLEARED", MonsterClear);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_PLAYER_DIED", PlayerDeath);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("FIXED_RANDOM_WAVE_ACTIVED", EveryWaveActived);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("FIXED_RANDOM_WAVE_CLEARED", EveryWaveCleared);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_DIED", ActorDied);
		if (eventData == null)
		{
			isActived = true;
			isComplete = true;
		}
		else if (activeTime == HotfixEnum.combatActivePointType.LevelStart && activeType == HotfixEnum.combatActiveType.Automatic)
		{
			ActiveEvent();
		}
	}

	public virtual void ActiveEvent()
	{
		isActived = true;
		isComplete = false;
	}

	public virtual void Complete(HotfixEnum.levelState state)
	{
		isComplete = true;
		isActived = false;
		completeCallback?.Invoke(state);
		completeCallback = null;
	}

	public virtual void UpdateLogic(FP logicDeltaTime)
	{
	}

	public virtual void Pause()
	{
	}

	public virtual void Resume()
	{
	}

	protected void EveryWaveActived(IEvent evt)
	{
		if (activeTime == HotfixEnum.combatActivePointType.EveryWaveRefresh && activeType == HotfixEnum.combatActiveType.Automatic)
		{
			ActiveEvent();
		}
		if (evt == null)
		{
			return;
		}
		AdventureFixedRandomWaveActived adventureFixedRandomWaveActived = (AdventureFixedRandomWaveActived)evt;
		if (adventureFixedRandomWaveActived.isFinalWave)
		{
			finalWaveActived = true;
			if (activeTime == HotfixEnum.combatActivePointType.FinalWaveRefresh && activeType == HotfixEnum.combatActiveType.Automatic)
			{
				ActiveEvent();
			}
		}
		if (adventureFixedRandomWaveActived.isFirstWave && activeTime == HotfixEnum.combatActivePointType.FirstWaveRefresh && activeType == HotfixEnum.combatActiveType.Automatic)
		{
			ActiveEvent();
		}
	}

	protected void EveryWaveCleared(IEvent evt)
	{
		if (activeTime == HotfixEnum.combatActivePointType.EveryWaveClear && activeType == HotfixEnum.combatActiveType.Automatic)
		{
			ActiveEvent();
		}
		if (evt == null)
		{
			return;
		}
		AdventureFixedRandomWaveCleared adventureFixedRandomWaveCleared = (AdventureFixedRandomWaveCleared)evt;
		if (adventureFixedRandomWaveCleared.isFinalWave)
		{
			FinalWaveCleared();
			if (activeTime == HotfixEnum.combatActivePointType.FinalWaveClear && activeType == HotfixEnum.combatActiveType.Automatic)
			{
				ActiveEvent();
			}
		}
		if (adventureFixedRandomWaveCleared.isFirstWave && activeTime == HotfixEnum.combatActivePointType.FirstWaveClear && activeType == HotfixEnum.combatActiveType.Automatic)
		{
			ActiveEvent();
		}
	}

	protected virtual void FinalWaveCleared()
	{
		finalWaveCleared = true;
	}

	protected void PlayerDeath(IEvent evt)
	{
		HotfixEnum.starTowerRoomType starTowerRoomType = roomType;
		if (starTowerRoomType == HotfixEnum.starTowerRoomType.BattleRoom || starTowerRoomType == HotfixEnum.starTowerRoomType.BossRoom || starTowerRoomType == HotfixEnum.starTowerRoomType.DangerRoom || starTowerRoomType == HotfixEnum.starTowerRoomType.HorrorRoom || starTowerRoomType == HotfixEnum.starTowerRoomType.EliteBattleRoom || starTowerRoomType == HotfixEnum.starTowerRoomType.FinalBossRoom)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("Level_Settlement");
		}
	}

	private void ActorDied(IEvent evt)
	{
		if ((evt as AdventureActorDiedEvent).actor.Id == SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.Id)
		{
			HotfixEnum.starTowerRoomType starTowerRoomType = roomType;
			if (starTowerRoomType == HotfixEnum.starTowerRoomType.BattleRoom || starTowerRoomType == HotfixEnum.starTowerRoomType.BossRoom || starTowerRoomType == HotfixEnum.starTowerRoomType.DangerRoom || starTowerRoomType == HotfixEnum.starTowerRoomType.HorrorRoom || starTowerRoomType == HotfixEnum.starTowerRoomType.EliteBattleRoom || starTowerRoomType == HotfixEnum.starTowerRoomType.FinalBossRoom)
			{
				Complete(HotfixEnum.levelState.Failed);
			}
		}
	}

	protected virtual void MonsterClear(IEvent evt)
	{
		HotfixEnum.starTowerRoomType starTowerRoomType = roomType;
		if ((starTowerRoomType == HotfixEnum.starTowerRoomType.BattleRoom || starTowerRoomType == HotfixEnum.starTowerRoomType.BossRoom || starTowerRoomType == HotfixEnum.starTowerRoomType.DangerRoom || starTowerRoomType == HotfixEnum.starTowerRoomType.HorrorRoom || starTowerRoomType == HotfixEnum.starTowerRoomType.EliteBattleRoom || starTowerRoomType == HotfixEnum.starTowerRoomType.FinalBossRoom) && totalAlivePlayerActorCount > 0)
		{
			Complete(HotfixEnum.levelState.Success);
		}
	}
}
