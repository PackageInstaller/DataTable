using System;
using UnityEngine;

namespace AIScript.Monster.Soldier;

public class SoldierActorDeathState : ActorDeathState
{
	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		if (_actor != null && _actor.dtCollider != null)
		{
			_actor.ignoreDeterministicCollision = true;
		}
		MonoSingleton<LuaManager>.Instance?.FireEntityEvent("Event_SoldierDeath", _actor.Id);
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
		_ = _actor;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterDiedEvent);
		MonoSingleton<LuaManager>.Instance.FireEvent(adventureMonsterDiedEvent.type, adventureMonsterDiedEvent.monsterID, (int)adventureMonsterDiedEvent.epicType);
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
		(_actor as SoldierActor)?.Despawn();
	}
}
