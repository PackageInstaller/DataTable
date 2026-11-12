using System.Collections;
using TrueSync;

namespace AIScript.Monster._None._50181ShunYiGuai;

public class None_Attack02 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack02 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		Teleport(GetEntityPosition(GetCurrentPlayer()), checkPositionReachable: false);
		BeginLookAt_NotWait(Targetenemy, 1, 240);
		yield return WaitTime(0.8);
		StopLookAt();
		yield return WaitTime(0.3);
		StartCor(BombAttack());
		yield return WaitTime(4);
	}

	protected IEnumerator BombAttack()
	{
		GetEnemy();
		TSVector2 Enemypos = GetEntityPosition(Targetenemy);
		None_Attack02 none_Attack = this;
		FP radius = 4;
		FP innerRadius = 3;
		DeterministicShape shapeData = none_Attack.GetShapeData(DeterministicShape.ShapeType.Circle, Enemypos, default, default, radius, innerRadius);
		TSVector2 SkillPos = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		int num = 0;
		while (Distance(SkillPos, new TSVector2(0, 0)) > 14 && num < 50)
		{
			SkillPos = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			num++;
		}
		PlayAreaEffect("Area_50181_ShunYiGuai_Earth_Skill02_Door_S", SkillPos);
		CircleMultipleShoot("Bullet_50181_ShunYiGuai_Earth_Skill02_Door_Shadow", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, SkillPos, 0, Enemypos - SkillPos, 0, AimType.Default, BulletDirectionType.ActorToBullet, Distance(SkillPos, Enemypos), 0);
		yield return WaitTime(0.3);
		CircleMultipleShoot("Bullet_50181_ShunYiGuai_Earth_Skill02", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, SkillPos, 0, Enemypos - SkillPos, 0, AimType.Default, BulletDirectionType.ActorToBullet, Distance(SkillPos, Enemypos), 0);
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
