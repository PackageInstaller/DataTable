using System;

namespace AIScript.Character._15801;

public class SkillScript_Spawn_Soldier_MainControl : SkillScript_Summoned
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		string text = "15801_Soldier_Born";
		if (_summoner != null && _summoner.logicVariable.GetLogicTagToggle("SoldierReturn"))
		{
			text = "15801_Soldier_ReBorn";
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
		_actor.Action(makeThreatAlert: false);
	}
}
