using System;

namespace AIScript.Character._12501;

public class SkillScript_ExitBerserk : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		if (_actor.isPlayingAttackCombo)
		{
			_actor.ResumeAnimationGroup();
			OnFinish();
			return;
		}
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Rage_End", flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		_actor.ResumeAnimationGroup();
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		comboAttack?.Clear();
	}
}
