using System.Collections;
using TrueSync;

namespace AIScript.Monster._10020BanShenCao;

public class NormalAttack_2_5 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[1];

	private new static readonly FP WaitTime = 2;

	private TSVector2 AttackPosition;

	private FP AttackRotation;

	protected override IEnumerator DoMainLogic()
	{
		AttackPosition = GetPosition();
		AttackRotation = GetRotation();
		BeginAttack(1, Attack, flushInputedKeys: true);
		NormalAttack_2_5 normalAttack_2_ = this;
		TSVector2 attackPosition = AttackPosition;
		FP attackRotation = AttackRotation;
		long AttackFX = normalAttack_2_.PlayEffect("Attack_StartAndLoop", 1f, default, attackPosition, attackRotation);
		yield return WaitTime(WaitTime);
		StopEffect(AttackFX);
		NormalAttack_2_5 normalAttack_2_2 = this;
		attackPosition = AttackPosition;
		attackRotation = AttackRotation;
		normalAttack_2_2.PlayEffect("Attack_End", 1f, default, attackPosition, attackRotation);
		yield return WaitTime(0.25);
		NormalAttack_2_5 normalAttack_2_3 = this;
		TSVector2 attackPosition2 = AttackPosition;
		attackRotation = 1.7;
		FP innerRadius = 0;
		FP attackRotation2 = AttackRotation;
		DeterministicShape shapeData = normalAttack_2_3.GetShapeData(DeterministicShape.ShapeType.Circle, attackPosition2, default, default, attackRotation, innerRadius, default, attackRotation2);
		HitFeatureData hitFeatureData = GetHitFeatureData();
		AreaHit_Simple(_actor, shapeData, hitFeatureData, 1002001, 0.5, HitBox.HurtAnimType.Small, "HittedFX");
		yield return WaitTime(0.5);
	}
}
