using System.Collections;
using TrueSync;

namespace AIScript.Monster._50171BingXiangGuai_V3;

public class Skill03_Dash : SkillSimpleBase
{
	private string Dash_Start = "Dash_Start";

	private string Dash_Loop = "Dash_Loop";

	private string Dash_Drift = "Dash_Drift";

	private string TurnLeft = "TurnLeft";

	private string TurnRight = "TurnRight";

	private string BombName = "Bullet_IceCube";

	private static readonly FP WarningTime = 1.6;

	private static readonly FP DashSpeed1 = 12;

	private static readonly FP DashSpeed2 = 5;

	private FP DashDistance;

	private FP TimeGap;

	private int DashTimes;

	private LogicEntity Targetenemy;

	private DeterministicShape AttackShape;

	private TSVector2 AttackPosition;

	private CoroutineNode ThrowIceCubeNode;

	private long IceBuffArea;

	protected override void OnSkillEnable()
	{
		if (GetMonsterTagValue(_actor, 1) == "Hard")
		{
			TimeGap = 0.5;
			DashTimes = 3;
		}
		else
		{
			TimeGap = 0.6;
			DashTimes = 2;
		}
	}

	protected override void OnSkillDisable()
	{
		StopCor(ThrowIceCubeNode);
		StopAreaEffect(IceBuffArea);
	}

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= 90)
		{
			BeginAttack(1, TurnLeft, flushInputedKeys: true, forceInterruptAttack: true);
			yield return BeginLookAtByPos(GetEntityPosition(Targetenemy), 2, 45);
			CancelAttack();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= -90)
		{
			BeginAttack(2, TurnRight, flushInputedKeys: true, forceInterruptAttack: true);
			yield return BeginLookAtByPos(GetEntityPosition(Targetenemy), 2, 45);
			CancelAttack();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < 90 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= 45)
		{
			BeginAttack(3, TurnLeft, flushInputedKeys: true, forceInterruptAttack: true);
			yield return BeginLookAtByPos(GetEntityPosition(Targetenemy), 1, 45);
			CancelAttack();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > -90 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= -45)
		{
			BeginAttack(4, TurnRight, flushInputedKeys: true, forceInterruptAttack: true);
			yield return BeginLookAtByPos(GetEntityPosition(Targetenemy), 1, 45);
			CancelAttack();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			yield return WaitFrame(1);
		}
		BeginAttack(5, Dash_Start, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEarlyWarningEffect("fx_warning_dash_4x20_rotation", (float)WarningTime);
		yield return WaitCustomEvent("T1");
		IceBuffArea = PlayAreaEffect("Area_IceBuff_Dash", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1)));
		StartCor(ref ThrowIceCubeNode, ThrowIceCube());
		for (int DashIndex = 1; DashIndex <= DashTimes; DashIndex++)
		{
			GetDashDistance();
			BeginAttack(6, Dash_Loop, flushInputedKeys: true, forceInterruptAttack: true);
			Dash1();
			yield return WaitDashFinish();
			BeginAttack(7, Dash_Drift, flushInputedKeys: true, forceInterruptAttack: true);
			Dash2();
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, DashDistance * 0.3 / DashSpeed2, 600 * DashSpeed2 / DashDistance);
			yield return WaitDashFinish();
		}
		StopCor(ThrowIceCubeNode);
		PlayWwiseSound("mon_50171_loop_Skill_G_Attack_fire_lp_stop");
		StopAreaEffect(IceBuffArea);
		yield return WaitTime(1);
	}

	private void Dash1()
	{
		BeginDashActorForward(1, DashSpeed1, DashDistance * 0.7, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}

	private void Dash2()
	{
		BeginDashActorForward(2, DashSpeed2, DashDistance * 0.3, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}

	private void GetDashDistance()
	{
		int num = 6;
		int num2;
		for (num2 = 30; num2 > num; num2--)
		{
			TSVector2 tSVector = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, num2));
			if (QueryPositionReachable(_actor, tSVector) && Distance(tSVector, new TSVector2(0, 0)) <= 12)
			{
				break;
			}
		}
		DashDistance = num2;
	}

	private IEnumerator ThrowIceCube()
	{
		PlayWwiseSound("mon_50171_loop_Skill_G_Attack_fire_lp");
		while (true)
		{
			Skill03_Dash skill03_Dash = this;
			Skill03_Dash skill03_Dash2 = this;
			TSVector2 position = GetPosition();
			FP radius = 8;
			FP innerRadius = 4;
			FP angle = 240;
			FP rotation = GetRotation();
			skill03_Dash.AttackShape = skill03_Dash2.GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation);
			AttackPosition = GetShapeRandomPoint(AttackShape, _actor, isReachable: true);
			FanMultipleShoot(BombName, alignShootDelay: 0, duration: 0, shootPosition: TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 0.5)), shootPositionY: 2, bulletDirectionOffset: 0, multipleShootStyle: AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, bulletCount: 1, multiShootDirection: GetPosition(), aimType: AimType.Position, bulletDirectionType: BulletDirectionType.BulletToTarget, angle: 1, radius: 1, innerRadius: 0, targetPosition: AttackPosition);
			yield return WaitTime(TimeGap);
		}
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}
}
