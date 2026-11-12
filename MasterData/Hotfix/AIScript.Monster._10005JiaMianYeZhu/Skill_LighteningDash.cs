using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._10005JiaMianYeZhu;

public class Skill_LighteningDash : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] LighteningDash_Combo_Left = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };

	private static readonly ComboInputBuffer.ActionKey[] LighteningDash_Combo_Right = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.K,
		ComboInputBuffer.ActionKey.K
	};

	private static readonly List<FP> LeftDashSpeed = new List<FP> { 20, 30, 40 };

	private static readonly FP RightDashSpeed = 30;

	private static readonly FP RightDashDistance = 4;

	private int DashCount;

	private FP TurnSpeed;

	private LogicEntity Target;

	private TSVector2 TargetPosition;

	private TSVector2 DashTargetPosition;

	protected override void OnSkillEnable()
	{
		DashCount = 0;
		TurnSpeed = 400;
	}

	protected override void OnSkillDisable()
	{
		RemoveBuffFromTarget(_actor, 990020140);
	}

	protected override IEnumerator DoMainLogic()
	{
		AddBuffToTarget(_actor, 990020140);
		while (DashCount < 3)
		{
			Target = GetAttackTarget();
			if (CheckTargetIsValid(Target))
			{
				TargetPosition = GetEntityPositionObsoleted(Target);
				BeginLookAtByPos_NotWait(TargetPosition, 0, TurnSpeed);
				if (CheckTargetIsValid(Target))
				{
					TargetPosition = GetEntityPositionObsoleted(Target);
				}
				DashTargetPosition = TransLocalPosToWorldPos(TargetPosition, GetPosition() - TargetPosition, new TSVector2(RightDashDistance, 0));
				BeginAttack(1, LighteningDash_Combo_Left, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitCustomEvent("Dash");
				BeginDash(1, DashTargetPosition - GetPosition(), LeftDashSpeed.get_Item(DashCount), Distance(GetPosition(), DashTargetPosition), 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
				yield return WaitDashFinish();
				PlayEffect("CommonFlashWarning", 2f, 1, GetPosition(), default, 2f);
				BeginAttack(2, LighteningDash_Combo_Right, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitCustomEvent("Dash");
				BeginDash(2, RotateTo(GetForward(), -90), RightDashSpeed, RightDashDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
				yield return WaitDashFinish();
				GetAttackTarget(isUpToDate: true);
				DashCount++;
			}
			else
			{
				DashCount = 3;
			}
		}
		BeginDash(2, RotateTo(GetForward(), -90), 3.7, 3, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitTime(1);
	}
}
