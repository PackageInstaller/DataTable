using System;

namespace AIScript.Character._14101;

public class SkillScript_Death_Dragon : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		if (_actor.monsterTarget != null)
		{
			_actor.LookAt(_actor.monsterTarget.tsTransform.Position, 0);
			Action onRecoveryBegin = OnRecoveryBegin;
			Action onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack("14101_Summon_Snake_Death_Rush", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, onRecoveryBegin, onComboFinish, onInterrupt);
		}
		else
		{
			Action onInterrupt = OnRecoveryBegin;
			Action onComboFinish = OnFinish;
			Action onRecoveryBegin = OnInterrupt;
			BeginAttack("14101_Summon_Snake_Death_Idle", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, onInterrupt, onComboFinish, onRecoveryBegin);
		}
	}

	private void OnRecoveryBegin()
	{
		_actor.Hide();
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
	}
}
