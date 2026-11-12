using System;

namespace AIScript.Character._12101;

public class SkillScript_Skill_MainControl : SkillAdvancedBase
{
	private bool _isEnhance;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		_isEnhance = _actor.logicVariable.GetLogicTagValue("NextEnhance") > 0;
		if (_isEnhance)
		{
			_actor.buffComponent.RemoveBuffByBuffId(12100001);
			_actor.buffComponent.AddBuff(12100011, _actor);
			_actor.logicVariable.SetLogicTagValue("NextEnhance", 0);
		}
		string actionTag = (_isEnhance ? "Skill_Main_Enhance" : "Skill_Main_Base");
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (eventName == "121_Skill_Main_Base_Buff")
		{
			_actor.buffComponent.AddBuff(12100001, _actor);
		}
	}

	private void OnFinish()
	{
		if (!_isEnhance)
		{
			bool flag = _actor.buffComponent.GetBuffNumByID(12100001) >= 2;
			_actor.logicVariable.SetLogicTagValue("NextEnhance", flag ? 1 : 0);
		}
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
