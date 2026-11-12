using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14301;

public class ParallelScript : ParallelBase
{
	protected List<int> _damageTag_TriggerWindMark;

	public override void OnEnable()
	{
		base.OnEnable();
		if (_damageTag_TriggerWindMark == null)
		{
			_damageTag_TriggerWindMark = new List<int>();
		}
		else
		{
			_damageTag_TriggerWindMark.Clear();
		}
		_damageTag_TriggerWindMark.Add(Config.damageTag_TriggerWindMark);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
	}

	private void OnGetBuff(IEvent evt)
	{
		AdventureActorGetBuff adventureActorGetBuff = evt as AdventureActorGetBuff;
		if (adventureActorGetBuff.sender is MonsterAdventureActor && adventureActorGetBuff.eventInfo.buffTags.Contains(CommonDefine.Wind))
		{
			bool flag = false;
			if (adventureActorGetBuff.from != null && (adventureActorGetBuff.from is PlayerAdventureActor || adventureActorGetBuff.from.IsPlayerSummoned(out var _, out var _)))
			{
				flag = true;
			}
			if (flag && CheckTalentLevel(3))
			{
				_actor.buffComponent.AddBuff(14396311, _actor);
			}
		}
	}

	private void OnReceiveAttack(IEvent evt)
	{
		if (evt is AdventureActorReceiveAttackEvent { from: PlayerAdventureActor playerAdventureActor } adventureActorReceiveAttackEvent && playerAdventureActor == _actor && adventureActorReceiveAttackEvent.to is MonsterAdventureActor)
		{
			OnSelfAttack(adventureActorReceiveAttackEvent);
		}
	}

	protected virtual void OnSelfAttack(AdventureActorReceiveAttackEvent attackEvent)
	{
	}

	private void OnBeforeHit(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageBeforeHitEvent { from: PlayerAdventureActor playerAdventureActor } adventureActorReceiveDamageBeforeHitEvent && playerAdventureActor == _actor && adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor monsterAdventureActor)
		{
			OnBeforeSelfHit(adventureActorReceiveDamageBeforeHitEvent);
			if (CheckTalentLevel(5) && adventureActorReceiveDamageBeforeHitEvent.elementType == HotfixEnum.elementType.AE && (monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE || monsterAdventureActor.IsBossMonster()))
			{
				AdventureActor.AddFromAttr(14396511, _actor);
			}
		}
	}

	protected virtual void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (adventureActorReceiveDamageEvent.from is PlayerAdventureActor playerAdventureActor && playerAdventureActor == _actor && adventureActorReceiveDamageEvent.to is MonsterAdventureActor monster)
		{
			OnSelfDamaged(adventureActorReceiveDamageEvent);
			if (CheckCanTriggerWindMark(monster, adventureActorReceiveDamageEvent.hitDamageTag))
			{
				TriggerWindMark(monster, adventureActorReceiveDamageEvent.hitDamageTag);
			}
		}
	}

	protected virtual void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		if (CheckTalentLevel(2) && damageEvent.damageType == HotfixEnum.damageType.SKILL)
		{
			_actor.buffComponent.AddBuff(14396211, _actor);
		}
		if (CheckTalentLevel(4) && damageEvent.damageType == HotfixEnum.damageType.NORMAL)
		{
			_actor.buffComponent.AddBuff(14396411, _actor);
		}
	}

	private bool CheckCanTriggerWindMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		if (monster == null || hitDamageTag == null)
		{
			return false;
		}
		List<int> damageTag_TriggerWindMark = _damageTag_TriggerWindMark;
		if (damageTag_TriggerWindMark != null && damageTag_TriggerWindMark.Count > 0 && CommonUtils.CheckElementMark(CommonDefine.Wind, monster) && CommonUtils.CheckTriggerElementMarkCD(_actor, monster))
		{
			for (int i = 0; i < _damageTag_TriggerWindMark.Count; i++)
			{
				int hitTag = _damageTag_TriggerWindMark.get_Item(i);
				if (CommonUtils.CheckHitByTag(hitDamageTag, hitTag))
				{
					return true;
				}
			}
		}
		return false;
	}

	private void TriggerWindMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		monster.buffComponent.RemoveBuffByTag(CommonDefine.Wind);
		TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(_actor, new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Circle,
			innerRadius = Config.randomRadius_AreaEffect_WindMark,
			radius = Config.randomRadius_AreaEffect_WindMark,
			position = monster.tsTransform.Position
		}, isReachable: false);
		ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_143_WindTagTrigger_QiXuan", randomPointInShape);
		CommonUtils.TriggerElementMarkEvent(CommonDefine.Wind, HotfixEnum.AdventureActorElementTriggerType.WindElementTriggerType1, _actor, monster, "WindMark_Trigger_Effect_04");
		OnTriggerWindMark(hitDamageTag);
	}

	protected virtual void OnTriggerWindMark(IList<int> hitDamageTag)
	{
		if (CheckTalentLevel(1))
		{
			_actor.buffComponent.AddBuff(14396111, _actor);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
	}
}
