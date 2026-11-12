using System.Collections.Generic;

namespace AIScript.Disc;

public class DiscScriptBase : AIBase
{
	public void OnEnable()
	{
		_actor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnDied);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_CHANGE_LEVEL_STATE", OnLevelStateChange);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("PLAYER_FIRST_ENTER_BATTLE_STATE", OnFirstEnterBattleState);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_PLAYER_ENTER", OnActorEnter);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_PLAYER_LEAVE", OnActorLeave);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessState);
		OnDiscEnable();
	}

	private void OnPrefectDodge(IEvent evt)
	{
		AdventurePerfectDodgeTrigger evt2 = evt as AdventurePerfectDodgeTrigger;
		OnPerfectDodge(evt2);
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		OnCastSkill(adventureActorCastSkillEvent);
		if (adventureActorCastSkillEvent.sender as AdventureActor is PlayerAdventureActor playerAdventureActor)
		{
			OnPlayerActorCastSkill(playerAdventureActor, adventureActorCastSkillEvent);
			if (playerAdventureActor == _actor)
			{
				OnMainPlayerActorCastSkill(playerAdventureActor, adventureActorCastSkillEvent);
			}
		}
	}

	private void OnCastEndSkill(IEvent evt)
	{
		AdventureActorCastSkillEndEvent adventureActorCastSkillEndEvent = evt as AdventureActorCastSkillEndEvent;
		OnCastEndSkill(adventureActorCastSkillEndEvent);
		if (adventureActorCastSkillEndEvent.sender as AdventureActor is PlayerAdventureActor playerAdventureActor)
		{
			OnPlayerActorCastSkillEnd(playerAdventureActor, adventureActorCastSkillEndEvent);
			if (playerAdventureActor == _actor)
			{
				OnMainPlayerActorCastSkillEnd(playerAdventureActor, adventureActorCastSkillEndEvent);
			}
		}
	}

	private void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		OnBeforeHit(adventureActorReceiveDamageBeforeHitEvent);
		if (adventureActorReceiveDamageBeforeHitEvent.from is PlayerAdventureActor playerAdventureActor && adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor target)
		{
			OnBeforePlayerActorHit(playerAdventureActor, target, adventureActorReceiveDamageBeforeHitEvent);
			if (playerAdventureActor == _actor)
			{
				OnBeforeMainPlayerActorHit(playerAdventureActor, target, adventureActorReceiveDamageBeforeHitEvent);
			}
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		OnReceiveDamage(adventureActorReceiveDamageEvent);
		if (adventureActorReceiveDamageEvent.from is PlayerAdventureActor && adventureActorReceiveDamageEvent.to is MonsterAdventureActor target)
		{
			PlayerAdventureActor playerAdventureActor = adventureActorReceiveDamageEvent.from as PlayerAdventureActor;
			OnPlayerActorDamaged(playerAdventureActor, target, adventureActorReceiveDamageEvent);
			if (playerAdventureActor == _actor)
			{
				OnMainPlayerActorDamaged(playerAdventureActor, target, adventureActorReceiveDamageEvent);
			}
		}
		else if (adventureActorReceiveDamageEvent.from is AdventureActor damageSource && adventureActorReceiveDamageEvent.to is PlayerAdventureActor)
		{
			PlayerAdventureActor playerAdventureActor2 = adventureActorReceiveDamageEvent.to as PlayerAdventureActor;
			OnPlayerReceiveDamaged(damageSource, playerAdventureActor2, adventureActorReceiveDamageEvent);
			if (playerAdventureActor2 == _actor)
			{
				OnMainPlayerActorReceiveDamage(damageSource, playerAdventureActor2, adventureActorReceiveDamageEvent);
			}
		}
	}

	private void OnDied(IEvent evt)
	{
		AdventureActorDiedEvent adventureActorDiedEvent = evt as AdventureActorDiedEvent;
		OnDied(adventureActorDiedEvent);
		if (adventureActorDiedEvent.killer is PlayerAdventureActor playerAdventureActor && adventureActorDiedEvent.actor is MonsterAdventureActor target)
		{
			OnPlayerActorKill(playerAdventureActor, target, adventureActorDiedEvent);
			if (playerAdventureActor == _actor)
			{
				OnMainPlayerActorKill(playerAdventureActor, target, adventureActorDiedEvent);
			}
		}
	}

	private void OnLevelStateChange(IEvent evt)
	{
		if ((evt as AdventureChangeLevelStateEvent).levelState == HotfixEnum.levelState.Success)
		{
			OnLevelSuccess();
		}
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		AdventureElementMarkTriggerEvent evt2 = evt as AdventureElementMarkTriggerEvent;
		OnElementMarkTrigger(evt2);
	}

	private void OnActorEnter(IEvent _evt)
	{
		if (_evt is AdventurePlayerEnterEvent evt)
		{
			OnActorEnter(evt);
		}
	}

	private void OnActorLeave(IEvent _evt)
	{
		if (_evt is AdventurePlayerLeaveEvent evt)
		{
			OnActorLeave(evt);
		}
	}

	private void OnActorDied(IEvent _evt)
	{
		if (_evt is AdventureActorDiedEvent evt)
		{
			OnActorDied(evt);
		}
	}

	private void OnToughnessState(IEvent _evt)
	{
		if (_evt is MonsterToughnessStateChangeEvent evt)
		{
			OnToughnessState(evt);
		}
	}

	public void OnDisable()
	{
		OnDiscDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnDied);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_CHANGE_LEVEL_STATE", OnLevelStateChange);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("PLAYER_FIRST_ENTER_BATTLE_STATE", OnFirstEnterBattleState);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_PLAYER_ENTER", OnActorEnter);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_PLAYER_LEAVE", OnActorLeave);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessState);
	}

	protected int GetSkillLevel(int discId, int skillid1, int skillid2 = 0, int skillid3 = 0)
	{
		ModuleController<AdventureModuleController>.Instance.GetDiscSkillLevel(discId, skillid1, out var skillLevel);
		skillLevel = ((skillLevel > 1) ? 1 : skillLevel);
		if (skillLevel > 0)
		{
			return skillLevel;
		}
		if (skillid2 > 0)
		{
			ModuleController<AdventureModuleController>.Instance.GetDiscSkillLevel(discId, skillid2, out skillLevel);
			skillLevel = ((skillLevel > 2) ? 2 : skillLevel);
			_ = 0;
			return skillLevel;
		}
		if (skillid3 > 0)
		{
			ModuleController<AdventureModuleController>.Instance.GetDiscSkillLevel(discId, skillid3, out skillLevel);
		}
		return skillLevel;
	}

	protected bool GetSkillLevel(int discId, int skillId_1, int skillId_2, int skillId_3, out int skillLevel)
	{
		if (!ModuleController<AdventureModuleController>.Instance.GetDiscSkillLevel(discId, skillId_1, out skillLevel) && !ModuleController<AdventureModuleController>.Instance.GetDiscSkillLevel(discId, skillId_2, out skillLevel))
		{
			return ModuleController<AdventureModuleController>.Instance.GetDiscSkillLevel(discId, skillId_3, out skillLevel);
		}
		return true;
	}

	protected (int, int) GetDiscInfo(int discId, List<int> skills)
	{
		int item = 0;
		int item2 = 0;
		for (int i = 0; i < skills.Count; i++)
		{
			if (ModuleController<AdventureModuleController>.Instance.GetDiscSkillLevel(discId, skills.get_Item(i), out var skillLevel))
			{
				item = i;
				item2 = skillLevel;
				break;
			}
		}
		return (item, item2);
	}

	protected int GetDiscSkillv(int discId, List<int> skills)
	{
		int result = 0;
		for (int i = 0; i < skills.Count; i++)
		{
			if (ModuleController<AdventureModuleController>.Instance.GetDiscSkillLevel(discId, skills.get_Item(i), out var skillLevel))
			{
				result = skillLevel;
				break;
			}
		}
		return result;
	}

	protected void AddBuffToGroup(int buffId)
	{
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			actorL.buffComponent?.AddBuff(buffId, actorL);
		}
	}

	protected void AddBuffToMainControl(int buffId)
	{
		_actor?.buffComponent?.AddBuff(buffId, _actor);
	}

	protected void AddBuffToSupport(int buffId)
	{
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (actorL.isAssist)
			{
				actorL.buffComponent?.AddBuff(buffId, actorL);
			}
		}
	}

	protected virtual void OnDiscEnable()
	{
	}

	protected virtual void OnDiscDisable()
	{
	}

	protected virtual void OnPerfectDodge(AdventurePerfectDodgeTrigger evt)
	{
	}

	protected virtual void OnCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
	}

	protected virtual void OnCastEndSkill(AdventureActorCastSkillEndEvent castSkillEvent)
	{
	}

	protected virtual void OnPlayerActorCastSkill(PlayerAdventureActor actor, AdventureActorCastSkillEvent castSkillEvent)
	{
	}

	protected virtual void OnMainPlayerActorCastSkill(PlayerAdventureActor actor, AdventureActorCastSkillEvent castSkillEvent)
	{
	}

	protected virtual void OnPlayerActorCastSkillEnd(PlayerAdventureActor actor, AdventureActorCastSkillEndEvent castSkillEvent)
	{
	}

	protected virtual void OnMainPlayerActorCastSkillEnd(PlayerAdventureActor actor, AdventureActorCastSkillEndEvent castSkillEvent)
	{
	}

	private void OnReceiveAttack(IEvent evt)
	{
		AdventureActorReceiveAttackEvent adventureActorReceiveAttackEvent = evt as AdventureActorReceiveAttackEvent;
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveAttackEvent.to as MonsterAdventureActor;
		if (monsterAdventureActor != null)
		{
			OnReceiveAttack(adventureActorReceiveAttackEvent, monsterAdventureActor);
		}
	}

	protected virtual void OnReceiveAttack(AdventureActorReceiveAttackEvent damageEvt, MonsterAdventureActor monster)
	{
	}

	protected virtual void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
	}

	protected virtual void OnBeforePlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
	}

	protected virtual void OnBeforeMainPlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
	}

	protected virtual void OnReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	protected virtual void OnPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	protected virtual void OnPlayerReceiveDamaged(AdventureActor damageSource, PlayerAdventureActor actor, AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	protected virtual void OnMainPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	protected virtual void OnMainPlayerActorReceiveDamage(AdventureActor damageSource, PlayerAdventureActor actor, AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	protected virtual void OnDied(AdventureActorDiedEvent diedEvent)
	{
	}

	protected virtual void OnPlayerActorKill(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorDiedEvent diedEvent)
	{
	}

	protected virtual void OnMainPlayerActorKill(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorDiedEvent diedEvent)
	{
	}

	protected virtual void OnLevelSuccess()
	{
	}

	protected virtual void OnElementMarkTrigger(AdventureElementMarkTriggerEvent _evt)
	{
	}

	protected virtual void OnFirstEnterBattleState(IEvent evt)
	{
	}

	protected virtual void OnActorEnter(AdventurePlayerEnterEvent evt)
	{
	}

	protected virtual void OnActorLeave(AdventurePlayerLeaveEvent evt)
	{
	}

	protected virtual void OnActorDied(AdventureActorDiedEvent evt)
	{
	}

	protected virtual void OnToughnessState(MonsterToughnessStateChangeEvent evt)
	{
	}
}
