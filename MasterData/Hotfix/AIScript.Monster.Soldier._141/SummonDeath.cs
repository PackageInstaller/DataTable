using System;

namespace AIScript.Monster.Soldier._141;

public class SummonDeath : SkillAdvancedBase
{
	private readonly string comboTag = "CombosummonBoom";

	private readonly string hideModeEvent = "";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		_actor.SendDeclareDeadEvent();
		(_actor as SoldierActor)?.OnShowHud(show: false);
		string actionTag = comboTag;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, hideModeEvent))
		{
			_actor.Hide();
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}
}
