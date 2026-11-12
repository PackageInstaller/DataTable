using System.Collections;
using TrueSync;

namespace AIScript.Monster._50141TaLu;

public class Skill_RayAttack_Light_Blast : SkillSimpleBase
{
	private static readonly int AttackDamage2 = 50141412;

	private LogicEntity Master;

	private TSVector2 Position;

	private long FX1;

	private long FX2;

	protected override IEnumerator DoMainLogic()
	{
		Master = GetMonsterCloner();
		Position = GetLogicTagTSVector2Value(Master, "AttackPosition");
		StartCor(CheckMaster());
		Skill_RayAttack_Light_Blast skill_RayAttack_Light_Blast = this;
		FP hitStrenth = 3;
		HitFeatureData attackData = skill_RayAttack_Light_Blast.GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
		yield return WaitTime(0.1);
		Skill_RayAttack_Light_Blast skill_RayAttack_Light_Blast2 = this;
		Skill_RayAttack_Light_Blast skill_RayAttack_Light_Blast3 = this;
		TSVector2 position = Position;
		skill_RayAttack_Light_Blast2.FX1 = skill_RayAttack_Light_Blast3.PlayEffect("LoopAttackGroundFX", 1f, default, position);
		Skill_RayAttack_Light_Blast skill_RayAttack_Light_Blast4 = this;
		Skill_RayAttack_Light_Blast skill_RayAttack_Light_Blast5 = this;
		position = Position;
		skill_RayAttack_Light_Blast4.FX2 = skill_RayAttack_Light_Blast5.PlayEarlyWarningEffect("LoopAttackGroundWarningFX", 1.5f, default, position, default, 1.4f);
		yield return WaitTime(1.5);
		Skill_RayAttack_Light_Blast skill_RayAttack_Light_Blast6 = this;
		position = Position;
		skill_RayAttack_Light_Blast6.PlayEffect("LoopAttackHitFX", 1f, default, position);
		Skill_RayAttack_Light_Blast skill_RayAttack_Light_Blast7 = this;
		TSVector2 position2 = Position;
		hitStrenth = 2.5;
		DeterministicShape shapeData = skill_RayAttack_Light_Blast7.GetShapeData(DeterministicShape.ShapeType.Circle, position2, default, default, hitStrenth);
		AreaHit_Simple(_actor, shapeData, attackData, AttackDamage2, 0.5, HitBox.HurtAnimType.Large, "HittedFX");
	}

	protected override void OnSkillDisable()
	{
		StopEffect(FX1);
		StopEffect(FX2);
	}

	private IEnumerator CheckMaster()
	{
		while (CheckTargetIsValid(Master))
		{
			yield return null;
		}
		InterruptSkill();
	}
}
