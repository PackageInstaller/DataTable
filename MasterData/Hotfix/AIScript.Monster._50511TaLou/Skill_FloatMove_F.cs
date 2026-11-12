using System.Collections;
using TrueSync;

namespace AIScript.Monster._50511TaLou;

public class Skill_FloatMove_F : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Fly_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private FP Radius = 15;

	private FP InnerRadius = 10;

	private FP DashSpeed = 16;

	protected FP RotationSpeed = 1;

	private TSVector2 MoveToPoint;

	private TSVector2 ShapePosition;

	private FP DashDistance;

	private TSVector2 DashDirection;

	protected override void OnSkillDisable()
	{
		StopWaitLookAt();
		RemoveBuffFromTarget(_actor, 990020140);
	}

	protected override IEnumerator DoMainLogic()
	{
		AddBuffToTarget(_actor, 990020140);
		TSVector2 SelfPosition = GetPosition();
		ShapePosition = GetEntityPositionObsoleted(GetAttackTarget());
		Skill_FloatMove_F skill_FloatMove_F = this;
		TSVector2 shapePosition = ShapePosition;
		FP radius = Radius;
		FP innerRadius = InnerRadius;
		DeterministicShape RandomShape = skill_FloatMove_F.GetShapeData(DeterministicShape.ShapeType.Circle, shapePosition, default, default, radius, innerRadius);
		MoveToPoint = GetShapeRandomPoint(RandomShape, GetCurrentPlayer(), isReachable: true);
		DashDirection = MoveToPoint - SelfPosition;
		DashDistance = Distance(MoveToPoint, SelfPosition);
		while (DashDistance <= 5)
		{
			MoveToPoint = GetShapeRandomPoint(RandomShape, GetCurrentPlayer(), isReachable: true);
			DashDirection = MoveToPoint - SelfPosition;
			DashDistance = Distance(MoveToPoint, SelfPosition);
			yield return WaitFrame(1);
		}
		BeginAttack(1, Fly_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("StartDash");
		SetCloseBlockEnable();
		BeginDash(1, DashDirection, DashSpeed, DashDistance, 0, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		WaitLookAt_NoWait(GetAttackTarget(isUpToDate: true), 999, 200);
		yield return WaitDashFinish();
		CancelAttack();
		yield return WaitCustomEvent("TurnEnd");
		StopWaitLookAt();
		SetCloseBlockDisable();
		yield return WaitTime(0.25);
		BeginAttack(2, "FlyRest", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(3);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
