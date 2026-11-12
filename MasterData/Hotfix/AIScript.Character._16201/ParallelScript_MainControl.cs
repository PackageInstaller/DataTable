using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._16201;

public class ParallelScript_MainControl : ParallelScript
{
	private CoroutineNode _bindExtraSkillCor_P2;

	private CoroutineNode _rebindSkillCor_P2;

	private FP _lastTriggerTime_P2;

	private FP _lastTriggerTime_P3;

	public override void OnEnable()
	{
		base.OnEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516202, out var perkLevel))
		{
			_actor.logicVariable.ToggleLogicTag("CanBindExtraSkill_P2", value: true);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516204, out perkLevel))
		{
			_damageTag_TriggerLightMark?.Add(Config_MainControl.damageTag_Trigger_P4);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516207, out perkLevel))
		{
			_damageTag_TriggerLightMark?.Add(Config_MainControl.damageTag_Trigger_P7);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516212, out perkLevel))
		{
			_actor.buffComponent.AddBuffNum(16212011, CommonUtils.GetPlayerActorCountByElement(HotfixEnum.elementType.LE), _actor);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_ENTER_EXIT", OnEnterExitAreaEffect);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
	}

	protected override void OnReceiveCustomEvent(AdventureActorCustomEvent customEvent)
	{
		base.OnReceiveCustomEvent(customEvent);
		if (customEvent.eventHashCode == Config_MainControl.eventHashCode_TriggerLightingSword)
		{
			TriggerLightingSword();
		}
	}

	private void TriggerLightingSword()
	{
		ILRuntimeAPI.PlayAreaEffect(position: (!(_actor.attackTarget != null)) ? (_actor.tsTransform.Position + _actor.tsTransform.Forward * Config_MainControl.offsetDistance_GenerateLightingSword_Skill) : ILRuntimeAPI.GetRandomPointInShape(_actor, new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Circle,
			innerRadius = Config_MainControl.randomRadius_GenerateLightingSword_Skill,
			radius = Config_MainControl.randomRadius_GenerateLightingSword_Skill,
			position = _actor.attackTarget.tsTransform.Position
		}, isReachable: false), actor: _actor, fxAlias: "AreaEffect_162_LeiDianZhongJian_Fall_Skil_Main");
	}

	protected override void OnTriggerSwordAura()
	{
		base.OnTriggerSwordAura();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516202, out var _))
		{
			_actor.buffComponent.AddBuff(16202011, _actor);
		}
	}

	protected override bool UseHugeSwordAura()
	{
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516207, out var _))
		{
			return TSRandom.Range(0, 100) < CommonUtils.GetScriptValue(_actor, 16207011);
		}
		return base.UseHugeSwordAura();
	}

	protected override void OnSwordAuraFinish(AdventureBulletBase bullet)
	{
		base.OnSwordAuraFinish(bullet);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516205, out var _))
		{
			TSVector2 normalized = (_actor.tsTransform.Position - bullet.tsTransform.Position).normalized;
			if (Config_MainControl.backBulletKeyDic_SwordAura_P5.TryGetValue(bullet.weaponTag, out var value))
			{
				ILRuntimeAPI.ShootByDirection(value, _actor, default, normalized, bullet.tsTransform.Position, Config.shootPositionY_SwordAura);
			}
		}
	}

	protected override void OnSelfGetBuff(AdventureActorGetBuff getBuffEvent)
	{
		base.OnSelfGetBuff(getBuffEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516202, out var _) && getBuffEvent.eventInfo.buffId == 16202011 && _actor.buffComponent.HaveBuffNumMax(16202011) && _playerSkillCd.GetCurrentBindSkillId(ActionKey.B) != 16231002)
		{
			if (_bindExtraSkillCor_P2 != null)
			{
				_actor.StopLogicCoroutine(_bindExtraSkillCor_P2);
			}
			_bindExtraSkillCor_P2 = _actor.StartLogicCoroutine(BindExtraSkillLogic_P2(), runImmediately: true);
		}
	}

	protected override void OnSelfRemoveBuff(AdventureActorRemoveBuff removeBuffEvent)
	{
		base.OnSelfRemoveBuff(removeBuffEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516202, out var _) && removeBuffEvent.eventInfo.buffId == 16202011)
		{
			if (_bindExtraSkillCor_P2 != null)
			{
				_actor.StopLogicCoroutine(_bindExtraSkillCor_P2);
			}
			_bindExtraSkillCor_P2 = null;
			if (_rebindSkillCor_P2 != null)
			{
				_actor.StopLogicCoroutine(_rebindSkillCor_P2);
			}
			_rebindSkillCor_P2 = null;
		}
	}

	protected override void OnSelfCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnSelfCastSkill(castSkillEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516202, out var _) && castSkillEvent.skillEventInfo.skillId == 16231002)
		{
			if (_rebindSkillCor_P2 != null)
			{
				_actor.StopLogicCoroutine(_rebindSkillCor_P2);
			}
			_rebindSkillCor_P2 = null;
			_lastTriggerTime_P2 = _actor.LogicTime;
			_actor.buffComponent.RemoveBuffByBuffId(16202011);
			((PlayerAdventureActor)_actor).playerSkillCd.BindSkillIdToButton(ActionKey.B, 16231000);
		}
	}

	private IEnumerator BindExtraSkillLogic_P2()
	{
		FP triggerCD = CommonUtils.GetScriptValue(_actor, 16202011);
		while (_lastTriggerTime_P2 > 0 && _actor.LogicTime - _lastTriggerTime_P2 <= triggerCD)
		{
			yield return null;
		}
		while (!_actor.logicVariable.GetLogicTagToggle("CanBindExtraSkill_P2"))
		{
			yield return null;
		}
		_playerSkillCd.BindSkillIdToButton(ActionKey.B, 16231002);
		if (_rebindSkillCor_P2 != null)
		{
			_actor.StopLogicCoroutine(_rebindSkillCor_P2);
		}
		_rebindSkillCor_P2 = _actor.StartLogicCoroutine(RebindSkillLogic_P2(), runImmediately: true);
	}

	private IEnumerator RebindSkillLogic_P2()
	{
		int currentBindSkillId = _playerSkillCd.GetCurrentBindSkillId(ActionKey.B);
		if (currentBindSkillId == 16231002)
		{
			FP skillUseTimeHint = _playerSkillCd.GetSkillUseTimeHint(currentBindSkillId);
			yield return _actor.WaitTime(skillUseTimeHint);
			_actor.buffComponent.RemoveBuffByBuffId(16202011);
			_playerSkillCd.BindSkillIdToButton(ActionKey.B, 16231000);
		}
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		MonsterAdventureActor monsterAdventureActor = beforeHitEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516204, out var perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P4))
		{
			AdventureActor.AddFromAttr(16204011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516205, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P5))
		{
			AdventureActor.AddFromAttr(16205001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516206, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P6) && monsterAdventureActor.buffComponent.CheckBuffByBuffTag(Config.buffTag_Glimmer_LightMark))
		{
			AdventureActor.AddFromAttr(16206001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516208, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P8))
		{
			AdventureActor.AddFromAttr(16208001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516210, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P10))
		{
			AdventureActor.AddFromAttr(16210001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516211, out perkLevel) && monsterAdventureActor.buffComponent.CheckBuffByBuffTag(Config.buffTag_Glimmer_LightMark))
		{
			AdventureActor.AddFromAttr(16211001, _actor);
		}
	}

	protected override void OnTriggerLightMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		base.OnTriggerLightMark(monster, hitDamageTag);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516203, out var _) && (_lastTriggerTime_P3 <= 0 || _actor.LogicTime - _lastTriggerTime_P3 > CommonUtils.GetScriptValue(_actor, 16203011)))
		{
			_lastTriggerTime_P3 = _actor.LogicTime;
			TriggerLightingSword();
		}
	}

	private void OnEnterExitAreaEffect(IEvent evt)
	{
		if (evt is AdventureAreaEnterExitEvent adventureAreaEnterExitEvent && adventureAreaEnterExitEvent.owner == _actor && adventureAreaEnterExitEvent.sender is AreaEffectEntity areaEffectEntity && areaEffectEntity.CheckTag(Config_MainControl.areaEffectTag_LightingSword_Last) && adventureAreaEnterExitEvent.iEnter && adventureAreaEnterExitEvent.triggerCollider.Entity == _actor && CommonUtils.HavePersonalPerk(_actor.dataID, 516204, out var _))
		{
			float speed = Vector3.Distance(areaEffectEntity.transform.position, _actor.transform.position) / Config_MainControl.fxMoveDuration_P4.AsFloat();
			_actor.PlayMovableFx("fx_16201_bullet_ZhongJianLoop_XiShou", areaEffectEntity.transform.position, _actor.transform.position, speed);
			_actor.StartLogicCoroutine(PerkLogic_P4(Config_MainControl.fxMoveDuration_P4), runImmediately: true);
			ILRuntimeAPI.StopAreaEffect(areaEffectEntity.Id);
		}
	}

	private IEnumerator PerkLogic_P4(FP delay)
	{
		yield return _actor.WaitTime(delay);
		_actor.buffComponent.AddBuff(16204011, _actor);
	}

	private void OnAreaEffectFinish(IEvent evt)
	{
		if (evt is AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent && adventureAreaEffectFinishEvent.owner == _actor && adventureAreaEffectFinishEvent.sender is AreaEffectEntity areaEffectEntity && areaEffectEntity.CheckTag(Config_MainControl.areaEffectTag_LightingSword_Last) && CommonUtils.HavePersonalPerk(_actor.dataID, 516209, out var _))
		{
			TSVector2 normalized = (((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : _actor.tsTransform.Position) - areaEffectEntity.tsTransform.Position).normalized;
			ILRuntimeAPI.ShootByDirection("Bullet_162_P9_LeiDian", _actor, default, normalized, areaEffectEntity.tsTransform.Position, Config_MainControl.shootPositionY_P9);
		}
	}

	private void Clear()
	{
		if (_bindExtraSkillCor_P2 != null)
		{
			_actor.StopLogicCoroutine(_bindExtraSkillCor_P2);
		}
		_bindExtraSkillCor_P2 = null;
		if (_rebindSkillCor_P2 != null)
		{
			_actor.StopLogicCoroutine(_rebindSkillCor_P2);
		}
		_rebindSkillCor_P2 = null;
		_playerSkillCd.BindSkillIdToButton(ActionKey.B, 16231000);
		_lastTriggerTime_P2 = 0;
		_lastTriggerTime_P3 = 0;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_ENTER_EXIT", OnEnterExitAreaEffect);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		Clear();
	}
}
