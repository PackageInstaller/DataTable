#define LOG_ERROR
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15601;

public class ParallelScript_Support : ParallelScript
{
	private int _triggerTimes_P25;

	private CoroutineNode _triggerCDCor_P25;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("PLAYER_SPAWN_COMPLETE", OnPlayerSpawnComplete);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
	}

	private void OnPlayerSpawnComplete(IEvent _)
	{
		_actor.logicVariable.SetLogicTagValue("InitNextRaffleTimes", 0);
		string localData = ((PlayerAdventureActor)_actor).GetLocalData("NextRaffleTimes");
		if (!string.IsNullOrEmpty(localData) && CommonUtils.TryParseStringParamToInt(localData, out var intValue) && intValue > 0 && intValue <= 5)
		{
			_actor.logicVariable.SetLogicTagValue("InitNextRaffleTimes", intValue);
			SceneSingleton<AdventurePlayerController>.Instance.ActiveActor(_actor as PlayerAdventureActor);
		}
	}

	protected override void OnSelfAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
		base.OnSelfAttacked(attackEvent);
		MonsterAdventureActor monsterAdventureActor = attackEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515625, out var _) && CommonUtils.CheckHitByTag(attackEvent.hitDamageTag, Config_Support.damageTag_Trigger_P25))
		{
			if (_triggerTimes_P25 < CommonUtils.GetScriptValue(_actor, 15625012))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_156_P25_ShotBoom", monsterAdventureActor.tsTransform.Position);
				_triggerTimes_P25++;
			}
			if (_triggerCDCor_P25 == null)
			{
				_triggerCDCor_P25 = _actor.StartLogicCoroutine(PerkLogic_P25());
			}
		}
	}

	private IEnumerator PerkLogic_P25()
	{
		FP scriptValue = CommonUtils.GetScriptValue(_actor, 15625011);
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(scriptValue));
		_triggerTimes_P25 = 0;
		_triggerCDCor_P25 = null;
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515630, out var _) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P30))
		{
			AdventureActor.AddFromAttr(15630001, _actor);
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515628, out var _) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P28))
		{
			monsterAdventureActor.buffComponent.AddBuff(15628011, _actor);
		}
	}

	private void OnBulletFinish(IEvent evt)
	{
		if (!(evt is AdventureBulletFinishEvent adventureBulletFinishEvent) || !(adventureBulletFinishEvent.owner == _actor))
		{
			return;
		}
		AdventureBulletBase adventureBulletBase = adventureBulletFinishEvent.sender as AdventureBulletBase;
		if (adventureBulletFinishEvent.bulletHashCode == Config_Support.bulletTag_Sculpture)
		{
			string fxAlias = "AreaEffect_156_Sup_Skill_PenguinStatue";
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 515621, out var perkLevel))
			{
				fxAlias = ((!CommonUtils.HavePersonalPerk(_actor.dataID, 515622, out perkLevel)) ? "AreaEffect_156_Sup_Skill_PenguinStatue_P21" : "AreaEffect_156_Sup_Skill_PenguinStatue_P22P21");
			}
			else if (CommonUtils.HavePersonalPerk(_actor.dataID, 515622, out perkLevel))
			{
				fxAlias = "AreaEffect_156_Sup_Skill_PenguinStatue_P22";
			}
			ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, adventureBulletFinishEvent.bulletPosition);
		}
		else if (adventureBulletFinishEvent.bulletHashCode == Config_Support.bulletTag_HeartArrow)
		{
			_actor.StartLogicCoroutine(HeartArrowLogic(adventureBulletBase.target, adventureBulletBase.tsTransform.Position));
		}
	}

	private IEnumerator HeartArrowLogic(LogicEntity target, TSVector2 position)
	{
		if (target == null)
		{
			NovaLogger.Error("爱心箭追踪子弹不存在目标!");
			yield break;
		}
		PlayFX playFX = new PlayFX();
		int perkLevel;
		if (_actor.IsFriendlyWith(target))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 515623, out perkLevel))
			{
				List<LogicEntity> list = ILRuntimeAPI.SearchByRangeAndPosition(_actor, position, Config_Support.searchRadius_P23, null, isConfront: true);
				if (list != null && list.Count > 0)
				{
					AdventureActor adventureActor = target as AdventureActor;
					LogicEntity logicEntity = ((!(adventureActor.attackTarget != null) || !list.Contains(adventureActor.attackTarget)) ? ILRuntimeAPI.GetTargetNearOrFar(adventureActor, iNear: true, list) : adventureActor.attackTarget);
					TSVector2 normalized = (logicEntity.tsTransform.Position - position).normalized;
					AdventureActor actor = _actor;
					FP shootPositionY_HeartArrow = Config_Support.shootPositionY_HeartArrow;
					LogicEntity target2 = logicEntity;
					ILRuntimeAPI.ShootByDirection("Bullet_156_Sup_Skill_HeartArrow", actor, default, normalized, position, shootPositionY_HeartArrow, default, target2);
				}
			}
			playFX.Play(_actor, null, "Actor/Character/15601/FX/fx_15601_base_HeartArrowEffect", default, target.tsTransform.Position, default);
			playFX.fxInstance?.Bind(target.gameObject);
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config_Support.delayTime_TakeEffect_HeartArrow));
			int buffID = 15691013;
			string fxAlias = "AreaEffect_156_Sup_Skill_HeartArrowBoom";
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 515624, out perkLevel))
			{
				fxAlias = "AreaEffect_156_Sup_Skill_HeartArrowBoom_P24";
			}
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 515630, out perkLevel))
			{
				buffID = 15630011;
			}
			((AdventureActor)target).buffComponent.AddBuff(buffID, _actor);
			ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, target.tsTransform.Position);
		}
		else
		{
			playFX.Play(_actor, null, "Actor/Character/15601/FX/fx_15601_base_HeartArrowEffect", default, target.tsTransform.Position, default);
			playFX.fxInstance?.Bind(target.gameObject);
			FP delayTime = Config_Support.delayTime_TakeEffect_HeartArrow;
			while (!target.IsDead() && delayTime > 0)
			{
				delayTime -= _actor.LogicDeltaTime;
				yield return null;
			}
			string fxAlias2 = "AreaEffect_156_Sup_Skill_HeartArrowBoom";
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 515624, out perkLevel))
			{
				fxAlias2 = "AreaEffect_156_Sup_Skill_HeartArrowBoom_P24";
			}
			ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias2, target.tsTransform.Position);
		}
	}

	private void OnAreaEffectFinish(IEvent evt)
	{
		if (evt is AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent && adventureAreaEffectFinishEvent.owner == _actor)
		{
			AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(adventureAreaEffectFinishEvent.entityID);
			if (areaEffect.CheckTag(Config_Support.areaEffectTag_Sculpture) && CommonUtils.HavePersonalPerk(_actor.dataID, 515627, out var _))
			{
				_actor.StartLogicCoroutine(PerkLogic_P27(areaEffect.tsTransform.Position));
			}
		}
	}

	private IEnumerator PerkLogic_P27(TSVector2 position)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config_Support.delayTime_GenerateAreaEffect_P27));
		ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_156_P27_PenguinStatueBoom", position);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("PLAYER_SPAWN_COMPLETE", OnPlayerSpawnComplete);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		if (_triggerCDCor_P25 != null)
		{
			_actor.StopLogicCoroutine(_triggerCDCor_P25);
		}
		_triggerCDCor_P25 = null;
		_triggerTimes_P25 = 0;
	}
}
