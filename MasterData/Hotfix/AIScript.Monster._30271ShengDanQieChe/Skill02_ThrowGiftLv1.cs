using System.Collections;
using TrueSync;

namespace AIScript.Monster._30271ShengDanQieChe;

public class Skill02_ThrowGiftLv1 : SkillSimpleBase
{
	private string ThrowGiftLv1 = "ThrowGiftLv1";

	private static readonly FP PresentTime = 3;

	private FP TimeGap;

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
		StopEffect(BoxFX);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, ThrowGiftLv1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("T1");
		BoxFX = PlayEffect("fx_m30271_loop_ThrowBoxLv1", 1f, default, default, default, 1f, actorScale: true);
		yield return WaitTime(1);
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
