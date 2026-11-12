using System.Collections;
using TrueSync;

namespace AIScript.Monster._FengCao_2rd._16510FengCao;

public class Skill_Writhe_2rd : SkillSimpleBase
{
	private static readonly int startKeyIndex1 = 1;

	private static readonly ComboInputBuffer.ActionKey[] startKey1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.S };

	private static readonly int startKeyIndex2 = 2;

	private static readonly ComboInputBuffer.ActionKey[] startKey2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.T };

	private static readonly int startKeyIndex3 = 3;

	private static readonly ComboInputBuffer.ActionKey[] startKey3 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.N };

	private static readonly string StartLookAT_Event = "StartLookAt";

	private static readonly string StopLookAT_Event = "StopLookAt";

	private static FP AngleOfIncline;

	private LogicEntity AttackTarget;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		AngleOfIncline = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true);
		if (AngleOfIncline >= 0)
		{
			yield return BeginLookAt(AttackTarget, 0.2, 900);
			BeginAttack(startKeyIndex1, startKey1);
			yield return WaitCombo(ComboAttackType.isAnticipationEnd);
			CancelAttack();
			yield return WaitCombo(ComboAttackType.isComboFinish);
			int num = TSRandom.Range(0, 100);
			int num2 = 50;
			if (num < num2)
			{
				yield return BeginLookAt(AttackTarget, 0.2, 900);
				BeginAttack(startKeyIndex3, startKey3, flushInputedKeys: true);
				yield return WaitCombo(ComboAttackType.isComboFinish);
			}
			else
			{
				yield return WaitCombo(ComboAttackType.isComboFinish);
			}
		}
		else
		{
			yield return BeginLookAt(AttackTarget, 0.2, 900);
			BeginAttack(startKeyIndex2, startKey2);
			yield return WaitCombo(ComboAttackType.isAnticipationEnd);
			CancelAttack();
			yield return WaitCombo(ComboAttackType.isComboFinish);
			int num3 = TSRandom.Range(0, 100);
			int num4 = 50;
			if (num3 < num4)
			{
				yield return BeginLookAt(AttackTarget, 0.2, 900);
				BeginAttack(startKeyIndex3, startKey3, flushInputedKeys: true);
				yield return WaitCombo(ComboAttackType.isComboFinish);
			}
		}
	}
}
