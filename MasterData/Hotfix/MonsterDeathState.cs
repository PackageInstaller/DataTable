using System;
using UnityEngine;

public class MonsterDeathState : ActorDeathState
{
	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		AdventureMonsterDiedEvent adventureMonsterDiedEvent = AdventureMonsterDiedEvent.Generate();
		adventureMonsterDiedEvent.sender = _actor;
		SceneSingleton<AdventurePlayerController>.Instance.ActionAlert(_actor, add: false);
		AdventureActor actor = _actor;
		if (null != actor)
		{
			adventureMonsterDiedEvent.id = actor.Id;
			adventureMonsterDiedEvent.monsterID = actor.dataID;
			SceneSingleton<ActorGroupManager>.Instance.QueryEntityGroupByID(actor.GroupId)?.RemoveMember(actor);
		}
		MonsterAdventureActor monsterAdventureActor = _actor as MonsterAdventureActor;
		SummonType summonType;
		if (monsterAdventureActor != null)
		{
			MonsterInfo monsterInfo = monsterAdventureActor.monsterInfo;
			if (monsterInfo != null)
			{
				adventureMonsterDiedEvent.epicType = monsterInfo.epicType;
			}
			MonsterSpawnerInfo spawnerInfo = monsterAdventureActor.spawnerInfo;
			if (spawnerInfo != null)
			{
				adventureMonsterDiedEvent.indexOfSpawnWave = spawnerInfo.indexOfSpawnWave;
				adventureMonsterDiedEvent.callSpawnSrc = spawnerInfo.callSpawnSrc;
			}
			if (monsterAdventureActor.IsSummoned(out var summoner, out summonType))
			{
				adventureMonsterDiedEvent.summonId = summoner.Id;
			}
		}
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterDiedEvent);
		MonoSingleton<LuaManager>.Instance.FireEvent(adventureMonsterDiedEvent.type, adventureMonsterDiedEvent.monsterID, (int)adventureMonsterDiedEvent.epicType);
		if (monsterAdventureActor != null && monsterAdventureActor.IsSummoned(out var summoner2, out summonType))
		{
			ModuleController<AdventureModuleController>.Instance?.AddMonsterSummons(monsterAdventureActor, monsterAdventureActor.Id, summoner2.Id, summoner2 is PlayerAdventureActor, iDead: true, iAdd: false);
		}
		if (ModuleController<AdventureModuleController>.Instance.levelInstance != null && ModuleController<AdventureModuleController>.Instance.levelInstance.isMonsterCleared)
		{
			AdventureLevelLastMonsterEnterDiedEvent aEvent = AdventureLevelLastMonsterEnterDiedEvent.Generate();
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(aEvent);
		}
		base.OnEnter(preStatus, onComplete, onLeave);
	}

	protected override void FinishDied()
	{
		base.FinishDied();
		_actor.SendDeclareDeadEvent();
		SceneSingleton<AdventurePlayerController>.Instance.AddEnergy(_actor.actorInfo.supCharge);
		(_actor as MonsterAdventureActor)?.Despawn();
	}
}
