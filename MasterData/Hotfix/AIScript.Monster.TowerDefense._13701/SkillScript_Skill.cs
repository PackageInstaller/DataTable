using System;
using TrueSync;

namespace AIScript.Monster.TowerDefense._13701;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	public const string AddAlertBuffEventName = "137AddJingJieBuff";

	public override FP BaseSkillTime => Config.BaseSkillTime_Alert;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = SkillFinish;
		Action onInterrupt = SkillInterrupt;
		BeginAttack("Skill_Main", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string evt)
	{
		if (evt == "137AddJingJieBuff")
		{
			int buffID = (GetPerk(1370104) ? 801370060 : 801370040);
			_actor.buffComponent.AddBuff(buffID, _actor);
		}
	}

	private void SkillFinish()
	{
		_skill?.Clear();
	}

	private void SkillInterrupt()
	{
		_skill?.Clear();
	}
}
