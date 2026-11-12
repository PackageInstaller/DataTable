using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class SkillScript_Sweep_3 : SkillSimpleBase
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
			if (_actor.buffComponent.CheckBuffByBuffID(505010110))
			{
				_actionKey = (flag ? actionKey_Left_Dark : actionKey_Right_Dark);
			}
			else
			{
				_actionKey = (flag ? actionKey_Left_Water : actionKey_Right_Water);
			}
		}
		else if (_actor.buffComponent.CheckBuffByBuffID(505010110))
		{
			_actionKey = actionKey_Left_Dark;
		}
		else
		{
			_actionKey = actionKey_Left_Water;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity attackTarget = GetAttackTarget();
		BeginLookAt_NotWait(attackTarget, 0.3, 240);
		yield return WaitTime(0.3);
		BeginAttack(1, _actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
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
