using System;
using AdventureBehaviour;

namespace AIScript.Monster._5050100ShaSha;

public class SkillScript_Born : SkillAdvancedBase
{
	protected readonly ComboInputBuffer.ActionKey[] _actionKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.V };

	protected readonly string eventJumpOut = "jumpOut";

	protected ComboAttack _comboAttack;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		_comboAttack?.Clear();
	}

	public void OnStart()
	{
		PlayerCombo();
	}

	protected void PlayerCombo()
	{
		if (_comboAttack == null)
		{
			_comboAttack = new ComboAttack();
		}
		ComboAttack comboAttack = _comboAttack;
		AdventureActor actor = _actor;
		AdventureSkill skill = _skill;
		ComboInputBuffer.ActionKey[] actionKey = _actionKey;
		int skillId = ((_skill != null) ? _skill.skillId : 0);
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		comboAttack.BeginAttack(actor, skill, actionKey, flushInputedKeys: false, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventJumpOut, eventName))
		{
			_actor.Visible();
		}
	}

	protected void OnFinish()
	{
		_skill?.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}
}
