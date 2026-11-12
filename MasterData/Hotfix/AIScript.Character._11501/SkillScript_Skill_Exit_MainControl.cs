using System;

namespace AIScript.Character._11501;

public class SkillScript_Skill_Exit_MainControl : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		string comboTag = GetComboTag();
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(comboTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		_actor.ResumeAnimationGroup();
	}

	private string GetComboTag()
	{
		if (_actor.aimMode == AdventureActor.AimMode.Forward)
		{
			return "Main_Cannon_IdleExit";
		}
		return "Main_Cannon_Exit";
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
