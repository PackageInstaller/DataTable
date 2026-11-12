using System;

namespace AIScript.Monster.Soldier._162;

public class NormalSkill : SkillAdvancedBase
{
	private const string comboNormal = "NormalAttack_1";

	private const string comboNext = "NormalAttack_2";

	private const string eventName_NextCombo = "NextCombo";

	private int _potentialLv;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustomEvent_Normal;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("NormalAttack_1", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent_Normal(string eventName)
	{
		if (string.Equals(eventName, "NextCombo"))
		{
			Action onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack("NormalAttack_2", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt);
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}
}
