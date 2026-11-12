using System.Collections;
using TrueSync;

namespace AIScript.Monster._FengCao_1st._16510FengCao;

public class Skill_AttackSpecial : SkillSimpleBase
{
	private static readonly int startKeyIndex1 = 1;

	private static readonly ComboInputBuffer.ActionKey[] startKey1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly int startKeyIndex2 = 2;

	private static readonly ComboInputBuffer.ActionKey[] startKey2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private static readonly string StopLookAT_Event = "StopLookAt";

	private LogicEntity AttackTarget;

	private FP TargetDis;

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
		BeginAttack(startKeyIndex1, startKey1, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		TargetDis = Distance(GetPosition(), GetEntityPosition(AttackTarget));
		if (TargetDis < 5)
		{
			yield return BeginLookAt(AttackTarget, 0.2, 900);
			BeginAttack(startKeyIndex2, startKey2, flushInputedKeys: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		yield return WaitTime(0.1f);
	}
}
