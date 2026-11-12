using System.Collections;
using TrueSync;

namespace AIScript.Monster._30271ShengDanQieChe;

public class Skill02_ThrowGiftLv1_1 : SkillSimpleBase
{
	private string ThrowGiftLv1 = "ThrowGiftLv1";

	private string RunFast = "RunFast";

	private static readonly FP PresentTime = 5;

	private readonly TSVector2 CenterPosition = new TSVector2(0, 0);

	private readonly int[] DirectionWeights = new int[2] { 1, 1 };

	private FP TimeGap;

	private FP RotateAngle;

	private FP RotateSpeed;

	private FP TimeCount;

	private int RandomBomb;

	private int[] BombWeights_Lv1;

	private int[] BombWeights_Lv2;

	private string BombName;

	private long BoxFX;

	private DeterministicShape AttackShape;

	private TSVector2 AttackPosition;

	protected override void OnSkillEnable()
	{
		TimeCount = 0;
		BombWeights_Lv1 = new int[6] { 2020173428, 1701336156, 1699767661, 1415342962, 1701668200, 1734954079 };
		BombWeights_Lv2 = new int[3] { 1819044203, 1769104211, 1113551984 };
		RotateSpeed = 360 / PresentTime;
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
			RotateAngle = 360;
			break;
		case 1:
			RotateAngle = -360;
			break;
		}
	}

	protected override void OnSkillDisable()
	{
		StopEffect(BoxFX);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginLookAtByPos_NotWait(CenterPosition, 0.2, 900);
		yield return WaitTime(0.2);
		BeginAttack(1, RunFast, flushInputedKeys: true, forceInterruptAttack: true);
		BeginDashActorForward(1, 8, Distance(GetPosition(), CenterPosition), 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		InterruptAttack();
		BeginAttack(1, ThrowGiftLv1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("T1");
		BoxFX = PlayEffect("fx_m30271_loop_ThrowBoxLv1", 1f, default, default, default, 1f, actorScale: true);
		yield return WaitTime(1);
		BeginRotateAngle_NotWait(RotateAngle, RotateSpeed);
		while (TimeCount <= PresentTime)
		{
			PresentShoot();
			yield return WaitTime(TimeGap);
			TimeCount += TimeGap;
		}
		CancelAttack();
		StopEffect(BoxFX);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(1);
	}

	private void PresentShoot()
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
		TSVector2 position = GetPosition();
		FP radius = 15;
		FP innerRadius = 3;
		FP angle = 150;
		FP rotation = GetRotation();
		AttackShape = GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation);
		AttackPosition = GetShapeRandomPoint(AttackShape, _actor, isReachable: true);
		PlayEffect("fx_m30271_base_ThrowBoxLv1_shoot");
		FanMultipleShoot(BombName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, -1)), 3.6, bulletDirectionOffset: 0, multiShootDirection: GetPosition(), aimType: AimType.Position, bulletDirectionType: BulletDirectionType.BulletToTarget, angle: 1, radius: 1, innerRadius: 0, targetPosition: AttackPosition);
	}
}
