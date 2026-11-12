using System;
using System.Collections.Generic;

public class StarTowerRoom_OwnerlessWealth_Monster : StarTowerRoom
{
	private bool _isComplete;

	public override void InitRoom(GameplayRoomData data, Action<HotfixEnum.levelState, int> levelStateCallback)
	{
		base.InitRoom(data, levelStateCallback);
		_isComplete = true;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_MONSTER_CLEARED", MonsterClear);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_PLAYER_DIED", PlayerDeath);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_SPAWN", MonsterSpawn);
		Singleton<EventDispatchManager>.Instance?.AddEventListener("LUA2CSHARP_OWNERLESSWEALTH_MONSTERHIDE", Lua2CSharp_OwnerlessWealth_MonsterHide);
	}

	public override void EntryRoom()
	{
		base.EntryRoom();
		FRRData.ports.ActiveTeleporter(isOpen: true);
	}

	public override void LeaveRoom()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_CLEARED", MonsterClear);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_PLAYER_DIED", PlayerDeath);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_SPAWN", MonsterSpawn);
		Singleton<EventDispatchManager>.Instance?.RemoveEventListener("LUA2CSHARP_OWNERLESSWEALTH_MONSTERHIDE", Lua2CSharp_OwnerlessWealth_MonsterHide);
	}

	private void MonsterSpawn(IEvent evt)
	{
		if (_isComplete)
		{
			_isComplete = false;
			FRRData.ports.ActiveTeleporter(isOpen: false);
		}
	}

	private void MonsterClear(IEvent evt)
	{
		if (_isComplete)
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
		if (!_isComplete)
		{
			isStartTime = false;
			LevelStateCallback?.Invoke(HotfixEnum.levelState.Failed, (int)(long)levelTime);
		}
	}

	private void Lua2CSharp_OwnerlessWealth_MonsterHide(IEvent ievent)
	{
		if (FRRData.simple != null)
		{
			for (int i = 0; i < FRRData.simple.Count; i++)
			{
				FRRData.simple.get_Item(i).gameObject.SetActive(value: false);
			}
		}
	}
}
