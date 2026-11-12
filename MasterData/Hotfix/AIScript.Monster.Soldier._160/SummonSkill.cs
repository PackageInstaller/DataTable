using System;

namespace AIScript.Monster.Soldier._160;

public class SummonSkill : SkillAdvancedBase
{
	private readonly string comboTag = "Skill_1";

	private readonly string comboTag_Potential = "Skill_2";

	private int _potentialLv;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
	}

	public void OnStart()
	{
		string text = comboTag;
		if (_potentialLv >= 3)
		{
			text = comboTag_Potential;
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
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}
}
