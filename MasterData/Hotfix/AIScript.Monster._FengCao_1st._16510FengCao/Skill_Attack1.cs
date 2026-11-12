#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._FengCao_1st._16510FengCao;

public class Skill_Attack1 : SkillSimpleBase
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
		NovaLogger.Debug(AttackTarget.name);
		if (AngleOfIncline >= 0)
		{
			yield return BeginLookAt(AttackTarget, 0.2, 900);
			BeginAttack(startKeyIndex1, startKey1, flushInputedKeys: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield return BeginLookAt(AttackTarget, 0.3, 360);
			BeginAttack(startKeyIndex2, startKey2, flushInputedKeys: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			yield return BeginLookAt(AttackTarget, 0.2, 900);
			BeginAttack(startKeyIndex2, startKey2, flushInputedKeys: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield return BeginLookAt(AttackTarget, 0.3, 360);
			BeginAttack(startKeyIndex1, startKey1, flushInputedKeys: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}
}
