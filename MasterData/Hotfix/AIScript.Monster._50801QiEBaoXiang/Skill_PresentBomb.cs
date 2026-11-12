using System.Collections;
using System.Runtime.CompilerServices;
using TrueSync;

namespace AIScript.Monster._50801QiEBaoXiang;

public class Skill_PresentBomb : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Present_Combo = new ComboInputBuffer.ActionKey[1];

	private static readonly FP PresentTime = 3;

	private FP TimeCount;

	private int RandomBomb;

	private int[] BombWeights;

	private string BombName;

	private DeterministicShape AttackShape;

	private TSVector2 AttackPosition;

	protected override void OnSkillEnable()
	{
		//IL_0019: Field data (rva=0x5f8) could not be found in any section!
		//IL_0019: Field data (rva=0x5f8) could not be found in any section!
		TimeCount = 0;
		int[] array = new int[4];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._1B897DDDD4C151E2A2E6E3E91B7EA0F7FC4FD5ED00EF1C9669E8566393A02586));
		BombWeights = array;
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Present_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1);
		while (TimeCount <= PresentTime)
		{
			PresentShoot();
			yield return WaitTime(0.1);
			TimeCount += (FP)0.1;
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void PresentShoot()
	{
		RandomBomb = randomWeight(BombWeights);
		switch (RandomBomb)
		{
		case 1:
			BombName = "GiftBomb_1";
			break;
		case 2:
			BombName = "GiftBomb_2";
			break;
		case 3:
			BombName = "GiftBomb_3";
			break;
		case 4:
			BombName = "GiftBomb_4";
			break;
		}
		TSVector2 position = GetPosition();
		FP radius = 10;
		FP innerRadius = 3;
		FP angle = 150;
		FP rotation = GetRotation();
		AttackShape = GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation);
		AttackPosition = GetShapeRandomPoint(AttackShape, _actor, isReachable: true);
		PlayEffect("PresentBomb_Shoot");
		FanMultipleShoot(BombName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, -1)), 3.6, bulletDirectionOffset: 0, multiShootDirection: GetPosition(), aimType: AimType.Position, bulletDirectionType: BulletDirectionType.BulletToTarget, angle: 1, radius: 1, innerRadius: 0, targetPosition: AttackPosition);
	}
}
