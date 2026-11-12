using System;
using AIScript.Utils;

namespace AIScript.Character._11501;

public class SkillScript_AreaAttack_Support : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		DefaultLookAt();
	}

	public void OnStart()
	{
		string text = "Support_Blade_Skill";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511523, out var _) && CommonUtils.CheckAllPlayerActorAreSameElement(HotfixEnum.elementType.LE))
		{
			text = "Support_Blade_StrengthenSkill";
		}
		string actionTag = text;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
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
