using System;
using AIScript.Utils;

namespace AIScript.Character._14001;

public class SkillScript_Return_TransformMode_MainControl : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		string comboTag = GetComboTag();
		if (string.IsNullOrEmpty(comboTag))
		{
			_skill.Clear();
			return;
		}
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(comboTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		_actor.ResumeAnimationGroup();
	}

	private string GetComboTag()
	{
		string result = null;
		if (Enum.TryParse<Config_MainControl.TransformMode>(_actor.logicVariable.GetLogicTagStringValue("TransformMode"), out var result2))
		{
			int perkLevel;
			switch (result2)
			{
			case Config_MainControl.TransformMode.Tank:
				result = "140_Main_Skill_Tank_End";
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 514011, out perkLevel))
				{
					result = "140_Main_Skill_Tank_End_P11";
				}
				return result;
			case Config_MainControl.TransformMode.MiniGun:
				result = "140_Main_Skill_Cannon_End";
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 514006, out perkLevel))
				{
					result = ((!CommonUtils.HavePersonalPerk(_actor.dataID, 514011, out perkLevel)) ? "140_Main_Skill_Fly_End" : "140_Main_Skill_Fly_End_P11");
				}
				else if (CommonUtils.HavePersonalPerk(_actor.dataID, 514011, out perkLevel))
				{
					result = "140_Main_Skill_Cannon_End_P11";
				}
				return result;
			}
		}
		return result;
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "140_P11_Shoot"))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.eventHashCode = Config_MainControl.eventHashCode_TriggerLogic_P11;
			_actor.DispatchEvent(adventureActorCustomEvent);
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

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.ResumeAnimationGroup();
	}
}
