using System;

namespace AIScript.Monster.Soldier._144;

public class SupportSkill : SkillAdvancedBase
{
	private readonly string comboTag = "Support";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		string actionTag = comboTag;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}
}
