using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12501;

public class ParallelScript : ParallelBase
{
	protected List<int> _damageTag_TriggerWaterCorrosion;

	public override void OnEnable()
	{
		base.OnEnable();
		if (_damageTag_TriggerWaterCorrosion == null)
		{
			_damageTag_TriggerWaterCorrosion = new List<int>();
		}
		else
		{
			_damageTag_TriggerWaterCorrosion.Clear();
		}
		_damageTag_TriggerWaterCorrosion.Add(Config.damageTag_TriggerWaterCorrosion);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
	}

	private void OnReceiveAttack(IEvent evt)
	{
		AdventureActorReceiveAttackEvent adventureActorReceiveAttackEvent = evt as AdventureActorReceiveAttackEvent;
		if (adventureActorReceiveAttackEvent.from == _actor && adventureActorReceiveAttackEvent.to is MonsterAdventureActor)
		{
			OnSelfAttacked(adventureActorReceiveAttackEvent);
		}
	}

	protected virtual void OnSelfAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
	}

	private void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (!(adventureActorReceiveDamageBeforeHitEvent.from == _actor) || !(adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor monsterAdventureActor))
		{
			return;
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512541, out var perkLevel))
		{
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config.damageTag_Trigger_P41))
			{
				AdventureActor.AddFromAttr(12541002, _actor);
			}
			if ((_actor as PlayerAdventureActor).status == ActorStatus.Special)
			{
				int buffNumByID = _actor.buffComponent.GetBuffNumByID(12541011);
				if (buffNumByID > 0)
				{
					AdventureActor.AddFromAttr(12541001, _actor, buffNumByID);
				}
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512543, out perkLevel) && (monsterAdventureActor.IsBossMonster() || monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE) && (monsterAdventureActor.CheckTag(Config.tag_Cold) || monsterAdventureActor.isFrozen) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config.damageTag_TriggerB_P43))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 12543011);
			if (TSRandom.Range(FP.Zero, 100) <= scriptValue)
			{
				AdventureActor.AddFromAttr(12543001, _actor);
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 5) && (monsterAdventureActor.IsBossMonster() || monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE))
		{
			AdventureActor.AddFromAttr(12596511, _actor);
		}
		OnBeforeSelfHit(adventureActorReceiveDamageBeforeHitEvent);
	}

	protected virtual void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (adventureActorReceiveDamageEvent.from == _actor && adventureActorReceiveDamageEvent.to is MonsterAdventureActor monsterAdventureActor)
		{
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512543, out var _))
			{
				if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config.damageTag_TriggerA_P43))
				{
					monsterAdventureActor.buffComponent?.AddBuff(4100, _actor);
				}
				if (_actor.buffComponent.CheckBuffByBuffID(12543011) && monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.NORMAL && monsterAdventureActor.isFrozen && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config.damageTag_TriggerB_P43))
				{
					FP scriptValue = CommonUtils.GetScriptValue(_actor, 12543011);
					if (TSRandom.Range(FP.Zero, 100) <= scriptValue)
					{
						monsterAdventureActor.buffComponent?.RemoveBuffByTag(Config.buffTag_Frozen);
						monsterAdventureActor.Kill(_actor);
					}
				}
			}
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 1) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config.damageTag_Trigger_D1))
			{
				monsterAdventureActor.buffComponent.AddBuff(12596111, _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2) && (monsterAdventureActor.CheckTag(Config.tag_Cold) || monsterAdventureActor.isFrozen))
			{
				_actor.buffComponent.AddBuff(12596211, _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 3) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config.damageTag_Trigger_D3))
			{
				monsterAdventureActor.buffComponent.AddBuff(12596311, _actor);
			}
			OnSelfDamaged(adventureActorReceiveDamageEvent);
			if (CheckCanTriggerWaterCorrosion(monsterAdventureActor, adventureActorReceiveDamageEvent.hitDamageTag))
			{
				TriggerWaterCorrosion(monsterAdventureActor);
			}
		}
		else if (adventureActorReceiveDamageEvent.to == _actor)
		{
			OnSelfReceiveDamage(adventureActorReceiveDamageEvent);
		}
	}

	protected virtual void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	protected virtual void OnSelfReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	private bool CheckCanTriggerWaterCorrosion(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		if (monster == null || hitDamageTag == null)
		{
			return false;
		}
		if (_damageTag_TriggerWaterCorrosion == null || _damageTag_TriggerWaterCorrosion.Count <= 0)
		{
			return false;
		}
		if (CommonUtils.CheckElementMark(CommonDefine.Water, monster) && CommonUtils.CheckTriggerElementMarkCD(_actor, monster))
		{
			for (int i = 0; i < _damageTag_TriggerWaterCorrosion.Count; i++)
			{
				int hitTag = _damageTag_TriggerWaterCorrosion.get_Item(i);
				if (CommonUtils.CheckHitByTag(hitDamageTag, hitTag))
				{
					return true;
				}
			}
		}
		return false;
	}

	private void TriggerWaterCorrosion(MonsterAdventureActor monster)
	{
		if (!(monster == null))
		{
			monster.buffComponent?.RemoveBuffByTag(CommonDefine.Water);
			monster.buffComponent?.AddBuff(4021, _actor);
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_125_WaterTag1_Boom", monster.tsTransform.Position);
			if (monster.buffComponent.GetBuffNum(0, 0, Config.buffTag_Cold) >= 3)
			{
				monster.buffComponent.RemoveBuffByTag(Config.buffTag_Cold);
				monster.buffComponent.AddBuff(4100, _actor);
			}
			OnTriggerWaterCorrosion();
			CommonUtils.TriggerElementMarkEvent(CommonDefine.Water, HotfixEnum.AdventureActorElementTriggerType.WaterElementTriggerType1, _actor, monster, "WaterMark_Trigger_Effect_05");
		}
	}

	protected virtual void OnTriggerWaterCorrosion()
	{
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
	}
}
