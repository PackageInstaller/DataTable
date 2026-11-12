using System.Collections;
using TrueSync;

namespace AIScript.Monster._FengCao_2rd._16510FengCao;

public class Skill_Attack2_2rd : SkillSimpleBase
{
	private static readonly int startKeyIndex1 = 1;

	private static readonly ComboInputBuffer.ActionKey[] startKey1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.O };

	private static readonly int startKeyIndex3 = 3;

	private static readonly ComboInputBuffer.ActionKey[] startKey3 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.N };

	private static readonly string StartLookAT_Event = "StartLookAt";

	private static readonly string StopLookAT_Event = "StopLookAt";

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
		yield return BeginLookAt(AttackTarget, 0.2, 900);
		BeginAttack(startKeyIndex1, startKey1);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(0.2);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		int num = TSRandom.Range(0, 100);
		int num2 = 80;
		if (num < num2)
		{
			yield return BeginLookAt(AttackTarget, 0.2, 900);
			BeginAttack(startKeyIndex3, startKey3, flushInputedKeys: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}
}
