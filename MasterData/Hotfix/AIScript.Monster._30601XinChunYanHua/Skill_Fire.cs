using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30601XinChunYanHua;

public class Skill_Fire : SkillSimpleBase
{
	private static readonly string WireBurn = "WireBurn";

	private static readonly string Fire = "Fire";

	private static readonly FP FireTime = 10;

	private TSVector2 AttackPosition;

	private string BombName;

	private FP TimeCount;

	private FP TimeGap;

	protected override void OnSkillEnable()
	{
		TimeCount = 0;
		TimeGap = 0.5;
	}

	protected override void OnSkillDisable()
	{
		_actor.DestroySelf();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, WireBurn, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(2);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(2, Fire, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("T1");
		while (TimeCount <= FireTime)
		{
			FireShoot();
			yield return WaitTime(TimeGap);
			TimeCount += TimeGap;
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void FireShoot()
	{
		switch (randomWeight(new int[5] { 1096774245, 1701406819, 1701668214, 1281324142, 1663971958 }))
		{
		case 0:
			BombName = "Bullet_Blue";
			break;
		case 1:
			BombName = "Bullet_Green";
			break;
		case 2:
			BombName = "Bullet_Purple";
			break;
		case 3:
			BombName = "Bullet_Red";
			break;
		case 4:
			BombName = "Bullet_Yellow";
			break;
		}
		TSVector2 position = GetPosition();
		FP radius = 15;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius);
		List<LogicEntity> list = new List<LogicEntity>();
		list.AddRange(GetTargetsByFaction(isFriend: false));
		List<LogicEntity> targetsFromShape = GetTargetsFromShape(shapeData, list);
		if (targetsFromShape.Count != 0)
		{
			FP randomValue = GetRandomValue(0, targetsFromShape.Count - 1, isInt: true);
			AttackPosition = GetEntityPosition(GetTargetsByFaction(isFriend: false).get_Item((int)(long)randomValue));
		}
		else
		{
			TSVector2 position2 = GetPosition();
			radius = 8;
			FP innerRadius = 3;
			DeterministicShape shapeData2 = GetShapeData(DeterministicShape.ShapeType.Circle, position2, default, default, radius, innerRadius);
			AttackPosition = GetShapeRandomPoint(shapeData2, GetCurrentPlayer(), isReachable: true);
		}
		FanMultipleShoot(BombName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 0)), 1.5, bulletDirectionOffset: 0, multiShootDirection: GetPosition(), aimType: AimType.Position, bulletDirectionType: BulletDirectionType.BulletToTarget, angle: 1, radius: 1, innerRadius: 0, targetPosition: AttackPosition);
	}
}
