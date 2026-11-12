using System;

namespace AIScript.Monster.Soldier._143;

public class SupportSkill : SkillAdvancedBase
{
	private readonly string comboTag = "Support_1";

	private readonly string comboTag_Potential2 = "Support_1_Plus";

	private readonly string comboTag_Potential3 = "Support_1_Plus";

	private readonly string comboTag_Extra_Potential3 = "Support_2";

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
			text = comboTag_Potential3;
		}
		else if (_potentialLv >= 2)
		{
			text = comboTag_Potential2;
		}
		string actionTag = text;
		Action onActivationEnd = OnActivationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, onActivationEnd);
	}

	private void OnActivationEnd()
	{
		if (_potentialLv >= 3)
		{
			string actionTag = comboTag_Extra_Potential3;
			Action onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		}
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
