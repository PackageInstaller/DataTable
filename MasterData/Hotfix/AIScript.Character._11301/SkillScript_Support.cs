using System;
using AIScript.Utils;

namespace AIScript.Character._11301;

public class SkillScript_Support : SkillAdvancedBase
{
	private string key_prepare = "Support_Prepare";

	public void OnStart()
	{
		DoMainLogic();
	}

	public void SkillFinish()
	{
		_skill?.Clear();
	}

	public void SkillInterrupt()
	{
		_skill?.Clear();
	}

	public void DoMainLogic()
	{
		LogicEntity assistantAttackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
		string actionTag = key_prepare;
		Action onComboFinish = SkillFinish;
		Action onInterrupt = SkillInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, assistantAttackTarget, null, default, null, null, onComboFinish, onInterrupt);
	}
}
