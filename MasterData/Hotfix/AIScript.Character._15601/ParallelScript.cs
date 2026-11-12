using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15601;

public class ParallelScript : ParallelBase
{
	private bool _canTrigger_D5;

	public override void OnEnable()
	{
		base.OnEnable();
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 5))
		{
			_canTrigger_D5 = true;
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				if (actorL.actorElementInfo.elementType != HotfixEnum.elementType.SE)
				{
					_canTrigger_D5 = false;
					break;
				}
			}
			if (_canTrigger_D5)
			{
				foreach (AdventureActor item in ILRuntimeAPI.SearchAllFriendActors(_actor, includeSelf: true))
				{
					item.buffComponent.AddBuff(15696511, _actor);
				}
			}
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawn);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
	}

	public virtual void OnUpdate()
	{
	}

	private void OnReceiveAttack(IEvent evt)
	{
		AdventureActorReceiveAttackEvent adventureActorReceiveAttackEvent = evt as AdventureActorReceiveAttackEvent;
		if (adventureActorReceiveAttackEvent.from is PlayerAdventureActor playerAdventureActor && playerAdventureActor == _actor && adventureActorReceiveAttackEvent.to is MonsterAdventureActor)
		{
			OnSelfAttacked(adventureActorReceiveAttackEvent);
		}
		else if (adventureActorReceiveAttackEvent.to is PlayerAdventureActor playerAdventureActor2 && playerAdventureActor2 == _actor)
		{
			OnSelfBeAttacked(adventureActorReceiveAttackEvent);
		}
	}

	protected virtual void OnSelfAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
	}

	protected virtual void OnSelfBeAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
	}

	private void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (adventureActorReceiveDamageBeforeHitEvent.from is PlayerAdventureActor playerAdventureActor && adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor monsterAdventureActor)
		{
			if (playerAdventureActor == _actor)
			{
				OnBeforeSelfHit(adventureActorReceiveDamageBeforeHitEvent);
			}
			if (playerAdventureActor == SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor && ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2) && monsterAdventureActor.buffComponent.CheckBuffByBuffID(15696211))
			{
				AdventureActor.AddFromAttr(15696211, _actor);
			}
		}
	}

	protected virtual void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (!(adventureActorReceiveDamageEvent.from is PlayerAdventureActor playerAdventureActor) || !(playerAdventureActor == _actor) || !(adventureActorReceiveDamageEvent.to is MonsterAdventureActor monsterAdventureActor))
		{
			return;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515643, out var _) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config.damageTag_Trigger_P43) && TSRandom.Range(FP.Zero, 100) <= CommonUtils.GetScriptValue(_actor, 15643011))
		{
			monsterAdventureActor.buffComponent.AddBuff(15643011, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config.damageTag_Trigger_D2))
		{
			monsterAdventureActor.buffComponent.AddBuff(15696211, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 4) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config.damageTag_Trigger_D4))
		{
			(SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as PlayerAdventureActor)?.buffComponent.AddBuff(15696411, _actor);
		}
		OnSelfDamaged(adventureActorReceiveDamageEvent);
		if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config.damageTag_AddLandMark))
		{
			BuffEntity buffEntity = monsterAdventureActor.buffComponent.AddBuff(6011, _actor);
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 3) && buffEntity != null)
			{
				monsterAdventureActor.buffComponent.AddBuff(15696311, _actor);
			}
		}
	}

	protected virtual void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		if (!(evt is AdventureElementMarkTriggerEvent { elementType: HotfixEnum.elementType.SE }) || !ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 1))
		{
			return;
		}
		foreach (AdventureActor item in ILRuntimeAPI.SearchAllFriendActors(_actor, includeSelf: true))
		{
			item.buffComponent.AddBuff(15696111, _actor);
		}
	}

	private void OnActorSpawn(IEvent evt)
	{
		if (evt is AdventurActorSpawned { sender: MonsterAdventureActor sender } && sender.IsPlayerMinion(out var _) && ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 5) && _canTrigger_D5)
		{
			sender.buffComponent.AddBuff(15696511, _actor);
		}
	}

	private void OnActorDied(IEvent evt)
	{
		AdventureActorDiedEvent adventureActorDiedEvent = evt as AdventureActorDiedEvent;
		if (adventureActorDiedEvent.actor is MonsterAdventureActor)
		{
			if (adventureActorDiedEvent.killer is PlayerAdventureActor playerAdventureActor && playerAdventureActor == _actor)
			{
				OnKillTarget(adventureActorDiedEvent);
			}
			OnMonsterDied(adventureActorDiedEvent);
		}
	}

	protected virtual void OnKillTarget(AdventureActorDiedEvent diedEvent)
	{
	}

	protected virtual void OnMonsterDied(AdventureActorDiedEvent diedEvent)
	{
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		_canTrigger_D5 = false;
	}
}
