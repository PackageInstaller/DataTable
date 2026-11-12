using System;

namespace AIScript.Monster.Soldier._137;

public class SummonDeathSkill : SkillAdvancedBase
{
	private const string comboTag = "Dead";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.PlayDeathAnim();
	}

	public void OnStart()
	{
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Dead", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}
}
