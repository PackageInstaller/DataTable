using System.Collections;
using TrueSync;

namespace AIScript.Monster._50171BingXiangGuai_V3;

public class Skill06_FrozenInjection : SkillSimpleBase
{
	private string FrozenInjection = "FrozenInjection";

	private string ShowShort = "ShowShort";

	private string TurnLeft = "TurnLeft";

	private string TurnRight = "TurnRight";

	private string Dash_Start = "Dash_Start";

	private string Dash_Loop = "Dash_Loop";

	private string Dash_Break = "Dash_Break";

	private string DashBack = "DashBack";

	private static readonly FP ThrowTime = 12;

	private static readonly string BombName = "Bullet_IceCube";

	private static readonly FP InnerIceRadius = 4;

	private static readonly FP DashSpeed1 = 12;

	private static readonly FP DashSpeed2 = 5;

	private DeterministicShape AttackShape;

	private TSVector2 AttackPosition1;

	private TSVector2 AttackPosition2;

	private FP TimeGap1;

	private FP TimeGap2;

	private FP TimeCount1;

	private FP TimeCount2;

	private CoroutineNode ThrowIceCube_2Node;

	private long Area_FrozenInjection;

	private float FXSize;

	private string AreaFrozenInjection;

	private FP DashDistance;

	private long IceBuffArea;

	protected override void OnSkillEnable()
	{
		TimeCount1 = 0;
		TimeCount2 = 0;
		if (GetMonsterTagValue(_actor, 1) == "Hard")
		{
			TimeGap1 = 0.25;
			TimeGap2 = 4;
			FXSize = 1.16f;
			AreaFrozenInjection = "Area_FrozenInjection_Lv2";
		}
		else
		{
			TimeGap1 = 0.5;
			TimeGap2 = 6;
			FXSize = 1f;
			AreaFrozenInjection = "Area_FrozenInjection_Lv1";
		}
	}

	protected override void OnSkillDisable()
	{
		StopCor(ThrowIceCube_2Node);
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
		BeginAttack(11, FrozenInjection, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("T1");
		StartCor(ref ThrowIceCube_2Node, ThrowIceCube_2());
		yield return WaitTime(1);
		while (TimeCount1 <= ThrowTime)
		{
			ThrowIceCube_1();
			yield return WaitTime(TimeGap1);
			TimeCount1 += TimeGap1;
		}
		CancelAttack();
		StopCor(ThrowIceCube_2Node);
		PlayEffect("fx_m50171_base_Skill_G_atk_G_Attack_end", 1f, 0, GetPosition(), 0, FXSize);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(12, ShowShort, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1);
		DispatchCustomEvent("IceBoom", isSelfEvent: false);
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
		if (GetMonsterTagValue(_actor, 1) == "Hard")
		{
			TSVector2 position = GetPosition();
			FP radius = 14;
			FP innerRadius = 7;
			AttackShape = GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius);
		}
		else
		{
			TSVector2 position2 = GetPosition();
			FP innerRadius = 14;
			FP radius = 6;
			FP angle = 5;
			FP tSVectToAngle = GetTSVectToAngle(GetForward(), 45 * GetRandomValue(0, 7.99, isInt: true));
			AttackShape = GetShapeData(DeterministicShape.ShapeType.Fan, position2, default, default, innerRadius, radius, angle, tSVectToAngle);
		}
		AttackPosition1 = GetShapeRandomPoint(AttackShape, _actor, isReachable: true);
		FanMultipleShoot(BombName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 0.5)), 2, bulletDirectionOffset: 0, multiShootDirection: GetPosition(), aimType: AimType.Position, bulletDirectionType: BulletDirectionType.BulletToTarget, angle: 1, radius: 1, innerRadius: 0, targetPosition: AttackPosition1);
	}

	private IEnumerator ThrowIceCube_2()
	{
		bool ShootMode = true;
		int num = randomWeight(new int[2] { 1, 1 });
		if (num != 0 && num == 1)
		{
			ShootMode = false;
		}
		if (GetMonsterTagValue(_actor, 1) == "Hard")
		{
			while (TimeCount2 <= ThrowTime)
			{
				if (ShootMode)
				{
					for (int i = 0; i <= 7; i++)
					{
						MultiShoot(i);
					}
					ShootMode = false;
				}
				else
				{
					for (int j = 0; j <= 7; j++)
					{
						MultiShoot((double)j + 0.5);
					}
					ShootMode = true;
				}
				yield return WaitTime(1);
				PlayAreaEffect(AreaFrozenInjection, GetPosition());
				yield return WaitTime(TimeGap2 - 1);
				TimeCount2 += TimeGap2;
			}
			yield break;
		}
		while (TimeCount2 <= ThrowTime)
		{
			if (ShootMode)
			{
				for (int k = 0; k <= 3; k++)
				{
					MultiShoot(2 * k);
				}
				ShootMode = false;
			}
			else
			{
				for (int l = 0; l <= 3; l++)
				{
					MultiShoot(2 * l + 1);
				}
				ShootMode = true;
			}
			yield return WaitTime(1);
			PlayAreaEffect(AreaFrozenInjection, GetPosition());
			yield return WaitTime(TimeGap2 - 1);
			TimeCount2 += TimeGap2;
		}
	}

	private void MultiShoot(FP i)
	{
		AttackPosition2 = TransLocalPosToWorldPos(GetPosition(), RotateTo(GetForward(), 45 * i), new TSVector2(0, InnerIceRadius));
		FanMultipleShoot(BombName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 0.5)), 2, bulletDirectionOffset: 0, multiShootDirection: GetPosition(), aimType: AimType.Position, bulletDirectionType: BulletDirectionType.BulletToTarget, angle: 1, radius: 1, innerRadius: 0, targetPosition: AttackPosition2);
	}
}
