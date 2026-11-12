using System;
using AIScript.Utils;

namespace AIScript.Character._16001;

public class SkillScript_Bounce_Summoned_MainControl : SkillScript_Base_Summoned_MainControl
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		string text = "BubbleDoll_Skill";
		if (CommonUtils.HavePersonalPerk(_summoner.dataID, 516003, out var _) && _summoner.status == ActorStatus.Special)
		{
			text = "BubbleDoll_Skill_P03";
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
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
