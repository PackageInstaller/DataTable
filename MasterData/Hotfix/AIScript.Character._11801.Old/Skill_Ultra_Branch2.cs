#define LOG_DEBUG
using System;
using AdventureBehaviour;

namespace AIScript.Character._11801.Old;

public class Skill_Ultra_Branch2 : Skill_Ultra
{
	public override void OnStart()
	{
		_actionKeys = new ComboInputBuffer.ActionKey[3]
		{
			ComboInputBuffer.ActionKey.B,
			(ComboInputBuffer.ActionKey)1933663295,
			(ComboInputBuffer.ActionKey)1937007987
		};
		_actionKeysForNoTimeline = new ComboInputBuffer.ActionKey[3]
		{
			ComboInputBuffer.ActionKey.U,
			ComboInputBuffer.ActionKey.B,
			ComboInputBuffer.ActionKey.A
		};
		base.OnStart();
	}

	protected void AttackPhase2()
	{
		ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.X };
		ComboAttack comboAttack = _comboAttack;
		AdventureActor actor = _actor;
		AdventureSkill skill = _skill;
		int skillId = ((_skill != null) ? _skill.skillId : 0);
		System.Action onComboFinish = OnPhase2Finish;
		System.Action onInterrupt = OnPhase2Interrupt;
		comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: false, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt);
	}

	protected override void OnFinish()
	{
		if (SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor == _actor)
		{
			_playTimeline.Play(_actor, AttackPhase2, AttackPhase2, 2);
		}
		else
		{
			AttackPhase2();
		}
	}

	protected void OnPhase2Finish()
	{
		NovaLogger.Debug("11801 Skill_Ultra_Branch2 onFinish");
		_skill.Clear();
	}

	protected void OnPhase2Interrupt()
	{
		NovaLogger.Debug("11801 Skill_Ultra_Branch2 OnInterrupt");
		_skill.Clear();
	}
}
