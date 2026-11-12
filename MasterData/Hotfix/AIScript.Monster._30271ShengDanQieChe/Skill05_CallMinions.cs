using System.Collections;
using TrueSync;

namespace AIScript.Monster._30271ShengDanQieChe;

public class Skill05_CallMinions : SkillSimpleBase
{
	private string Call = "Call";

	private string Rest = "Rest";

	private string RunFastWithDamage = "RunFastWithDamage";

	private string PutBox = "DashThrow_Start";

	private readonly TSVector2 CenterPosition = new TSVector2(0, 0);

	private static readonly FP DashSpeed1 = 8;

	private static readonly FP DashSpeed2 = 6;

	private static readonly FP DashSpeed3 = 8;

	private static readonly FP DashTime = 10;

	private FP TimeGap;

	private FP DashDistance;

	private FP DashTimeIndex;

	private int[] BombWeights_Lv1;

	private int[] BombWeights_Lv2;

	private LogicEntity Targetenemy;

	private DeterministicShape DashShape;

	private TSVector2 DashPosition;

	private TSVector2 NewDirection;

	private long Emoji;

	private long BoxFX;

	private long Projection;

	private long MinionBox;

	private int[] DirectionWeights;

	private FP RotateAngle;

	private FP RotateAngle2;

	private FP ProjectionRotate;

	private int TeammateIndex;

	private int RandomBomb;

	private string BombName;

	private DeterministicShape AttackShape;

	private TSVector2 AttackPosition;

	private CoroutineNode PresentShootNode;

	private CoroutineNode CallAttackWaveNode;

	protected override void OnSkillEnable()
	{
		BombWeights_Lv1 = new int[6] { 2020173428, 1701336156, 1699767661, 1415342962, 1701668200, 1734954079 };
		BombWeights_Lv2 = new int[3] { 1819044203, 1769104211, 1113551984 };
		DirectionWeights = new int[2] { 1, 1 };
		DashTimeIndex = 0;
		if (GetBuffNum(_actor, 302710003) >= 1)
		{
			TimeGap = 0.3;
		}
		else
		{
			TimeGap = 0.5;
		}
	}

	protected override void OnSkillDisable()
	{
		StopCor(PresentShootNode);
		StopCor(CallAttackWaveNode);
		ClearActors(GetTargetByTeammateIndex(TeammateIndex));
		StopEffect(Projection);
		StopAreaEffect(MinionBox);
		StopEffect(BoxFX);
		StopEffect(Emoji);
	}

