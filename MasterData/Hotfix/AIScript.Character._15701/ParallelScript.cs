using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._15701;

public class ParallelScript : ParallelBase
{
	protected PlayerSkillCd _playerSkillCd;

	public override void OnEnable()
	{
		base.OnEnable();
		_playerSkillCd = _actor.GetLogicComponent<PlayerSkillCd>();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
	}

	private void OnGetBuff(IEvent evt)
	{
		if (evt is AdventureActorGetBuff adventureActorGetBuff)
		{
			if (adventureActorGetBuff.sender is PlayerAdventureActor playerAdventureActor && playerAdventureActor == _actor)
			{
				OnSelfGetBuff(adventureActorGetBuff);
			}
			else if (adventureActorGetBuff.sender is MonsterAdventureActor && adventureActorGetBuff.eventInfo.buffTags.Contains(CommonDefine.Dark) && adventureActorGetBuff.from is PlayerAdventureActor && ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 1))
			{
				_actor.buffComponent.AddBuff(15796111, _actor);
			}
		}
	}

	protected virtual void OnSelfGetBuff(AdventureActorGetBuff getBuffEvent)
	{
	}

	private void OnBeforeHit(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageBeforeHitEvent { to: MonsterAdventureActor to, from: PlayerAdventureActor playerAdventureActor } adventureActorReceiveDamageBeforeHitEvent && playerAdventureActor == _actor)
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 515741, out var _) && to.IsEliteOrBossMonster() && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config.damageTag_Trigger_P41))
			{
				AdventureActor.AddFromAttr(15741001, _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 5) && to.IsEliteOrBossMonster())
			{
				AdventureActor.AddFromAttr(15796511, _actor);
			}
			OnBeforeSelfHit(adventureActorReceiveDamageBeforeHitEvent);
		}
	}

	protected virtual void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
	}

	private void OnReceiveDamage(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageEvent { to: MonsterAdventureActor to, from: PlayerAdventureActor playerAdventureActor } adventureActorReceiveDamageEvent && playerAdventureActor == _actor)
		{
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2) && (adventureActorReceiveDamageEvent.damageType == HotfixEnum.damageType.NORMAL || adventureActorReceiveDamageEvent.damageType == HotfixEnum.damageType.ULTIMATE))
			{
				_actor.buffComponent.AddBuff(15796211, _actor);
			}
			OnSelfDamaged(adventureActorReceiveDamageEvent);
			if (CheckCanTriggerDarkMark(to, adventureActorReceiveDamageEvent.hitDamageTag))
			{
				TriggerDarkMark(to, adventureActorReceiveDamageEvent.hitDamageTag);
			}
		}
	}

	protected virtual void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	private bool CheckCanTriggerDarkMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		if (monster == null || hitDamageTag == null)
		{
			return false;
		}
		if (CommonUtils.CheckElementMark(CommonDefine.Dark, monster) && CommonUtils.CheckTriggerElementMarkCD(_actor, monster) && CommonUtils.CheckHitByTag(hitDamageTag, Config.damageTag_TriggerDarkMark))
		{
			return true;
		}
		return false;
	}

	private void TriggerDarkMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		if (!(monster == null))
		{
			monster.buffComponent?.RemoveBuffByTag(CommonDefine.Dark);
			ILRuntimeAPI.HitActor(_actor, monster, 157000001, "FX/ActorCommon/fx_common_base_DarkTirgger_AnZhuo", null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.None, null, -1);
			monster.buffComponent.AddBuff(15700001, _actor);
			CommonUtils.TriggerElementMarkEvent(CommonDefine.Dark, HotfixEnum.AdventureActorElementTriggerType.DarkElementTriggerType1, _actor, monster, "DarkMark_Trigger_Effect_03");
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 3))
			{
				_actor.buffComponent.AddBuff(15796311, _actor);
			}
			OnTriggerDarkMark(monster, hitDamageTag);
		}
	}

	protected virtual void OnTriggerDarkMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
	}
}
