using System.Collections;
using TrueSync;

namespace AIScript.Monster._30271ShengDanQieChe;

public class Skill03_DashThrowLv2 : SkillSimpleBase
{
	private string RunFastWithDamage = "RunFastWithDamage";

	private string Rest = "Rest";

	private string PutBox = "DashThrow_Start";

	private static readonly FP DashSpeed1 = 12;

	private static readonly FP DashSpeed2 = 8;

	private static readonly FP WarningTime = 2;

	private readonly TSVector2 CenterPosition = new TSVector2(0, 0);

	private FP TimeGap;

	private FP DashDistance;

	private TSVector2 DashPosition;

	private int PositionIndex;

	private int RandomBomb;

	private int[] BombWeights_Lv1;

	private int[] BombWeights_Lv2;

	private int[] DirectionWeights;

	private FP RotateAngle;

	private string BombName;

	private DeterministicShape AttackShape;

	private TSVector2 AttackPosition;

	private long Emoji;

	private long BoxAppear;

	private CoroutineNode PresentShootNode;

	private LogicEntity Targetenemy;

	private FP Knock;

	protected override void OnSkillEnable()
	{
		BombWeights_Lv1 = new int[6] { 2020173428, 1701336156, 1699767661, 1415342962, 1701668200, 1734954079 };
		BombWeights_Lv2 = new int[3] { 1819044203, 1769104211, 1113551984 };
		DirectionWeights = new int[2] { 1, 1 };
		PositionIndex = 0;
		Knock = 0;
		if (GetBuffNum(_actor, 302710003) >= 1)
		{
			TimeGap = 0.3;
		}
		else
		{
			TimeGap = 0.5;
		}
		switch (randomWeight(DirectionWeights))
		{
		case 0:
			RotateAngle = 120;
			break;
		case 1:
			RotateAngle = -120;
			break;
		}
	}

