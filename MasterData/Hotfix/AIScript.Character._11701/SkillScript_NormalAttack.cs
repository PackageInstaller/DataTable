#define LOG_DEBUG
using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11701;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	protected readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[4]
	{
		(ComboInputBuffer.ActionKey)1750359160,
		(ComboInputBuffer.ActionKey)1348824421,
		(ComboInputBuffer.ActionKey)1550545509,
		(ComboInputBuffer.ActionKey)1835362388
	};

	protected const string _customEventName1 = "1";

	protected readonly int _damageId1 = 117100001;

	protected readonly string _fxAlias1 = "fx_11701_bullet_atk_2";

	protected const string _customEventName2 = "2";

	protected readonly int _damageId2 = 117100001;

	protected readonly string _fxAlias2 = "fx_11701_bullet_atk_1";

	protected const string _customEventName3 = "3";

	protected readonly int _damageId3 = 117100002;

	protected readonly string _fxAlias3 = "fx_11701_bullet_atk_3";

	protected readonly string _fxAlias3_m2 = "fx_11701_bullet_Attack_3_H2";

	protected readonly FP range_m2 = 5;

	protected readonly int num_m2 = 2;

	protected ComboAttack _comboAttack;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_11701 Skill_NormalAttack OnDisable");
		base.OnSkillDisable();
		_comboAttack?.Clear();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = false;
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_11701 Skill_NormalAttack OnEnable");
		base.OnSkillEnable();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
	}

	public void OnStart()
	{
		NovaLogger.Debug("_11701 Skill_NormalAttack OnStart");
		if (!(_skill != null))
		{
			return;
		}
		SetSkillPhaseConfig(SkillPhaseFeatureFlag.Skill1 | SkillPhaseFeatureFlag.Dodge | SkillPhaseFeatureFlag.Ultimate, null, SkillPhaseFeatureFlag.Skill1 | SkillPhaseFeatureFlag.Dodge | SkillPhaseFeatureFlag.Ultimate, null);
		if (_actor.attackTarget != null)
		{
			if (_comboAttack == null)
			{
				_comboAttack = new ComboAttack();
			}
			ComboAttack comboAttack = _comboAttack;
			AdventureActor actor = _actor;
			AdventureSkill skill = _skill;
			ComboInputBuffer.ActionKey[] actionKeys = _actionKeys;
			int skillId = ((_skill != null) ? _skill.skillId : 0);
			System.Action onComboFinish = OnFinish;
			System.Action onInterrupt = OnInterrupt;
			Action<string> onCustomEvent = OnCustomEvent;
			comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: false, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt, onCustomEvent);
		}
		else
		{
			OnInterrupt();
		}
	}

	protected void OnRecoveryBegin()
	{
		NovaLogger.Debug("Skill1 onRecoveryBegin:");
	}

	protected void OnCustomEvent(string eventName)
	{
		if (_actor.aimLockedTarget != null)
		{
			AdventureActor target = (AdventureActor)_actor.aimLockedTarget;
			int num = 0;
			string attackFxPath = "";
			switch (eventName)
			{
			case "1":
				num = _damageId1;
				attackFxPath = _fxAlias1;
				break;
			case "2":
				num = _damageId2;
				attackFxPath = _fxAlias2;
				break;
			case "3":
				num = _damageId3;
				attackFxPath = _fxAlias3;
				break;
			}
			if (num > 0)
			{
				ILRuntimeAPI.HitActor(_actor, target, num, null, attackFxPath, attackFxPlayOnTarget: true);
			}
			else
			{
				NovaLogger.Debug("errorOnCustomEvent===id== " + eventName);
			}
		}
		else
		{
			OnInterrupt();
		}
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("Skill1 onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("Skill1 onInterrupt");
		OnFinish();
	}

	public void OnUpdate()
	{
		LockDirection();
		if (_actor.aimLockedTarget == null && _comboAttack != null)
		{
			_comboAttack.InterruptAttack();
		}
	}
}
