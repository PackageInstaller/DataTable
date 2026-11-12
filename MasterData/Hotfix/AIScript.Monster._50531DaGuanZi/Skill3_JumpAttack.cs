using System.Collections;
using TrueSync;

namespace AIScript.Monster._50531DaGuanZi;

internal class Skill3_JumpAttack : SkillSimpleBase
{
	private static readonly FP DashSpeed = 45;

	private static readonly ComboInputBuffer.ActionKey[] ActionKey = new ComboInputBuffer.ActionKey[1];

	private LogicEntity attackTarget;

	private FP TargetDis;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ResetBlockPriority();
		RemoveBuffFromTarget(_actor, 990010030);
	}

	protected override IEnumerator DoMainLogic()
	{
		if (CheckTargetIsValid(GetAttackTarget()))
		{
			attackTarget = GetAttackTarget();
		}
		else
		{
			attackTarget = GetCurrentPlayer();
		}
		SetBlockPriorityToStatic();
		yield return BeginLookAt(attackTarget, 0.3, 600);
		BeginAttack(1, ActionKey, flushInputedKeys: true);
		TargetDis = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true);
		Skill3_JumpAttack skill3_JumpAttack = this;
		TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, TargetDis));
		skill3_JumpAttack.PlayEffect("fx_common_base_Fire_YuJing_circular_4", 0.5f, default, position);
		yield return WaitTime(1.5);
		AddBuffToTarget(_actor, 990010030);
		BeginDashActorForward(1, DashSpeed, TargetDis, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		RemoveBuffFromTarget(_actor, 990010030);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
