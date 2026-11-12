using System;
using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class SkillScript_Born_3 : SkillSimpleBase
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
		ShowCenterHpBar();
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.1f);
		for (FP checkdis = 13; Distance(GetPosition(), GetEntityPosition(GetCurrentPlayer())) >= checkdis; checkdis += (FP)0.05)
		{
			yield return WaitTime(0.1);
		}
		yield return WaitTime(0.5);
		SummonTeammate(2, new TSVector2(-4, -1), TSVector2.down);
		SummonTeammate(2, new TSVector2(4, -1), TSVector2.down);
		yield return WaitTime(0.5);
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
