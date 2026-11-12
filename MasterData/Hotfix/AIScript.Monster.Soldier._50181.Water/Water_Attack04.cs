using System.Collections;
using TrueSync;

namespace AIScript.Monster.Soldier._50181.Water;

public class Water_Attack04 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack04 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private LogicEntity Targetenemy;

	private TSVector2 targetPosition;

	private const string Area1 = "area_50181_ShunYiGuai_Water_Skill04_Ex_BigDoor_S";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack04, flushInputedKeys: true, forceInterruptAttack: true);
		StartCor(BombAttack());
		yield return WaitTime(5.3);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator BombAttack()
	{
		GetEnemy();
		TSVector2 entityPosition = GetEntityPosition(Targetenemy);
		Water_Attack04 water_Attack = this;
		FP radius = 4;
		FP innerRadius = 3;
		DeterministicShape shapeData = water_Attack.GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, radius, innerRadius);
		TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, GetMonsterCloner(), isReachable: true);
		int num = 0;
		while (Distance(shapeRandomPoint, new TSVector2(0, 0)) > 14 && num < 50)
		{
			shapeRandomPoint = GetShapeRandomPoint(shapeData, GetMonsterCloner(), isReachable: true);
			num++;
		}
		GetEnemy();
		TSVector2 entityPosition2 = GetEntityPosition(Targetenemy);
		Water_Attack04 water_Attack2 = this;
		innerRadius = 5;
		radius = 4;
		DeterministicShape shapeData2 = water_Attack2.GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition2, default, default, innerRadius, radius);
		TSVector2 SkillPos02 = GetShapeRandomPoint(shapeData2, GetMonsterCloner(), isReachable: true);
		int num2 = 0;
		while (num2 < 100 && (Distance(SkillPos02, shapeRandomPoint) < 4 || Distance(SkillPos02, entityPosition) < 4))
		{
			num2++;
			SkillPos02 = GetShapeRandomPoint(shapeData2, GetMonsterCloner(), isReachable: true);
		}
		yield return WaitFrame(22);
		PlayAreaEffect("Area_50181_ShunYiGuai_Water_Skill04_Ex_BigDoor_S", SkillPos02);
		yield return WaitTime(0.4);
		if (GetBuffNum(_actor, 501810005) >= 1)
		{
			long AreaEffectId = PlayAreaEffect("Area_50181_ShunYiGuai_Water_Skill04_Ex_BigDoor_L_Hard", SkillPos02);
			yield return WaitTime(3.1);
			targetPosition = GetAreaEffectPosition(AreaEffectId);
			PlayAreaEffect("Area_50181_ShunYiGuai_Water_Skill04_Fountain_Big", targetPosition);
			TSVector2 entityPosition3 = GetEntityPosition(Targetenemy);
			CircleMultipleShoot("Bullet_50181_ShunYiGuai_Water_Skill04_Ex_Big", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, targetPosition, 0, entityPosition3 - targetPosition, 0, AimType.Position, BulletDirectionType.BulletToTarget, default, 0, entityPosition3);
		}
		else
		{
			long AreaEffectId = PlayAreaEffect("Area_50181_ShunYiGuai_Water_Skill04_Ex_BigDoor_L", SkillPos02);
			yield return WaitTime(3.1);
			targetPosition = GetAreaEffectPosition(AreaEffectId);
			PlayAreaEffect("Area_50181_ShunYiGuai_Water_Skill04_Fountain_Big", targetPosition);
			TSVector2 entityPosition4 = GetEntityPosition(Targetenemy);
			CircleMultipleShoot("Bullet_50181_ShunYiGuai_Water_Skill04_Ex_Big", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, targetPosition, 0, entityPosition4 - targetPosition, 0, AimType.Position, BulletDirectionType.BulletToTarget, default, 0, entityPosition4);
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
