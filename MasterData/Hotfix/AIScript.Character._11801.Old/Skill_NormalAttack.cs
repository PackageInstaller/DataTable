#define LOG_DEBUG
using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11801.Old;

public class Skill_NormalAttack : SkillAdvancedBase
{
	protected ComboAttack _comboAttack;

	protected bool _attackCancel;

	protected LogicEntity _target;

	protected FP _lostTargetDuration;

	protected FP _lostTargetMax = 1;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("11801 Skill_NormalAttack OnDisable");
		base.OnSkillDisable();
		_target = null;
		_comboAttack?.Clear();
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("11801 Skill_NormalAttack OnEnable");
		base.OnSkillEnable();
		_attackCancel = false;
		_lostTargetDuration = 0;
	}

	public void OnStart()
	{
		NovaLogger.Debug("11801 Skill_NormalAttack OnStart");
		if (_skill != null)
		{
			SetSkillPhaseConfig(SkillPhaseFeatureFlag.None, null, SkillPhaseFeatureFlag.None, null);
			_target = _actor.attackTarget;
			_actor.LookAt(_target.tsTransform.Position, 0f);
			ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[4];
			if (_comboAttack == null)
			{
				_comboAttack = new ComboAttack();
			}
			ComboAttack comboAttack = _comboAttack;
			AdventureActor actor = _actor;
			AdventureSkill skill = _skill;
			int skillId = ((_skill != null) ? _skill.skillId : 0);
			System.Action onComboFinish = OnFinish;
			System.Action onInterrupt = OnInterrupt;
			comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: false, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt);
		}
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("11801 Skill onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("11801 Skill onInterrupt");
		_skill.Clear();
	}

	public void OnUpdate()
	{
		if (_attackCancel)
		{
			return;
		}
		if (_actor.attackTarget == null)
		{
			_lostTargetDuration += _actor.LogicDeltaTime;
		}
		else
		{
			_lostTargetDuration = 0;
		}
		if (_lostTargetDuration >= _lostTargetMax)
		{
			_attackCancel = true;
			CancelAttack();
		}
		else if (_target != null && _target.GetLogicComponent<ActorHealthInfo>().isAlive)
		{
			_actor.LookAt(_target.tsTransform.Position, 0f);
			if (_actor.DistanceWithRadius(_target) > CommonUtils.GetAttackRange(_actor) && _comboAttack == null)
			{
				_attackCancel = true;
				CancelAttack();
			}
		}
		else
		{
			_attackCancel = true;
			CancelAttack();
		}
	}

	private void CancelAttack()
	{
		_comboAttack.CancelAttack();
	}
}
