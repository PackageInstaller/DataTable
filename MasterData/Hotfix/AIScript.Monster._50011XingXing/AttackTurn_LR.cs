using System.Collections;
using TrueSync;

namespace AIScript.Monster._50011XingXing;

public class AttackTurn_LR : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.B,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] _actionKey2 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.B,
		ComboInputBuffer.ActionKey._2
	};

	private readonly string StartLookAT_Event = "StartLookAt";

	private LogicEntity attackTarget;

	private FP AngleOfIncline;

	protected override IEnumerator DoMainLogic()
	{
		attackTarget = GetTarget();
		AngleOfIncline = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true);
		yield return BeginLookAtByPos(GetEntityPositionObsoleted(attackTarget), 0.2, 300);
		if (AngleOfIncline >= 0)
		{
			BeginAttack(1, _actionKey1, flushInputedKeys: true);
			yield return WaitCombo(ComboAttackType.isRecoveryBegin);
			BeginLookAt_NotWait(attackTarget, 0.5, 540);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			BeginAttack(2, _actionKey2, flushInputedKeys: true);
			yield return WaitCombo(ComboAttackType.isRecoveryBegin);
			BeginLookAt_NotWait(attackTarget, 0.5, 540);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		StopLookAt();
	}

	protected LogicEntity GetTarget()
	{
		LogicEntity logicEntity = null;
		if (CheckTargetIsValid(GetAttackTarget(isUpToDate: true)))
		{
			return GetAttackTarget(isUpToDate: true);
		}
		return GetCurrentPlayer();
	}
}
