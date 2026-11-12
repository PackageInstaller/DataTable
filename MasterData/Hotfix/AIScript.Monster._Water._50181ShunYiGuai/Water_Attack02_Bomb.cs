using System.Collections;
using TrueSync;

namespace AIScript.Monster._Water._50181ShunYiGuai;

public class Water_Attack02_Bomb : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack02 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		TSVector2 Enemypos01 = GetEntityPosition(Targetenemy);
		Water_Attack02_Bomb water_Attack02_Bomb = this;
		FP radius = 4;
		FP innerRadius = 3;
		DeterministicShape shapeData = water_Attack02_Bomb.GetShapeData(DeterministicShape.ShapeType.Circle, Enemypos01, default, default, radius, innerRadius);
		TSVector2 SkillPos01 = GetShapeRandomPoint(shapeData, GetMonsterCloner(), isReachable: true);
		int num = 0;
		while (Distance(SkillPos01, new TSVector2(0, 0)) > 14 && num < 50)
		{
			SkillPos01 = GetShapeRandomPoint(shapeData, GetMonsterCloner(), isReachable: true);
			num++;
		}
		PlayAreaEffect("Area_50181_ShunYiGuai_Water_Skill02_Ex_Door_S", SkillPos01);
		CircleMultipleShoot("Bullet_50181_ShunYiGuai_Water_Skill02_Door_Shadow_Ex", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, SkillPos01, 0, Enemypos01 - SkillPos01, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
		yield return WaitTime(0.3);
		CircleMultipleShoot("Bullet_50181_ShunYiGuai_Water_Skill02_Ex", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, SkillPos01, 0, Enemypos01 - SkillPos01, 0, AimType.Default, BulletDirectionType.ActorToBullet, Distance(SkillPos01, Enemypos01), 0);
		yield return WaitTime(1);
		CircleMultipleShoot("Bullet_50181_ShunYiGuai_Water_Skill02_Ex_T", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, SkillPos01, 0, Enemypos01 - SkillPos01, 0, AimType.Default, BulletDirectionType.ActorToBullet, Distance(SkillPos01, Enemypos01), 0);
		GetEnemy();
		TSVector2 entityPosition = GetEntityPosition(Targetenemy);
		Water_Attack02_Bomb water_Attack02_Bomb2 = this;
		innerRadius = 5;
		radius = 4;
		DeterministicShape shapeData2 = water_Attack02_Bomb2.GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, innerRadius, radius);
		TSVector2 SkillPos2 = GetShapeRandomPoint(shapeData2, GetMonsterCloner(), isReachable: true);
		int num2 = 0;
		while (num2 < 100 && (Distance(SkillPos2, SkillPos01) < 4 || Distance(SkillPos2, Enemypos01) < 4))
		{
			num2++;
			SkillPos2 = GetShapeRandomPoint(shapeData2, GetMonsterCloner(), isReachable: true);
		}
		PlayAreaEffect("Area_50181_ShunYiGuai_Water_Skill02_Ex_BigDoor_S", SkillPos2);
		CircleMultipleShoot("Bullet_50181_ShunYiGuai_Water_Skill02_Door_Shadow_ExBig", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, SkillPos2, 0, entityPosition - SkillPos2, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
		yield return WaitTime(1.2);
		GetEnemy();
		TSVector2 entityPosition2 = GetEntityPosition(Targetenemy);
		CircleMultipleShoot("Bullet_50181_ShunYiGuai_Water_Skill02_Ex_Big", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, SkillPos2, 0, entityPosition2 - SkillPos2, 0, AimType.Default, BulletDirectionType.ActorToBullet, 6, 0);
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
