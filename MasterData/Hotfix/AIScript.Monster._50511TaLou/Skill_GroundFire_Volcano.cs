using System.Collections;
using TrueSync;

namespace AIScript.Monster._50511TaLou;

public class Skill_GroundFire_Volcano : SkillSimpleBase
{
	private static readonly FP BulletAmount = 5;

	private long LoopFXID;

	private long LoopFXID2;

	private long BullerCount;

	private TSVector2 AttackPosition;

	protected override void OnSkillEnable()
	{
		BullerCount = 0L;
	}

	protected override void OnSkillDisable()
	{
		StopEffect(LoopFXID);
		StopEffect(LoopFXID2);
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(1);
		AttackPosition = GetLogicTagTSVector2Value(GetMonsterCloner(), "GroundFire_Plus_Position");
		Skill_GroundFire_Volcano skill_GroundFire_Volcano = this;
		TSVector2 attackPosition = AttackPosition;
		skill_GroundFire_Volcano.PlayEffect("Attack_L_Start", 1f, default, attackPosition);
		yield return WaitTime(0.5);
		Skill_GroundFire_Volcano skill_GroundFire_Volcano2 = this;
		Skill_GroundFire_Volcano skill_GroundFire_Volcano3 = this;
		attackPosition = AttackPosition;
		skill_GroundFire_Volcano2.LoopFXID = skill_GroundFire_Volcano3.PlayEffect("Attack_L_Loop", 1f, default, attackPosition);
		Skill_GroundFire_Volcano skill_GroundFire_Volcano4 = this;
		Skill_GroundFire_Volcano skill_GroundFire_Volcano5 = this;
		attackPosition = AttackPosition;
		skill_GroundFire_Volcano4.LoopFXID2 = skill_GroundFire_Volcano5.PlayEffect("VolcanoArea", 1f, default, attackPosition);
		yield return StartCor(VolcanoShoot());
		yield return WaitTime(1);
		StopEffect(LoopFXID);
		StopEffect(LoopFXID2);
		Skill_GroundFire_Volcano skill_GroundFire_Volcano6 = this;
		attackPosition = AttackPosition;
		skill_GroundFire_Volcano6.PlayEffect("Attack_L_End", 1f, default, attackPosition);
		yield return WaitTime(0.6);
		Skill_GroundFire_Volcano skill_GroundFire_Volcano7 = this;
		AdventureActor monsterCloner = GetMonsterCloner();
		Skill_GroundFire_Volcano skill_GroundFire_Volcano8 = this;
		TSVector2 attackPosition2 = AttackPosition;
		FP radius = 2;
		skill_GroundFire_Volcano7.AreaHit_Simple(monsterCloner, skill_GroundFire_Volcano8.GetShapeData(DeterministicShape.ShapeType.Circle, attackPosition2, default, default, radius), GetHitFeatureData(), 50511132, 0.5, HitBox.HurtAnimType.Large, "HittedFX_Magic");
		yield return WaitTime(1.4);
	}

	private IEnumerator VolcanoShoot()
	{
		while (BullerCount < BulletAmount)
		{
			FP randomValue = GetRandomValue(0, 360);
			Skill_GroundFire_Volcano skill_GroundFire_Volcano = this;
			TSVector2 attackPosition = AttackPosition;
			FP radius = 5;
			FP innerRadius = 3;
			FP angle = 360 / BulletAmount;
			FP rotation = randomValue;
			DeterministicShape shapeData = skill_GroundFire_Volcano.GetShapeData(DeterministicShape.ShapeType.Fan, attackPosition, default, default, radius, innerRadius, angle, rotation);
			TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, GetCurrentPlayer(), isReachable: true);
			FanMultipleShoot("Mine_Throw_Volcano", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, AttackPosition, 0, RotateTo(GetForward(), randomValue), 0, AimType.Position, BulletDirectionType.BulletToTarget, 15, 0, 0, shapeRandomPoint);
			BullerCount++;
			yield return WaitTime(GetRandomValue(0.5, 1));
		}
	}
}
