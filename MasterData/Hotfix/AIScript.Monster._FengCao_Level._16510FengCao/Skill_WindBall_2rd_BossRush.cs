using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._FengCao_Level._16510FengCao;

public class Skill_WindBall_2rd_BossRush : SkillSimpleBase
{
	private LogicEntity AttackTarget;

	private List<TSVector2> targetPos = new List<TSVector2>();

	private static readonly int startKeyIndex1 = 1;

	private static readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.G };

	protected override void OnSkillEnable()
	{
		targetPos.Clear();
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = GetCurrentPlayer();
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(startKeyIndex1, startKey);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		BeginLookAt_NotWait(AttackTarget, 3, 120);
		yield return WaitTime(0.5);
		AreaAttack();
		yield return WaitTime(2.2);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void AreaAttack()
	{
		FP fP = 11.5;
		int num = 3;
		int num2 = 3;
		FP fP2 = 60;
		for (int i = 0; i < num; i++)
		{
			for (int j = 0; j < num2; j++)
			{
				targetPos.Add(TransLocalPosToWorldPos(TSVector2.zero, RotateTo(TSVector2.up, 360 / num2 * j + fP2 * i), new TSVector2(0, fP / num * (i + 1))));
			}
		}
		foreach (TSVector2 targetPo in targetPos)
		{
			PlayAreaEffect("DropAttack_DropFx_Loop", targetPo);
		}
	}
}
