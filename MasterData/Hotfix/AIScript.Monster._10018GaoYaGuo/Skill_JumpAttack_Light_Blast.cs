using System.Collections;
using TrueSync;

namespace AIScript.Monster._10018GaoYaGuo;

public class Skill_JumpAttack_Light_Blast : SkillSimpleBase
{
	private LogicEntity Master;

	private TSVector2 Position;

	private long FX1;

	private long FX2;

	private long FX3;

	private long FX4;

	protected override void OnSkillEnable()
	{
		Master = GetMonsterCloner();
		Position = GetEntityPosition(Master);
		StartCor(CheckMaster());
	}

	protected override void OnSkillDisable()
	{
		StopEffect(FX1);
		StopEffect(FX2);
		StopEffect(FX3);
	}

	protected override IEnumerator DoMainLogic()
	{
		Skill_JumpAttack_Light_Blast skill_JumpAttack_Light_Blast = this;
		TSVector2 position = Position;
		FP radius = 2.75;
		DeterministicShape Attackshape = skill_JumpAttack_Light_Blast.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius);
		Skill_JumpAttack_Light_Blast skill_JumpAttack_Light_Blast2 = this;
		radius = 2;
		FP knockBackForce = 12;
		FP knockBackDistance = radius;
		FP hitStrenth = 3;
		HitFeatureData AttackFeature = skill_JumpAttack_Light_Blast2.GetHitFeatureData(HitBox.FeatureFlag.KnockBack, knockBackForce, knockBackDistance, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
		Skill_JumpAttack_Light_Blast skill_JumpAttack_Light_Blast3 = this;
		Skill_JumpAttack_Light_Blast skill_JumpAttack_Light_Blast4 = this;
		TSVector2 position2 = Position;
		skill_JumpAttack_Light_Blast3.FX1 = skill_JumpAttack_Light_Blast4.PlayEffect("ChargeLoopFX", 1f, default, position2);
		Skill_JumpAttack_Light_Blast skill_JumpAttack_Light_Blast5 = this;
		Skill_JumpAttack_Light_Blast skill_JumpAttack_Light_Blast6 = this;
		position2 = Position;
		skill_JumpAttack_Light_Blast5.FX2 = skill_JumpAttack_Light_Blast6.PlayEffect("ChargeWarningFX", 0.15f, default, position2, default, 1.1f);
		Skill_JumpAttack_Light_Blast skill_JumpAttack_Light_Blast7 = this;
		Skill_JumpAttack_Light_Blast skill_JumpAttack_Light_Blast8 = this;
		position2 = Position;
		skill_JumpAttack_Light_Blast7.FX3 = skill_JumpAttack_Light_Blast8.PlayEarlyWarningEffect("CommonWarningFX", 2f, default, position2, default, 0.9f);
		yield return WaitTime(2);
		Skill_JumpAttack_Light_Blast skill_JumpAttack_Light_Blast9 = this;
		Skill_JumpAttack_Light_Blast skill_JumpAttack_Light_Blast10 = this;
		position2 = Position;
		skill_JumpAttack_Light_Blast9.FX4 = skill_JumpAttack_Light_Blast10.PlayEffect("BlastFX", 1f, default, position2);
		StopEffect(FX1);
		StopEffect(FX2);
		AreaHit_Simple(Master, Attackshape, AttackFeature, 10018051, 0.1, HitBox.HurtAnimType.Small, "HittedFX");
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
