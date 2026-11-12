using System.Collections;
using TrueSync;

namespace AIScript.Monster._50171BingXiangGuai_V3;

public class Skill01_ThrowIceCube : SkillSimpleBase
{
	private string Throw = "Throw";

	private string TurnLeft = "TurnLeft";

	private string TurnRight = "TurnRight";

	private string Dash_Start = "Dash_Start";

	private string Dash_Loop = "Dash_Loop";

	private string Dash_Break = "Dash_Break";

	private string DashBack = "DashBack";

	private static readonly FP ThrowTime = 3;

	private static readonly string BombName = "Bullet_IceCube";

	private static readonly FP InnerIceRadius = 4;

	private static readonly FP DashSpeed1 = 12;

	private static readonly FP DashSpeed2 = 5;

	private FP DashDistance;

	private FP TimeGap;

	private FP TimeCount;

	private DeterministicShape AttackShape;

	private TSVector2 AttackPosition1;

	private TSVector2 AttackPosition2;

	private CoroutineNode ThrowIceCube_2Node;

	private long IceBuffArea;

	protected override void OnSkillEnable()
	{
		TimeCount = 0;
		if (GetMonsterTagValue(_actor, 1) == "Hard")
		{
			TimeGap = 0.2;
			TSVector2 position = new TSVector2(0, 0);
			FP radius = 10;
			FP innerRadius = 4;
			AttackShape = GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius);
		}
		else
		{
			TimeGap = 0.4;
			TSVector2 position2 = new TSVector2(0, 0);
			FP innerRadius = 10;
			FP radius = 4;
			AttackShape = GetShapeData(DeterministicShape.ShapeType.Circle, position2, default, default, innerRadius, radius);
		}
	}

	protected override void OnSkillDisable()
	{
		StopAreaEffect(IceBuffArea);
	}

	protected override IEnumerator DoMainLogic()
	{
		if (Distance(GetPosition(), new TSVector2(0, 0)) > 8)
		{
			if (AngleBetween2TSVector(GetForward(), new TSVector2(0, 0) - GetPosition(), signed: true) >= -90 && AngleBetween2TSVector(GetForward(), new TSVector2(0, 0) - GetPosition(), signed: true) <= 90)
			{
				if (AngleBetween2TSVector(GetForward(), new TSVector2(0, 0) - GetPosition(), signed: true) >= 45)
				{
					BeginAttack(1, TurnLeft, flushInputedKeys: true, forceInterruptAttack: true);
					yield return BeginLookAtByPos(new TSVector2(0, 0), 2, 45);
				}
				else if (AngleBetween2TSVector(GetForward(), new TSVector2(0, 0) - GetPosition(), signed: true) <= -45)
				{
					BeginAttack(2, TurnRight, flushInputedKeys: true, forceInterruptAttack: true);
					yield return BeginLookAtByPos(new TSVector2(0, 0), 2, 45);
				}
				else if (AngleBetween2TSVector(GetForward(), new TSVector2(0, 0) - GetPosition(), signed: true) > 0 && AngleBetween2TSVector(GetForward(), new TSVector2(0, 0) - GetPosition(), signed: true) < 45)
				{
					BeginAttack(3, TurnLeft, flushInputedKeys: true, forceInterruptAttack: true);
					yield return BeginLookAtByPos(new TSVector2(0, 0), 1, 45);
				}
				else if (AngleBetween2TSVector(GetForward(), new TSVector2(0, 0) - GetPosition(), signed: true) < 0 && AngleBetween2TSVector(GetForward(), new TSVector2(0, 0) - GetPosition(), signed: true) > -45)
				{
					BeginAttack(4, TurnRight, flushInputedKeys: true, forceInterruptAttack: true);
					yield return BeginLookAtByPos(new TSVector2(0, 0), 1, 45);
				}
				else
				{
					yield return WaitFrame(1);
				}
				BeginAttack(5, Dash_Start, flushInputedKeys: true, forceInterruptAttack: true);
				PlayEarlyWarningEffect("fx_warning_dash_4x8", 1f, 0, GetPosition(), GetRotation());
				yield return WaitCustomEvent("T1");
				IceBuffArea = PlayAreaEffect("Area_IceBuff_Dash", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1)));
				DashDistance = Distance(GetPosition(), new TSVector2(0, 0));
				BeginAttack(6, Dash_Loop, flushInputedKeys: true, forceInterruptAttack: true);
				Dash1();
				yield return WaitDashFinish();
				BeginAttack(7, Dash_Break, flushInputedKeys: true, forceInterruptAttack: true);
				Dash2();
				yield return WaitDashFinish();
				StopAreaEffect(IceBuffArea);
				yield return WaitTime(1);
			}
			else
			{
				if (AngleBetween2TSVector(GetForward(), new TSVector2(0, 0) - GetPosition(), signed: true) > 90)
				{
					BeginAttack(8, TurnRight, flushInputedKeys: true, forceInterruptAttack: true);
					yield return BeginLookAtByDir(GetPosition() - new TSVector2(0, 0), 2, 45);
				}
				else
				{
					BeginAttack(9, TurnLeft, flushInputedKeys: true, forceInterruptAttack: true);
					yield return BeginLookAtByDir(GetPosition() - new TSVector2(0, 0), 2, 45);
				}
				BeginAttack(10, DashBack, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitCustomEvent("Dash");
				IceBuffArea = PlayAreaEffect("Area_IceBuff_Dash", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, -1)));
				Dash3();
				yield return WaitDashFinish();
				CancelAttack();
				Dash4();
				yield return WaitCustomEvent("StopDash");
				StopDash();
				StopAreaEffect(IceBuffArea);
				yield return WaitCombo(ComboAttackType.isComboFinish);
				yield return WaitTime(1);
			}
		}
		else
		{
			MoveToPosition(new TSVector2(0, 0), 0.5, AdventureActor.MovementMode.Walk, 5);
			yield return WaitMoveStatus();
			yield return WaitTime(1);
		}
		BeginAttack(11, Throw, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("T1");
		while (TimeCount <= ThrowTime)
		{
			ThrowIceCube_1();
			yield return WaitTime(TimeGap);
			TimeCount += TimeGap;
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void Dash1()
	{
		BeginDashActorForward(1, DashSpeed1, DashDistance * 0.7, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}

	private void Dash2()
	{
		BeginDashActorForward(2, DashSpeed2, DashDistance * 0.3, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}

	private void Dash3()
	{
		BeginDash(1, RotateTo(GetForward(), 180), DashSpeed1, DashDistance * 0.7, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}

	private void Dash4()
	{
		BeginDash(1, RotateTo(GetForward(), 180), DashSpeed2, DashDistance * 0.3, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}

	private void ThrowIceCube_1()
	{
		AttackPosition1 = GetShapeRandomPoint(AttackShape, _actor, isReachable: true);
		FanMultipleShoot(BombName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 0.5)), 2, bulletDirectionOffset: 0, multiShootDirection: GetPosition(), aimType: AimType.Position, bulletDirectionType: BulletDirectionType.BulletToTarget, angle: 1, radius: 1, innerRadius: 0, targetPosition: AttackPosition1);
	}

	private IEnumerator ThrowIceCube_2()
	{
		if (GetMonsterTagValue(_actor, 1) == "Hard")
		{
			for (int i = 0; i <= 7; i++)
			{
				AttackPosition2 = TransLocalPosToWorldPos(GetPosition(), RotateTo(GetForward(), 45 * i), new TSVector2(0, InnerIceRadius));
				FanMultipleShoot(BombName, alignShootDelay: 0, duration: 0, shootPosition: TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 0.5)), shootPositionY: 2, bulletDirectionOffset: 0, multipleShootStyle: AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, bulletCount: 1, multiShootDirection: GetPosition(), aimType: AimType.Position, bulletDirectionType: BulletDirectionType.BulletToTarget, angle: 1, radius: 1, innerRadius: 0, targetPosition: AttackPosition2);
				yield return WaitTime(ThrowTime / 7);
			}
		}
		else
		{
			for (int i = 0; i <= 3; i++)
			{
				AttackPosition2 = TransLocalPosToWorldPos(GetPosition(), RotateTo(GetForward(), 90 * i), new TSVector2(0, InnerIceRadius));
				FanMultipleShoot(BombName, alignShootDelay: 0, duration: 0, shootPosition: TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 0.5)), shootPositionY: 2, bulletDirectionOffset: 0, multipleShootStyle: AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, bulletCount: 1, multiShootDirection: GetPosition(), aimType: AimType.Position, bulletDirectionType: BulletDirectionType.BulletToTarget, angle: 1, radius: 1, innerRadius: 0, targetPosition: AttackPosition2);
				yield return WaitTime(ThrowTime / 3);
			}
		}
	}
}
