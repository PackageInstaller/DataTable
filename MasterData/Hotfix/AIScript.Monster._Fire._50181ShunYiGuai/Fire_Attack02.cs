using System.Collections;
using TrueSync;

namespace AIScript.Monster._Fire._50181ShunYiGuai;

public class Fire_Attack02 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack02 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		BeginAttack(1, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(Targetenemy, 2, 240);
		yield return WaitCustomEvent("ChargeEnd");
		CancelAttack();
		StopLookAt();
		yield return WaitCustomEvent("Door");
		if (GetBuffNum(_actor, 501810003) >= 1)
		{
			UseMonsterCloneActorCastSkill(5018114);
		}
		else
		{
			StartCor(BombAttack());
		}
		yield return WaitCustomEvent("TurnS");
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 1.5, 200);
		yield return WaitCustomEvent("TurnE");
		StopLookAt();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator BombAttack()
	{
		GetEnemy();
		TSVector2 Enemypos = GetEntityPosition(Targetenemy);
		Fire_Attack02 fire_Attack = this;
		FP radius = 4;
		FP innerRadius = 3;
		DeterministicShape shapeData = fire_Attack.GetShapeData(DeterministicShape.ShapeType.Circle, Enemypos, default, default, radius, innerRadius);
		TSVector2 SkillPos = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		int num = 0;
		while (Distance(SkillPos, new TSVector2(0, 0)) > 14 && num < 50)
		{
			SkillPos = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			num++;
		}
		PlayAreaEffect("Area_50181_ShunYiGuai_Fire_Skill02_Door_S", SkillPos);
		CircleMultipleShoot("Bullet_50181_ShunYiGuai_Fire_Skill02_Door_Shadow", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, SkillPos, 0, Enemypos - SkillPos, 0, AimType.Default, BulletDirectionType.ActorToBullet, Distance(SkillPos, Enemypos), 0);
		yield return WaitTime(0.3);
		CircleMultipleShoot("Bullet_50181_ShunYiGuai_Fire_Skill02", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, SkillPos, 0, Enemypos - SkillPos, 0, AimType.Default, BulletDirectionType.ActorToBullet, Distance(SkillPos, Enemypos), 0);
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
