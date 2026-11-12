using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class SkillScript_Sweep : SkillScript_SkillBase
{
	protected readonly ComboInputBuffer.ActionKey[] actionKey_Left_Water = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	protected readonly ComboInputBuffer.ActionKey[] actionKey_Right_Water = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	protected readonly ComboInputBuffer.ActionKey[] actionKey_Left_Dark = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	protected readonly ComboInputBuffer.ActionKey[] actionKey_Right_Dark = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };

	protected readonly FP RotateSpeed = 90;

	protected ComboInputBuffer.ActionKey[] _actionKey;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_rotateSpeed = RotateSpeed;
		UpdateData();
	}

	protected void UpdateData()
	{
		LogicEntity logicEntity = _actor.actorSearchTargetInfo?.GetMonsterAttackTarget();
		if (CommonUtils.CheckTargetIsValid(logicEntity, 0L))
		{
			TSVector2 forward = _actor.tsTransform.Forward;
			TSVector2 b = logicEntity.tsTransform.Position - _actor.tsTransform.Position;
			bool flag = TSVector2.SignedAngle(forward, b) >= 0;
			if (_actor.buffComponent.CheckBuffByBuffID(_violentBuffId))
			{
				_actionKey = (flag ? actionKey_Left_Dark : actionKey_Right_Dark);
			}
			else
			{
				_actionKey = (flag ? actionKey_Left_Water : actionKey_Right_Water);
			}
		}
		else if (_actor.buffComponent.CheckBuffByBuffID(_violentBuffId))
		{
			_actionKey = actionKey_Left_Dark;
		}
		else
		{
			_actionKey = actionKey_Left_Water;
		}
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
		comboAttack.BeginAttack(actor, skill, actionKey, flushInputedKeys: true, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt);
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
