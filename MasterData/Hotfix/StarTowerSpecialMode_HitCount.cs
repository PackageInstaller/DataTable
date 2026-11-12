using System;
using Nova.Hotfix;
using UnityEngine;

public class StarTowerSpecialMode_HitCount : StarTowerSpecialMode
{
	private int maxHitCount;

	private int hitCount;

	public override void InitRoom(GameplayRoomData roomData, StarTowerCombatEvent eventData)
	{
		base.InitRoom(roomData, eventData);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", HitDamage);
		if (roomType == HotfixEnum.starTowerRoomType.BattleRoom)
		{
			maxHitCount = CommonHelper.ParseStringParamToInt(Singleton<GameDataController>.Instance.GetConfig("HitCountLimit").Value);
		}
		else
		{
			maxHitCount = CommonHelper.ParseStringParamToInt(Singleton<GameDataController>.Instance.GetConfig("HitCountLimitElite").Value);
		}
	}

	public override void EntryRoom(Action<HotfixEnum.levelState> callback)
	{
		base.EntryRoom(callback);
		if (roomData == null)
		{
			Debug.LogError("房间数据为空!");
			return;
		}
		if (!roomData.isReconnected || (roomData.isReconnected && !roomData.isBattleFinish))
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("Roguelike_SpecialMode_HitCount", maxHitCount - hitCount);
		}
		isComplete = true;
	}

	public override void LeaveRoom()
	{
		hitCount = 0;
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", HitDamage);
	}

	private void HitDamage(IEvent evt)
	{
		if (maxHitCount < hitCount)
		{
			return;
		}
		long id = (evt as AdventureActorReceiveDamageEvent).to.Id;
		if (ModuleController<AdventureModuleController>.Instance.QueryPlayerEntityByID(id) != null)
		{
			hitCount++;
			if (hitCount >= maxHitCount)
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("Roguelike_SpecialMode_Fail");
			}
			MonoSingleton<LuaManager>.Instance.FireEvent("Roguelike_SpecialMode_HitCount", maxHitCount - hitCount);
		}
	}
}
