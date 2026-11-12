using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15001;

public class ParallelScript_MainControl : ParallelScript
{
	private HitBox.HitBoxFeatureData _hitBoxFeatureData_P2;

	private int _triggerCount_P9;

	private CoroutineNode _resetTriggerCountCor_P9;

	private HashSet<long> _hittedBossSet_P13;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnBuffRemove);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
	}

	protected override void OnSelfAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
		base.OnSelfAttacked(attackEvent);
		MonsterAdventureActor monsterAdventureActor = attackEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515008, out var perkLevel) && CommonUtils.CheckElementMark(CommonDefine.LightMark1, monsterAdventureActor) && CommonUtils.CheckHitByTag(attackEvent.hitDamageTag, Config_MainControl.damageTag_TriggerBuff_P8))
		{
			_actor.buffComponent.AddBuff(15008011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515013, out perkLevel) && monsterAdventureActor.IsBossMonster())
		{
			if (_hittedBossSet_P13 == null)
			{
				_hittedBossSet_P13 = new HashSet<long>();
			}
			if (_hittedBossSet_P13.Add(monsterAdventureActor.Id))
			{
				_actor.buffComponent.AddBuff(15013011, _actor);
			}
		}
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		MonsterAdventureActor monsterAdventureActor = beforeHitEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515004, out var perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P4))
		{
			int num = _actor.logicVariable.GetLogicTagValue("AdditionalAttrCount_P4").AsInt();
			if (num > 0)
			{
				AdventureActor.AddFromAttr(15004011, _actor, num);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515007, out perkLevel))
		{
			int buffNumByID = monsterAdventureActor.buffComponent.GetBuffNumByID(15007011);
			if (buffNumByID > 0)
			{
				AdventureActor.AddFromAttr(15007001, _actor, buffNumByID);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515008, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_TriggerStrength_P8))
		{
			int num2 = _actor.logicVariable.GetLogicTagValue("AdditionalAttrCount_P8").AsInt();
			if (num2 > 0)
			{
				AdventureActor.AddFromAttr(15008001, _actor, num2);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515010, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_TriggerStrength_P10))
		{
			int buffNumByID2 = monsterAdventureActor.buffComponent.GetBuffNumByID(15010011);
			if (buffNumByID2 > 0)
			{
				AdventureActor.AddFromAttr(15010001, _actor, buffNumByID2);
			}
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515002, out var perkLevel))
		{
			if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_TriggerDamage_P2) && monsterAdventureActor.buffComponent.CheckBuffByBuffID(15002011))
			{
				if (_hitBoxFeatureData_P2 == null)
				{
					_hitBoxFeatureData_P2 = new HitBox.HitBoxFeatureData
					{
						buffIdsForTarget = new List<int> { 15002012 }
					};
				}
				ILRuntimeAPI.HitActor(_actor, monsterAdventureActor, 150310201, "fx_15001_Hit_Electric", null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.AddBuffForTarget, _hitBoxFeatureData_P2, -1);
				if (TryTriggerElectricityExplosion_P2(monsterAdventureActor, onlyCheckStrength: true))
				{
					monsterAdventureActor.buffComponent.RemoveBuffByBuffId(15002011);
				}
			}
			if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_TriggerThunder_P2))
			{
				monsterAdventureActor.buffComponent.AddBuff(15002011, _actor);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515007, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P7))
		{
			monsterAdventureActor.buffComponent.AddBuff(15007011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515010, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_TriggerBuff_P10))
		{
			monsterAdventureActor.buffComponent.AddBuff(15010011, _actor);
		}
	}

	protected override void OnTriggerLightMark(IList<int> hitDamageTag, MonsterAdventureActor target)
	{
		base.OnTriggerLightMark(hitDamageTag, target);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515009, out var perkLevel) && CommonUtils.CheckHitByTag(hitDamageTag, Config_MainControl.damageTag_Trigger_P9) && !target.IsDead() && _triggerCount_P9 < 3)
		{
			_actor.StartLogicCoroutine(PerkLogic_P9(target));
			_triggerCount_P9++;
			if (_resetTriggerCountCor_P9 == null)
			{
				_resetTriggerCountCor_P9 = _actor.StartLogicCoroutine(ResetTriggerCount_P9());
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515012, out perkLevel) && CommonUtils.CheckHitByTag(hitDamageTag, Config_MainControl.damageTag_Trigger_P12))
		{
			_actor.buffComponent.AddBuff(15012011, _actor);
		}
	}

	private void OnBuffRemove(IEvent evt)
	{
		AdventureActorRemoveBuff adventureActorRemoveBuff = evt as AdventureActorRemoveBuff;
		if (adventureActorRemoveBuff.sender as AdventureActor is MonsterAdventureActor monster && CommonUtils.HavePersonalPerk(_actor.dataID, 515002, out var _) && adventureActorRemoveBuff.eventInfo.buffId == 15002011)
		{
			TryTriggerElectricityExplosion_P2(monster);
		}
	}

	private void OnActorDied(IEvent evt)
	{
		if ((evt as AdventureActorDiedEvent).actor is MonsterAdventureActor monsterAdventureActor && CommonUtils.HavePersonalPerk(_actor.dataID, 515002, out var _) && monsterAdventureActor.buffComponent.CheckBuffByBuffID(15002011))
		{
			TryTriggerElectricityExplosion_P2(monsterAdventureActor);
		}
	}

	private bool TryTriggerElectricityExplosion_P2(MonsterAdventureActor monster, bool onlyCheckStrength = false)
	{
		int buffNumByID = monster.buffComponent.GetBuffNumByID(15002012);
		if (buffNumByID <= 0)
		{
			return false;
		}
		if (onlyCheckStrength && buffNumByID < 20)
		{
			return false;
		}
		monster.buffComponent.RemoveBuffByBuffId(15002012);
		string fxAlias = ((buffNumByID >= 20) ? "AreaEffect_150_Main_Skill_P02_Boom_Big" : "AreaEffect_150_Main_Skill_P02_Boom_Small");
		ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, monster.tsTransform.Position);
		return true;
	}

	private IEnumerator PerkLogic_P9(AdventureActor target)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config_MainControl.firstHitDelay_P9));
		int hitDamageId = 150310901;
		HashSet<long> hittedSet = new HashSet<long>();
		ILRuntimeAPI.HitActor(_actor, target, hitDamageId, null, null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.None, null, -1);
		hittedSet.Add(target.Id);
		for (int i = 0; i < 4; i++)
		{
			bool canNextLink = true;
			ILRuntimeAPI.SearchByRangeAndPosition(_actor, target.tsTransform.Position, Config_MainControl.searchRadius_P9, (List<LogicEntity> result) =>
			{
				if (result.Count > 0)
				{
					canNextLink = false;
					for (int j = 0; j < result.Count; j++)
					{
						if (hittedSet.Add(result.get_Item(j).Id))
						{
							AdventureActor adventureActor = result.get_Item(j) as AdventureActor;
							ILRuntimeAPI.HitActor(_actor, adventureActor, hitDamageId, null, "fx_15001_bullet_Main_Skill_P09_LightningChain", attackFxPlayOnTarget: true, HitBox.FeatureFlag.None, null, hurtEffectSource: target.gameObject, damageImmuneDuration: -1);
							target = adventureActor;
							canNextLink = true;
							break;
						}
					}
				}
				else
				{
					canNextLink = false;
				}
			}, isConfront: true);
			if (canNextLink)
			{
				yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config_MainControl.linkInterval_P9));
				continue;
			}
			break;
		}
	}

	private IEnumerator ResetTriggerCount_P9()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(1));
		_triggerCount_P9 = 0;
		_resetTriggerCountCor_P9 = null;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnBuffRemove);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		_triggerCount_P9 = 0;
		if (_resetTriggerCountCor_P9 != null)
		{
			_actor.StopLogicCoroutine(_resetTriggerCountCor_P9);
		}
		_resetTriggerCountCor_P9 = null;
		_hittedBossSet_P13?.Clear();
	}
}