	protected override void OnSkillDisable()
	{
		StopWaitLookAt();
		StopCor(PresentShootNode);
		StopEffect(BoxAppear);
		StopEffect(Emoji);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, PutBox, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("T1");
		BoxAppear = PlayEffect("fx_m30271_loop_ThrowBoxLv2", 1f, default, default, default, 1f, actorScale: true);
		yield return WaitTime(1);
		PlayEarlyWarningEffect("fx_warning_dash_4x20_rotation", (float)WarningTime);
		Emoji = PlayEffect("fx_m50801_loop_QiEBaoXiang_Idle");
		GetEnemy();
		WaitLookAt_NoWait(Targetenemy, WarningTime, 90);
		yield return WaitTime(WarningTime);
		StopEffect(Emoji);
		yield return WaitTime(0.2);
		BeginAttack(2, RunFastWithDamage, flushInputedKeys: true, forceInterruptAttack: true);
		Emoji = PlayEffect("fx_m50801_loop_QiEBaoXiang_RunFast");
		StartCor(ref PresentShootNode, PresentShoot());
		while (PositionIndex <= 3)
		{
			GetDashDistance();
			TSVector2 NextPosition = CenterPosition + RotateTo(DashPosition - CenterPosition, RotateAngle);
			Dash1();
			yield return WaitDashFinish();
			if (Knock == 1)
			{
				Knock = 0;
				StopWaitLookAt();
				StopEffect(Emoji);
				StopCor(PresentShootNode);
				PlayEffect("fx_m30271_base_ThrowBoxLv2_end");
				StopEffect(BoxAppear);
				SetSuperArmorEnable();
				BeginAttack(3, Rest, flushInputedKeys: true, forceInterruptAttack: true);
				Emoji = PlayEffect("fx_m50801_loop_QiEBaoXiang_Dizzy");
				yield return WaitTime(6);
				StopEffect(Emoji);
				Emoji = PlayEffect("fx_m50801_base_QiEBaoXiang_Rest_end");
				yield return WaitTime(1);
				StopEffect(Emoji);
				CancelAttack();
				yield return WaitCombo(ComboAttackType.isComboFinish);
				SetSuperArmorDisable();
				AddBuffToTarget(_actor, 508010110);
				InterruptSkill();
				yield return null;
				continue;
			}
			Dash2();
			if (PositionIndex < 3)
			{
				BeginLookAtByPos_NotWait(NextPosition, DashDistance * 0.2 / DashSpeed2, 900 * DashSpeed2 / DashDistance);
			}
			else
			{
				GetEnemy();
				BeginLookAt_NotWait(Targetenemy, DashDistance * 0.2 / DashSpeed2, 900 * DashSpeed2 / DashDistance);
			}
			yield return WaitDashFinish();
			if (Knock == 1)
			{
				Knock = 0;
				StopWaitLookAt();
				StopEffect(Emoji);
				StopCor(PresentShootNode);
				PlayEffect("fx_m30271_base_ThrowBoxLv2_end");
				StopEffect(BoxAppear);
				SetSuperArmorEnable();
				BeginAttack(3, Rest, flushInputedKeys: true, forceInterruptAttack: true);
				Emoji = PlayEffect("fx_m50801_loop_QiEBaoXiang_Dizzy");
				yield return WaitTime(6);
				StopEffect(Emoji);
				Emoji = PlayEffect("fx_m50801_base_QiEBaoXiang_Rest_end");
				yield return WaitTime(1);
				StopEffect(Emoji);
				CancelAttack();
				yield return WaitCombo(ComboAttackType.isComboFinish);
				SetSuperArmorDisable();
				AddBuffToTarget(_actor, 508010110);
				InterruptSkill();
				yield return null;
			}
			else
			{
				PositionIndex++;
			}
		}
		StopCor(PresentShootNode);
		CancelAttack();
		StopEffect(Emoji);
		PlayEffect("fx_m30271_base_ThrowBoxLv2_end");
		StopEffect(BoxAppear);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetSuperArmorEnable();
		BeginAttack(3, Rest, flushInputedKeys: true, forceInterruptAttack: true);
		Emoji = PlayEffect("fx_m50801_loop_QiEBaoXiang_Rest");
		yield return WaitTime(3);
		StopEffect(Emoji);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetSuperArmorDisable();
		AddBuffToTarget(_actor, 508010110);
	}

	private void Dash1()
	{
		BeginDashActorForward(1, DashSpeed1, DashDistance * 0.8, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: true, 0.1);
	}

	private void Dash2()
	{
		BeginDashActorForward(2, DashSpeed2, DashDistance * 0.2, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: true, 0.1);
	}

	private void GetDashDistance()
	{
		int num = 10;
		int num2 = 30;
		while (num2 > num && !QueryPositionReachable(_actor, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, num2))))
		{
			num2--;
		}
		DashDistance = num2;
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
			Skill03_DashThrowLv2 skill03_DashThrowLv = this;
			Skill03_DashThrowLv2 skill03_DashThrowLv2 = this;
			TSVector2 position = GetPosition();
			FP radius = 5;
			FP innerRadius = 3;
			FP angle = 240;
			FP rotation = GetRotation();
			skill03_DashThrowLv.AttackShape = skill03_DashThrowLv2.GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation);
			AttackPosition = GetShapeRandomPoint(AttackShape, _actor, isReachable: true);
			PlayEffect("fx_m30271_base_ThrowBoxLv2_shoot");
			FanMultipleShoot(BombName, alignShootDelay: 0, duration: 0, shootPosition: TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2)), shootPositionY: 2, bulletDirectionOffset: 0, multipleShootStyle: AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, bulletCount: 1, multiShootDirection: GetPosition(), aimType: AimType.Position, bulletDirectionType: BulletDirectionType.BulletToTarget, angle: 1, radius: 1, innerRadius: 0, targetPosition: AttackPosition);
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

	protected override void DashFinishByFriend(int index)
	{
		if (index == 1 || index == 2)
		{
			Knock = 1;
		}
	}
}
