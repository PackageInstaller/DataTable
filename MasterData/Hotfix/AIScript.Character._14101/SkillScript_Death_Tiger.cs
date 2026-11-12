using System;

namespace AIScript.Character._14101;

public class SkillScript_Death_Tiger : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.PlayDeathAnim();
	}

	public void OnStart()
	{
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("14101_Summon_Tiger_Death", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
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
