using AIScript.Utils;

namespace AIScript.Character._16101;

public class ParallelScript : ParallelBase
{
	private const int perkId_41 = 516141;

	private int buff_41 = 16141011;

	private const int perkId_42 = 516142;

	private int once_42 = 16142001;

	private const int perkId_43 = 516143;

	private int buff_43 = 16143011;

	private static readonly int areaTag_Ultra_P43 = CommonHelper.StringToHash("16101_Ultra_P43");

	protected PlayerSkillCd skillMgr;

	protected PlayerAdventureActor mainCtrActor;

	public override void OnEnable()
	{
		base.OnEnable();
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		mainCtrActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkillRaw);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkillRaw);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttackRaw);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamageRaw);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHitRaw);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodgeRaw);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTriggerRaw);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuffRaw);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnBuffRemoveRaw);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEnterExitRaw);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("DROP_EFFECT_FINISH", OnDropFinishRaw);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReadyRaw);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEventRaw);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkillRaw);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkillRaw);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttackRaw);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamageRaw);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHitRaw);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodgeRaw);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTriggerRaw);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuffRaw);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnBuffRemoveRaw);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEnterExitRaw);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("DROP_EFFECT_FINISH", OnDropFinishRaw);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReadyRaw);
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEventRaw);
	}

	private void OnCastSkillRaw(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		if (_actor != null && adventureActorCastSkillEvent != null && adventureActorCastSkillEvent.sender as AdventureActor == _actor)
		{
			OnCastSkill(adventureActorCastSkillEvent);
		}
	}

	private void OnCastEndSkillRaw(IEvent evt)
	{
		AdventureActorCastSkillEndEvent adventureActorCastSkillEndEvent = evt as AdventureActorCastSkillEndEvent;
		if (_actor != null && adventureActorCastSkillEndEvent != null && adventureActorCastSkillEndEvent.sender as AdventureActor == _actor)
		{
			OnCastEndSkill(adventureActorCastSkillEndEvent);
		}
	}

	private void OnReceiveAttackRaw(IEvent evt)
	{
		AdventureActorReceiveAttackEvent adventureActorReceiveAttackEvent = evt as AdventureActorReceiveAttackEvent;
		if (_actor != null && adventureActorReceiveAttackEvent != null && adventureActorReceiveAttackEvent.from != null && adventureActorReceiveAttackEvent.from.Id == _actor.Id && adventureActorReceiveAttackEvent.to is MonsterAdventureActor monster)
		{
			OnHitPre(adventureActorReceiveAttackEvent, monster);
		}
	}

	private void OnReceiveDamageRaw(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (!(_actor == null) && adventureActorReceiveDamageEvent != null)
		{
			if (adventureActorReceiveDamageEvent.from != null && adventureActorReceiveDamageEvent.from.Id == _actor.Id && adventureActorReceiveDamageEvent.to is MonsterAdventureActor monster)
			{
				OnHitPost(adventureActorReceiveDamageEvent, monster);
			}
			else if (adventureActorReceiveDamageEvent.to != null && adventureActorReceiveDamageEvent.to.Id == _actor.Id)
			{
				OnHurt(adventureActorReceiveDamageEvent);
			}
		}
	}

	private void OnReceiveBeforeHitRaw(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (_actor != null && adventureActorReceiveDamageBeforeHitEvent != null && adventureActorReceiveDamageBeforeHitEvent.from != null && adventureActorReceiveDamageBeforeHitEvent.from.Id == _actor.Id && adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor monster)
		{
			OnBeforeHit(adventureActorReceiveDamageBeforeHitEvent, monster);
		}
	}

	private void OnPrefectDodgeRaw(IEvent evt)
	{
		AdventurePerfectDodgeTrigger adventurePerfectDodgeTrigger = evt as AdventurePerfectDodgeTrigger;
		if (_actor != null && adventurePerfectDodgeTrigger != null && adventurePerfectDodgeTrigger.actor == _actor)
		{
			OnPerfectDodge(adventurePerfectDodgeTrigger);
		}
	}

	private void OnElementMarkTriggerRaw(IEvent evt)
	{
		AdventureElementMarkTriggerEvent adventureElementMarkTriggerEvent = evt as AdventureElementMarkTriggerEvent;
		if (_actor != null && adventureElementMarkTriggerEvent != null)
		{
			OnElementMarkTrigger(adventureElementMarkTriggerEvent);
		}
	}

	private void OnGetBuffRaw(IEvent evt)
	{
		AdventureActorGetBuff adventureActorGetBuff = evt as AdventureActorGetBuff;
		if (_actor != null && adventureActorGetBuff != null)
		{
			OnGetBuff(adventureActorGetBuff);
		}
	}

	private void OnBuffRemoveRaw(IEvent evt)
	{
		AdventureActorRemoveBuff adventureActorRemoveBuff = evt as AdventureActorRemoveBuff;
		if (_actor != null && adventureActorRemoveBuff != null)
		{
			OnBuffRemove(adventureActorRemoveBuff);
		}
	}

	private void OnAreaEnterExitRaw(IEvent evt)
	{
		AdventureAreaEnterExitEvent adventureAreaEnterExitEvent = evt as AdventureAreaEnterExitEvent;
		if (_actor != null && adventureAreaEnterExitEvent != null)
		{
			OnAreaEnterExit(adventureAreaEnterExitEvent);
		}
	}

	private void OnDropFinishRaw(IEvent evt)
	{
		AdventureDropFinishEvent adventureDropFinishEvent = evt as AdventureDropFinishEvent;
		if (_actor != null && adventureDropFinishEvent != null)
		{
			OnDropFinish(adventureDropFinishEvent);
		}
	}

	private void OnCustomEventRaw(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent evt2)
		{
			OnCustomEvent(evt2);
		}
	}

	private void OnBattleReadyRaw(IEvent evt)
	{
		AdventureBattleReadyEvent adventureBattleReadyEvent = evt as AdventureBattleReadyEvent;
		if (_actor != null && adventureBattleReadyEvent != null)
		{
			OnBattleReady(adventureBattleReadyEvent);
		}
	}

	public virtual void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
	}

	public virtual void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
	}

	public virtual void OnHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster)
	{
	}

	public virtual void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		if (GetPerk(516142) && CommonUtils.CheckHitByTag(evt.hitDamageTag, Config.hitTag_Ultra))
		{
			AdventureActor.AddFromAttr(once_42, _actor);
		}
	}

	public virtual void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster)
	{
		if (GetPerk(516141) && CommonUtils.CheckHitByTag(evt.hitDamageTag, Config.hitTag_Ultra))
		{
			_actor.buffComponent.AddBuff(buff_41, _actor);
		}
	}

	public virtual void OnHurt(AdventureActorReceiveDamageEvent evt)
	{
	}

	public virtual void OnPerfectDodge(AdventurePerfectDodgeTrigger evt)
	{
	}

	public virtual void OnElementMarkTrigger(AdventureElementMarkTriggerEvent evt)
	{
	}

	public virtual void OnGetBuff(AdventureActorGetBuff evt)
	{
	}

	public virtual void OnBuffRemove(AdventureActorRemoveBuff evt)
	{
	}

	public virtual void OnAreaEnterExit(AdventureAreaEnterExitEvent evt)
	{
		if (!GetPerk(516143) || !(evt.sender is AreaEffectEntity areaEffectEntity) || !areaEffectEntity.CheckTag(areaTag_Ultra_P43) || !(evt.triggerCollider != null) || !(evt.triggerCollider.Entity is PlayerAdventureActor { isAssist: false }))
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor2 = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor2 != null && playerAdventureActor2.actorElementInfo.elementType == HotfixEnum.elementType.SE && (playerAdventureActor2.actorInfo.jobClass == HotfixEnum.characterJobClass.Vanguard || playerAdventureActor2.actorInfo.jobClass == HotfixEnum.characterJobClass.Balance))
			{
				if (evt.iEnter)
				{
					playerAdventureActor2.buffComponent.AddBuff(buff_43, _actor);
				}
				else
				{
					playerAdventureActor2.buffComponent.RemoveBuffByBuffId(buff_43);
				}
			}
		}
	}

	public virtual void OnDropFinish(AdventureDropFinishEvent evt)
	{
	}

	public virtual void OnCustomEvent(AdventureActorCustomEvent evt)
	{
	}

	public virtual void OnBattleReady(AdventureBattleReadyEvent evt)
	{
	}
}
