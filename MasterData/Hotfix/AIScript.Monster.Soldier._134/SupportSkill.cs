using System;

namespace AIScript.Monster.Soldier._134;

public class SupportSkill : SkillAdvancedBase
{
	private readonly string comboTag = "Support_1";

	private readonly string comboTag_Potential_1 = "Support_2";

	private readonly string comboTag_Potential_3 = "Support_3";

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
			text = comboTag_Potential_3;
		}
		else if (_potentialLv >= 1)
		{
			text = comboTag_Potential_1;
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
