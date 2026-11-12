using System;
using AIScript.Utils;

namespace AIScript.Character._11501;

public class SkillScript_Skill_Exit_Support : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		DefaultLookAt();
	}

	public void OnStart()
	{
		string text = "Support_Blade_Exit";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511527, out var perkLevel))
		{
			text = (CommonUtils.HavePersonalPerk(_actor.dataID, 511521, out perkLevel) ? "Support_Blade_Exit_P27P21" : "Support_Blade_Exit_P27");
		}
		string actionTag = text;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		_actor.ResumeAnimationGroup();
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
