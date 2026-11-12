using System;

namespace AIScript.Character._15801;

public class SkillScript_Death_Soldier_Support : SkillScript_Death_Summoned
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		string text = "15801_Soldier_Die";
		if (_actor.logicVariable.GetLogicTagToggle("IsAbsorbDeath_Soldier"))
		{
			text = "15801_Soldier_LevelUp_P23";
		}
		string actionTag = text;
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
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}
}
