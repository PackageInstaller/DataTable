using System;

namespace AIScript.Monster.Soldier._140;

public class MainSkill : SkillAdvancedBase
{
	private readonly string comboTag_1 = "Skill_1";

	private readonly string comboTag_2 = "Skill_2";

	private readonly string comboTag_3 = "Skill_3";

	private readonly string comboTag_4 = "Skill_4";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		string actionTag = comboTag_1;
		Action onActivationEnd = OnActivationEnd_1;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, onActivationEnd);
	}

	private void OnActivationEnd_1()
	{
		string actionTag = comboTag_2;
		Action onActivationEnd = OnActivationEnd_2;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, onActivationEnd);
	}

	private void OnActivationEnd_2()
	{
		string actionTag = comboTag_3;
		Action onActivationEnd = OnActivationEnd_3;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, onActivationEnd);
	}

	private void OnActivationEnd_3()
	{
		string actionTag = comboTag_4;
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
