using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13401;

public class SkillScript_Skill_Support : SkillAdvancedBase
{
	private LogicEntity _target;

	private long _targetId;

	private Dash _dash;

	private int _additionalAttrCount_P24;

	private CoroutineNode _perkLogicCor_P24;

	private CoroutineNode _perkLogicCor_P29;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_target = null;
		_targetId = 0L;
		_additionalAttrCount_P24 = 0;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513424, out var perkLevel))
		{
			if (_perkLogicCor_P24 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P24);
			}
			_perkLogicCor_P24 = _actor.StartLogicCoroutine(PerkLogic_24());
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513429, out perkLevel))
		{
			if (_perkLogicCor_P29 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P29);
			}
			_perkLogicCor_P29 = _actor.StartLogicCoroutine(PerkLogic_29());
		}
		DefaultLookAt();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
	}

	private IEnumerator PerkLogic_24()
	{
		FP interval = Config_Support.addAdditionalAttrInterval_P24;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513430, out var _))
		{
			interval = Config_Support.addAdditionalAttrInterval_P24_P30;
		}
		FP leftTime = interval;
		while (true)
		{
			if (leftTime > 0)
			{
				leftTime -= _actor.LogicDeltaTime;
			}
			else
			{
				_additionalAttrCount_P24++;
				leftTime = interval;
			}
			yield return null;
		}
	}

	private IEnumerator PerkLogic_29()
	{
		FP interval = Config_Support.addBuffInterval_P29;
		while (true)
		{
			if (interval > 0)
			{
				interval -= _actor.LogicDeltaTime;
			}
			else
			{
				_actor.buffComponent.AddBuff(13429011, _actor);
				interval = Config_Support.addBuffInterval_P29;
			}
			yield return null;
		}
	}

	public void OnStart()
	{
		BeginDash();
	}

	private void UpdateTarget(bool activeActorTargetFirst = true, bool forceUpdate = true)
	{
		if (!(_target != null) || !CommonUtils.CheckTargetIsValid(_target, _targetId) || forceUpdate)
		{
			_target = CommonUtils.GetAssistantAttackTarget(_actor, activeActorTargetFirst);
			_targetId = ((_target != null) ? _target.Id : 0);
		}
	}

	private void BeginDash()
	{
		UpdateTarget();
		FP fP = Config_Support.maxDistance_Skill_Dash;
		if (_target != null)
		{
			_actor.LookAt(_target.tsTransform.Position, 0);
			fP = TSMath.Clamp(_actor.DistanceWithRadius(_target), 0, Config_Support.maxDistance_Skill_Dash);
			fP -= Config_Support.reduceDistance_Skill_Dash_HaveTarget;
		}
		string rushComboTag = GetRushComboTag();
		Action onActivationEnd = OnRushActivationEnd;
		Action onComboFinish = OnSkillFinish;
		Action onInterrupt = OnSkillInterrupt;
		BeginAttack(rushComboTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, onActivationEnd);
		if (fP > 0)
		{
			_actor.PauseMovementBlock();
			if (_dash == null)
			{
				_dash = new Dash();
			}
			else
			{
				_dash?.Clear();
			}
			_dash.BeginDash(_actor, _actor.tsTransform.Forward, Config_Support.speed_Skill_Dash, fP, default, OnDashFinish, null, null, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		}
	}

	private string GetRushComboTag()
	{
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513426, out var perkLevel))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513423, out perkLevel))
			{
				return "134_Support_Rush_P26P23";
			}
			return "134_Support_Rush_P26";
		}
		return "134_Support_Rush";
	}

	private void OnDashFinish()
	{
		_actor.ResumeMovementBlock();
	}

	private void OnRushActivationEnd()
	{
		Attack();
	}

	private void Attack()
	{
		_dash?.Interrupte();
		UpdateTarget(activeActorTargetFirst: false, forceUpdate: false);
		if (_target != null)
		{
			_actor.LookAt(_target.tsTransform.Position, 0);
		}
		string attackComboTag = GetAttackComboTag();
		Action onActivationEnd = OnAttackActivationEnd;
		Action onComboFinish = OnSkillFinish;
		Action onInterrupt = OnSkillInterrupt;
		BeginAttack(attackComboTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, onActivationEnd);
	}

	private string GetAttackComboTag()
	{
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513421, out var perkLevel))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513423, out perkLevel))
			{
				return "134_Support_Hurt_P21P23";
			}
			return "134_Support_Hurt_P21";
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513423, out perkLevel))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513424, out perkLevel))
			{
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 513430, out perkLevel))
				{
					return "134_Support_Hurt_P24P30P23";
				}
				return "134_Support_Hurt_P24P23";
			}
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513430, out perkLevel))
			{
				return "134_Support_Hurt_P23P30";
			}
			return "134_Support_Hurt_P23";
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513424, out perkLevel))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513430, out perkLevel))
			{
				return "134_Support_Hurt_P24P30";
			}
			return "134_Support_Hurt_P24";
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513430, out perkLevel))
		{
			return "134_Support_Hurt_P30";
		}
		return "134_Support_Hurt";
	}

	private void OnAttackActivationEnd()
	{
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513422, out var _))
		{
			Action onComboFinish = OnSkillFinish;
			Action onInterrupt = OnSkillInterrupt;
			BeginAttack("134_Support_End_P22", flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		}
	}

	private void OnBeforeHit(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent && adventureActorReceiveDamageBeforeHitEvent.from == _actor && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config_Support.damageTag_Skill))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513423, out var perkLevel))
			{
				AdventureActor.AddFromAttr(13423011, _actor);
			}
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513424, out perkLevel))
			{
				AdventureActor.AddFromAttr(13424011, _actor, _additionalAttrCount_P24);
			}
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513430, out perkLevel))
			{
				AdventureActor.AddFromAttr(13430001, _actor);
			}
		}
	}

	private void OnSkillFinish()
	{
		_skill.Clear();
	}

	private void OnSkillInterrupt()
	{
		OnSkillFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ILRuntimeAPI.StopAreaEffectByTag(Config_Support.areaEffectTag_Skill);
		_actor.buffComponent.RemoveBuffByBuffId(13427011);
		if (_perkLogicCor_P24 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P24);
		}
		_perkLogicCor_P24 = null;
		_additionalAttrCount_P24 = 0;
		if (_perkLogicCor_P29 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P29);
		}
		_perkLogicCor_P29 = null;
		_actor.buffComponent.RemoveBuffByBuffId(13429011);
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2))
		{
			_actor.buffComponent.AddBuff(13496211, _actor);
		}
		_target = null;
		_targetId = 0L;
		_dash?.Interrupte();
		_dash?.Clear();
		_actor.ResumeMovementBlock();
	}
}
