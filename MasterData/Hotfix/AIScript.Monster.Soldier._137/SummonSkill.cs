using System;

namespace AIScript.Monster.Soldier._137;

public class SummonSkill : SkillAdvancedBase
{
	private const string comboTag = "Atk";

	private const string comboTag_Potential = "Atk_N";

	private int _potentialLv;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
	}

	public void OnStart()
	{
		string actionTag = ((_potentialLv >= 3) ? "Atk_N" : "Atk");
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt);
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
