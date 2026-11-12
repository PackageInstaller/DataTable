using System.Collections;
using TrueSync;

namespace AIScript.Monster._50121DunWei;

internal class Skill_Defense_Wind : SkillSimpleBase
{
	private static readonly int DefenseBuffID = 990010300;

	private static readonly int BuffID2 = 990020010;

	private static readonly ComboInputBuffer.ActionKey[] ActionKey_Defense = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] ActionKey_Break = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		BeginLookAt_NotWait(target, 0.4, 300);
		yield return WaitTime(0.4);
		BeginAttack(1, ActionKey_Defense);
		FP deftime = 3;
		while (deftime > 0)
		{
			if (CalcAngleBetweenSelfAndAttackTarget() > 45)
			{
				RemoveBuffFromTarget(_actor, 990010300);
				AimAtTarget(target, 120);
				yield return WaitTime(0.1);
				deftime -= (FP)0.1;
			}
			else
			{
				yield return WaitTime(0.1);
				deftime -= (FP)0.1;
				CancelAim();
				AddBuffToTarget(_actor, 990010300);
			}
		}
		CancelAim();
		CancelAttack();
		RemoveBuffFromTarget(_actor, 990010300);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
