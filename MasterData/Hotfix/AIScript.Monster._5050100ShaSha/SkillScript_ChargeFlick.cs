using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class SkillScript_ChargeFlick : SkillScript_SkillBase
{
	protected readonly ComboInputBuffer.ActionKey[] actionKey_Water = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	protected readonly ComboInputBuffer.ActionKey[] actionKey_Dark = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.O };

	protected FP RotateSpeed = 150;

	protected FP recoveryRotateSpeed = 40;

	protected ComboInputBuffer.ActionKey[] _actionKey;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_rotateSpeed = RotateSpeed;
		UpdateData();
	}

	protected void UpdateData()
	{
		if (_actor.buffComponent.CheckBuffByBuffID(_violentBuffId))
		{
			_actionKey = actionKey_Dark;
		}
		else
		{
			_actionKey = actionKey_Water;
		}
	}

	public override void OnStart()
	{
		BeginSkill();
	}

	protected override void BeginSkill()
	{
		base.BeginSkill();
		ComboAttack comboAttack = _comboAttack;
		AdventureActor actor = _actor;
		AdventureSkill skill = _skill;
		ComboInputBuffer.ActionKey[] actionKey = _actionKey;
		int skillId = ((_skill != null) ? _skill.skillId : 0);
		System.Action onInterrupt = OnInterrupt;
		System.Action onComboFinish = OnFinish;
		System.Action onRecoveryBegin = OnRecoveryBegin;
		comboAttack.BeginAttack(actor, skill, actionKey, flushInputedKeys: true, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, onRecoveryBegin, null, onComboFinish, onInterrupt);
	}

	protected void OnFinish()
	{
		_skill?.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	public void OnRecoveryBegin()
	{
		LogicEntity target = _actor.actorSearchTargetInfo?.GetMonsterAttackTarget();
		if (!CommonUtils.CheckTargetIsValid(target, 0L))
		{
			target = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		}
		_lookAtTarget.BeginLookAt(_actor, target, 999, recoveryRotateSpeed, null);
	}
}
