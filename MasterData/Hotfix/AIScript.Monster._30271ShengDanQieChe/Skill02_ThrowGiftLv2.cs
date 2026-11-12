using System.Collections;
using TrueSync;

namespace AIScript.Monster._30271ShengDanQieChe;

public class Skill02_ThrowGiftLv2 : SkillSimpleBase
{
	private string ThrowGiftLv2 = "ThrowGiftLv2";

	private string ThrowGiftLv2_Start = "ThrowGiftLv2_Start";

	private string RunFast = "RunFast";

	private string Rest = "Rest";

	private static readonly FP PresentTime = 6;

	private readonly TSVector2 CenterPosition = new TSVector2(0, 0);

	private FP TimeGap;

	private FP TimeCount;

	private int RandomBomb;

	private int[] BombWeights_Lv1;

	private int[] BombWeights_Lv2;

	private string BombName;

	private long BoxFX;

	private DeterministicShape AttackShape;

	private TSVector2 AttackPosition;

	private long Emoji;

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
		StopEffect(Emoji);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginLookAtByPos_NotWait(CenterPosition, 0.2, 900);
		yield return WaitTime(0.2);
		BeginAttack(1, RunFast, flushInputedKeys: true, forceInterruptAttack: true);
		MoveToPosition(CenterPosition, 0.5, AdventureActor.MovementMode.Run, 5);
		yield return WaitMoveStatus();
		InterruptAttack();
		BeginAttack(1, ThrowGiftLv2_Start, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("T1");
		BoxFX = PlayEffect("fx_m30271_loop_ThrowBoxLv2_2", 1f, default, default, default, 1f, actorScale: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(2, ThrowGiftLv2, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEarlyWarningEffect("fx_common_base_Dark_YuJing_circular_3", 1f);
		yield return WaitTime(1.17);
		while (TimeCount <= PresentTime)
		{
			PresentShoot();
			yield return WaitTime(TimeGap);
			TimeCount += TimeGap;
		}
		CancelAttack();
		StopEffect(BoxFX);
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
		FP radius = 14;
		FP innerRadius = 3;
		AttackShape = GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius);
		AttackPosition = GetShapeRandomPoint(AttackShape, _actor, isReachable: true);
		PlayEffect("fx_m30271_base_ThrowBoxLv2_shoot_2");
		FanMultipleShoot(BombName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 0)), 5, bulletDirectionOffset: 0, multiShootDirection: GetPosition(), aimType: AimType.Position, bulletDirectionType: BulletDirectionType.BulletToTarget, angle: 1, radius: 1, innerRadius: 0, targetPosition: AttackPosition);
	}
}
