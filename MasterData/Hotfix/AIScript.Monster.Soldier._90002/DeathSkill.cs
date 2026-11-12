using System;

namespace AIScript.Monster.Soldier._90002;

public class DeathSkill : SkillAdvancedBase
{
	private readonly string comboTag = "DeathSkill";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		if (_actor is SoldierActor { isSupport: not false })
		{
			OnFinish();
			return;
		}
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
