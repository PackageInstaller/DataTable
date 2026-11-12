using System.Collections;
using TrueSync;

namespace AIScript.Monster._Fire._50181ShunYiGuai;

public class Fire_Attack04 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack04 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack04, flushInputedKeys: true, forceInterruptAttack: true);
		StartCor(BombAttack());
		yield return WaitFrame(40);
		StartCor(BombAttack());
		yield return WaitFrame(40);
		StartCor(BombAttack());
		yield return WaitTime(2.3);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator BombAttack()
	{
		GetEnemy();
		TSVector2 entityPosition = GetEntityPosition(Targetenemy);
		Fire_Attack04 fire_Attack = this;
		FP radius = 4;
		FP innerRadius = 3;
		DeterministicShape shapeData = fire_Attack.GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, radius, innerRadius);
		TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, GetMonsterCloner(), isReachable: true);
		int num = 0;
		while (Distance(shapeRandomPoint, new TSVector2(0, 0)) > 14 && num < 50)
		{
			shapeRandomPoint = GetShapeRandomPoint(shapeData, GetMonsterCloner(), isReachable: true);
			num++;
		}
		GetEnemy();
		TSVector2 entityPosition2 = GetEntityPosition(Targetenemy);
		Fire_Attack04 fire_Attack2 = this;
		innerRadius = 6;
		radius = 5.9;
		DeterministicShape shapeData2 = fire_Attack2.GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition2, default, default, innerRadius, radius);
		TSVector2 SkillPos02 = GetShapeRandomPoint(shapeData2, GetMonsterCloner(), isReachable: true);
		int num2 = 0;
		while (num2 < 100 && (Distance(SkillPos02, shapeRandomPoint) < 4 || Distance(SkillPos02, entityPosition) < 4))
		{
			num2++;
			SkillPos02 = GetShapeRandomPoint(shapeData, GetMonsterCloner(), isReachable: true);
		}
		PlayAreaEffect("Area_50181_ShunYiGuai_Fire_Skill04_Ex_BigDoor_S", SkillPos02);
		CircleMultipleShoot("Bullet_50181_ShunYiGuai_Fire_Skill04_Door_Shadow_ExBig", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, SkillPos02, 0, entityPosition2 - SkillPos02, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
		yield return WaitTime(1.2);
		GetEnemy();
		TSVector2 entityPosition3 = GetEntityPosition(Targetenemy);
		CircleMultipleShoot("Bullet_50181_ShunYiGuai_Fire_Skill04_Ex_Big", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, SkillPos02, 0, entityPosition3 - SkillPos02, 0, AimType.Default, BulletDirectionType.ActorToBullet, 6, 0);
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
