using System.Collections;
using TrueSync;

namespace AIScript.Monster._FengCao_1st._16510FengCao;

public class Skill_Attack2 : SkillSimpleBase
{
	private static readonly int startKeyIndex1 = 1;

	private static readonly ComboInputBuffer.ActionKey[] startKey1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.X };

	private static readonly int startKeyIndex2 = 2;

	private static readonly ComboInputBuffer.ActionKey[] startKey2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.W };

	private static readonly int startKeyIndex3 = 3;

	private static readonly ComboInputBuffer.ActionKey[] startKey3 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };

	private static readonly string StopLookAT_Event = "StopLookAt";

	private static FP AngleOfIncline;

	private LogicEntity AttackTarget;

	protected override IEnumerator DoMainLogic()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
		AngleOfIncline = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true);
		if (AngleOfIncline >= 0)
		{
			BeginAttack(startKeyIndex1, startKey1, flushInputedKeys: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			BeginAttack(startKeyIndex2, startKey2, flushInputedKeys: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}
}
