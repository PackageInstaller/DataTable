using System;
using System.Collections;
using AdventureBehaviour;

namespace AIScript.Monster._5050100ShaSha;

public class SkillScript_Born_1 : SkillSimpleBase
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

	protected override IEnumerator DoMainLogic()
	{
		while (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) >= 6)
		{
			yield return WaitTime(0.1);
		}
		yield return WaitTime(0.5);
		ShowCenterHpBar();
		yield return WaitTime(1);
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
		Action<string> action = OnCustomEvent;
		System.Action action2 = OnFinish;
		System.Action action3 = OnInterrupt;
		comboAttack.BeginAttack(actor, skill, actionKey, flushInputedKeys: false, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, action2, action3, action);
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
