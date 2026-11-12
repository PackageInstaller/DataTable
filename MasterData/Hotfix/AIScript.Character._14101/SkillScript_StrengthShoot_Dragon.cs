using System;
using AdventureBehaviour;

namespace AIScript.Character._14101;

public class SkillScript_StrengthShoot_Dragon : SkillAdvancedBase
{
	private AimTarget _aimTarget;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (_aimTarget == null)
		{
			_aimTarget = new AimTarget();
		}
		else
		{
			_aimTarget.Cancel();
		}
	}

	public void OnStart()
	{
		if (_actor.monsterTarget != null)
		{
			_aimTarget?.Aim(_actor, null, (_actor.monsterTarget.tsTransform.Position - _actor.tsTransform.Position).normalized);
		}
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("14101_Summon_Snake_P26_HurtSkill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_aimTarget?.Cancel();
		_aimTarget?.Clear();
	}
}
