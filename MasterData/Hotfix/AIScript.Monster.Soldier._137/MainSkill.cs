using System;
using TrueSync;

namespace AIScript.Monster.Soldier._137;

public class MainSkill : SkillAdvancedBase
{
	public const string ComboTag = "MainSkill";

	public const int buffId_State_Skill = 13700011;

	public const string AddAlertBuffEventName = "137AddJingJieBuff";

	public const string AlertSessionStartName = "AlertSessionStart";

	public const string areaEffectKey_A = "AreaEffect_137_MainSkill_Ring_OutAtk";

	public const string areaEffectKey_B = "AreaEffect_137_MainSkill_Ring_In";

	public static readonly FP switchTime = 1;

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("MainSkill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string evt)
	{
		if (evt == "137AddJingJieBuff")
		{
			_actor.buffComponent.AddBuff(13700011, _actor);
			_actor.logicVariable.SetLogicTagValue("AlertSessionStart", _actor.LogicTime);
		}
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	private void OnFinish()
	{
		_skill.Clear();
	}
}
