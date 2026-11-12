using System;

namespace AIScript.Character._13701;

public class SkillScript_Skill_MainControl : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		string comboTagSkillMain = Config_MainControl.ComboTagSkillMain;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		Action onAnticipationEnd = OnAnticipationEnd;
		BeginAttack(comboTagSkillMain, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnAnticipationEnd()
	{
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnCustomEvent(string evt)
	{
		if (evt == "137AddJingJieBuff")
		{
			_actor.buffComponent.AddBuff(13700011, _actor);
			_actor.logicVariable.SetLogicTagValue("AlertSessionStart", _actor.LogicTime);
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}
}
