using System.Collections;
using TrueSync;

namespace AIScript.Monster._13021XiaoMan;

public class Skill_3RowAttack : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] _3RowAttack_Combo = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1601466473,
		(ComboInputBuffer.ActionKey)1851877716,
		(ComboInputBuffer.ActionKey)1632859726
	};

	protected readonly ComboInputBuffer.ActionKey[] LeftDodge_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	protected readonly ComboInputBuffer.ActionKey[] RightDodge_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };

	protected readonly ComboInputBuffer.ActionKey[] LeftDodge_Combo_Fast = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.H };

	protected readonly ComboInputBuffer.ActionKey[] RightDodge_Combo_Fast = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.I };

	private static readonly FP PunchMoveDistance = 2;

	private static readonly FP PunchMoveSpeed = 52;

	private static readonly FP KickMoveDistance = 4;

	private static readonly FP KickMoveSpeed = 18;

	private static readonly FP DashMoveMaxDistance = 8;

	private static readonly FP DashMoveSpeed = 15;

	private FP DashDistance;

	private DeterministicShape ChooseShape;

	private LogicEntity Target;

	private TSVector2 DodgePosition;

	private TSVector2 DodgePosition_Tmp;

	private TSVector2 TargetPosition;

	private ComboInputBuffer.ActionKey[] Dodge_Combo;

	private bool NeedAnotherDodge;

	private bool IsAnotherDodge;

	private long FlashFX;

	protected override void OnSkillEnable()
	{
		NeedAnotherDodge = false;
		IsAnotherDodge = false;
	}

	protected override void OnSkillDisable()
	{
		StopWaitLookAt();
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return StartCor(ChooseDodgePoint(IsAnotherDodge: false));
		yield return StartCor(Dodge());
		if (NeedAnotherDodge)
		{
			IsAnotherDodge = true;
			yield return StartCor(ChooseDodgePoint(IsAnotherDodge: true));
			yield return StartCor(Dodge());
		}
		BeginAttack(1, _3RowAttack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(GetAttackTarget(), 999, 150);
		yield return WaitCustomEvent("StopTurn1");
		StopWaitLookAt();
		yield return WaitCustomEvent("Move1");
		BeginDashActorForward(1, PunchMoveSpeed, PunchMoveDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		BeginLookAt_NotWait(GetAttackTarget(isUpToDate: true), 999, 200);
		yield return WaitCustomEvent("StopTurn2");
		StopWaitLookAt();
		yield return WaitCustomEvent("Move2");
		BeginDashActorForward(2, KickMoveSpeed, KickMoveDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		BeginLookAt_NotWait(GetAttackTarget(isUpToDate: true), 999, 200);
		yield return WaitCustomEvent("StopTurn3");
		StopWaitLookAt();
		yield return WaitCustomEvent("Move3");
		if (CheckTargetIsValid(GetAttackTarget()))
		{
			DashDistance = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true);
			if (DashDistance >= DashMoveMaxDistance)
			{
				DashDistance = DashMoveMaxDistance;
			}
		}
		else
		{
			DashDistance = DashMoveMaxDistance;
		}
		BeginDashActorForward(3, DashMoveSpeed, DashDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator Dodge()
	{
		if (Distance(DodgePosition, GetPosition()) <= 4 && IsAnotherDodge)
		{
			yield break;
		}
		if (AngleBetween2TSVector(GetPosition() - TargetPosition, GetPosition() - DodgePosition, signed: true) >= 0)
		{
			if (IsAnotherDodge)
			{
				Dodge_Combo = LeftDodge_Combo_Fast;
			}
			else
			{
				Dodge_Combo = LeftDodge_Combo;
			}
		}
		else if (IsAnotherDodge)
		{
			Dodge_Combo = RightDodge_Combo_Fast;
		}
		else
		{
			Dodge_Combo = RightDodge_Combo;
		}
		BeginAttack(2, Dodge_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		Skill_3RowAttack skill_3RowAttack = this;
		Skill_3RowAttack skill_3RowAttack2 = this;
		TSVector2 position = GetPosition();
		skill_3RowAttack.FlashFX = skill_3RowAttack2.PlayEffect("FlashFX", 1f, default, position);
		BeginLookAtByPos_NotWait(TargetPosition, 99, 9999);
		yield return WaitCustomEvent("Dodge");
		BeginDash(9, DodgePosition - GetPosition(), 40, Distance(DodgePosition, GetPosition()), 999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		StopEffect(FlashFX);
		StopWaitLookAt();
	}

	private IEnumerator ChooseDodgePoint(bool IsAnotherDodge)
	{
		Target = GetAttackTarget();
		if (CheckTargetIsValid(Target))
		{
			TargetPosition = GetEntityPosition(Target);
		}
		int ChooseShapeRotation = 90;
		Skill_3RowAttack skill_3RowAttack = this;
		Skill_3RowAttack skill_3RowAttack2 = this;
		TSVector2 targetPosition = TargetPosition;
		FP radius = 1.5;
		FP innerRadius = 1.2;
		FP angle = 15;
		FP rotation = ChooseShapeRotation + GetTSVectToAngle(GetPosition() - TargetPosition, 0);
		skill_3RowAttack.ChooseShape = skill_3RowAttack2.GetShapeData(DeterministicShape.ShapeType.Fan, targetPosition, default, default, radius, innerRadius, angle, rotation);
		DodgePosition = GetShapeRandomPoint(ChooseShape, _actor, isReachable: true);
		int trytime = 0;
		while (DodgePosition == TargetPosition)
		{
			ChooseShapeRotation *= -1;
			Skill_3RowAttack skill_3RowAttack3 = this;
			Skill_3RowAttack skill_3RowAttack4 = this;
			TSVector2 targetPosition2 = TargetPosition;
			rotation = 1.5;
			angle = 1.2;
			innerRadius = 15;
			radius = ChooseShapeRotation + GetTSVectToAngle(GetPosition() - TargetPosition, 0);
			skill_3RowAttack3.ChooseShape = skill_3RowAttack4.GetShapeData(DeterministicShape.ShapeType.Fan, targetPosition2, default, default, rotation, angle, innerRadius, radius);
			DodgePosition = GetShapeRandomPoint(ChooseShape, _actor, isReachable: true);
			trytime++;
			if (trytime > 15)
			{
				Skill_3RowAttack skill_3RowAttack5 = this;
				Skill_3RowAttack skill_3RowAttack6 = this;
				TSVector2 targetPosition3 = TargetPosition;
				radius = 2.5;
				innerRadius = 2.2;
				angle = 15;
				skill_3RowAttack5.ChooseShape = skill_3RowAttack6.GetShapeData(DeterministicShape.ShapeType.Circle, targetPosition3, default, default, radius, innerRadius, angle);
				DodgePosition = GetShapeRandomPoint(ChooseShape, _actor, isReachable: true);
			}
			yield return null;
		}
		if (!IsAnotherDodge)
		{
			if (Distance(DodgePosition, GetPosition()) > 7)
			{
				DodgePosition_Tmp = DodgePosition;
				DodgePosition = TransLocalPosToWorldPos((DodgePosition_Tmp + GetPosition()) / 2, RotateTo(DodgePosition_Tmp - GetPosition(), -ChooseShapeRotation), new TSVector2(0, Distance(DodgePosition_Tmp, GetPosition()) / 3));
				NeedAnotherDodge = true;
			}
			else if (Distance(DodgePosition, GetPosition()) < 3)
			{
				DodgePosition_Tmp = DodgePosition;
				DodgePosition = TransLocalPosToWorldPos((DodgePosition_Tmp + GetPosition()) / 2, RotateTo(DodgePosition_Tmp - GetPosition(), -ChooseShapeRotation), new TSVector2(0, Distance(DodgePosition_Tmp, GetPosition()) * 3));
				NeedAnotherDodge = true;
			}
		}
	}
}