	protected override IEnumerator DoMainLogic()
	{
		switch (randomWeight(DirectionWeights))
		{
		case 0:
			RotateAngle = 93;
			RotateAngle2 = 45;
			ProjectionRotate = -9999;
			TeammateIndex = 2;
			break;
		case 1:
			RotateAngle = -93;
			RotateAngle2 = -45;
			ProjectionRotate = 9999;
			TeammateIndex = 1;
			break;
		}
		Skill05_CallMinions skill05_CallMinions = this;
		Skill05_CallMinions skill05_CallMinions2 = this;
		TSVector2 centerPosition = CenterPosition;
		FP radius = 13.1;
		FP innerRadius = 12.9;
		FP angle = 1;
		FP rotation = RotateAngle2 + AngleBetween2TSVector(new TSVector2(0, 1), GetPosition() - CenterPosition, signed: true);
		skill05_CallMinions.DashShape = skill05_CallMinions2.GetShapeData(DeterministicShape.ShapeType.Fan, centerPosition, default, default, radius, innerRadius, angle, rotation);
		DashPosition = GetShapeRandomPoint(DashShape, _actor, isReachable: true);
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.2, 720);
		yield return WaitTime(0.2);
		BeginAttack(1, Call, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("T1");
		MinionBox = PlayAreaEffect("Area_CallMinions", CenterPosition, 0);
		yield return WaitTime(0.5);
		Projection = PlayEffect("fx_m30271_loop_CallMinions_Projection", 1f, 0, new TSVector2(0, 0), 0, 1.2f);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(1, PutBox, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("T1");
		BoxFX = PlayEffect("fx_m30271_loop_ThrowBoxLv2", 1f, default, default, default, 1f, actorScale: true);
		BeginLookAtByPos_NotWait(DashPosition, 0.2, 900);
		yield return WaitTime(0.2);
		DashDistance = Distance(GetPosition(), DashPosition);
		NewDirection = DashPosition + RotateTo(DashPosition - CenterPosition, RotateAngle);
		BeginAttack(2, RunFastWithDamage, flushInputedKeys: true, forceInterruptAttack: true);
		Emoji = PlayEffect("fx_m50801_loop_QiEBaoXiang_RunFast");
		Dash1();
		yield return WaitDashFinish();
		Dash2();
		BeginLookAtByPos_NotWait(NewDirection, DashDistance * 0.2 / DashSpeed2, 900 * DashSpeed2 / DashDistance);
		yield return WaitDashFinish();
		DispatchCustomEvent("ShengDanQiEChe", isSelfEvent: false);
		Dash3();
		StartCor(ref CallAttackWaveNode, CallAttackWave());
		StartCor(ref PresentShootNode, PresentShoot());
		while (DashTimeIndex <= DashTime)
		{
			NewDirection = GetPosition() + RotateTo(GetPosition() - CenterPosition, RotateAngle);
			BeginLookAtByPos_NotWait(NewDirection, 0.1, 1800);
			yield return WaitTime(0.1);
			DashTimeIndex += (FP)0.1;
		}
		StopDash();
		CancelAttack();
		StopWaitLookAt();
		StopCor(CallAttackWaveNode);
		ClearActors(GetTargetByTeammateIndex(TeammateIndex));
		StopEffect(Projection);
		StopCor(PresentShootNode);
		PlayEffect("fx_m30271_base_ThrowBoxLv2_end");
		StopAreaEffect(MinionBox);
		StopEffect(BoxFX);
		StopEffect(Emoji);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetSuperArmorEnable();
		BeginAttack(3, Rest, flushInputedKeys: true, forceInterruptAttack: true);
		Emoji = PlayEffect("fx_m50801_loop_QiEBaoXiang_Vomit");
		yield return WaitTime(4);
		StopEffect(Emoji);
		Emoji = PlayEffect("fx_m50801_base_QiEBaoXiang_Rest_end");
		yield return WaitTime(1);
		StopEffect(Emoji);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetSuperArmorDisable();
		AddBuffToTarget(_actor, 508010110);
	}

	private void Dash1()
	{
		BeginDashActorForward(1, DashSpeed1, DashDistance * 0.8, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}

	private void Dash2()
	{
		BeginDashActorForward(2, DashSpeed2, DashDistance * 0.2, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}

	private void Dash3()
	{
		BeginDashActorForward(3, DashSpeed3, 9999, 100, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.5);
	}

	private IEnumerator PresentShoot()
	{
		while (true)
		{
			if (GetBuffNum(_actor, 302710003) >= 1)
			{
				RandomBomb = randomWeight(BombWeights_Lv2);
				switch (RandomBomb)
				{
				case 0:
					BombName = "Bullet_TrueGift_Lv2_Atk";
					break;
				case 1:
					BombName = "Bullet_TrueGift_Lv2_Def";
					break;
				case 2:
					BombName = "Bullet_FakeGift";
					break;
				}
			}
			else
			{
				RandomBomb = randomWeight(BombWeights_Lv1);
				switch (RandomBomb)
				{
				case 0:
					BombName = "Bullet_TrueGift_Lv1_Atk";
					break;
				case 1:
					BombName = "Bullet_TrueGift_Lv1_Def";
					break;
				case 2:
					BombName = "Bullet_TrueGift_Lv1_Cd";
					break;
				case 3:
					BombName = "Bullet_TrueGift_Lv1_Energy";
					break;
				case 4:
					BombName = "Bullet_TrueGift_Lv1_Speed";
					break;
				case 5:
					BombName = "Bullet_FakeGift";
					break;
				}
			}
			Skill05_CallMinions skill05_CallMinions = this;
			Skill05_CallMinions skill05_CallMinions2 = this;
			TSVector2 position = GetPosition();
			FP radius = 10;
			FP innerRadius = 3;
			FP angle = 120;
			FP rotation = GetRotation() + RotateAngle;
			skill05_CallMinions.AttackShape = skill05_CallMinions2.GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation);
			AttackPosition = GetShapeRandomPoint(AttackShape, _actor, isReachable: true);
			PlayEffect("fx_m30271_base_ThrowBoxLv2_shoot");
			FanMultipleShoot(BombName, alignShootDelay: 0, duration: 0, shootPosition: TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2)), shootPositionY: 2, bulletDirectionOffset: 0, multipleShootStyle: AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, bulletCount: 1, multiShootDirection: GetPosition(), aimType: AimType.Position, bulletDirectionType: BulletDirectionType.BulletToTarget, angle: 1, radius: 1, innerRadius: 0, targetPosition: AttackPosition);
			yield return WaitTime(TimeGap);
		}
	}

	private IEnumerator CallAttackWave()
	{
		SummonTeammate(TeammateIndex, CenterPosition, new TSVector2(0, 1), 1);
		yield return WaitTime(1);
		BeginRotateEffect(Projection, ProjectionRotate, 36);
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
