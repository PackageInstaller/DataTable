using System.Collections;
using TrueSync;

namespace AIScript.Monster._70061WuYu;

public class Skill8_BroomAttack : SkillSimpleBase
{
	private const string ComboKey = "Skill8_1_BroomAttack";

	private const string ComboKeyPhase3 = "Skill8_2_BroomAttack";

	private const string SummonBroomEvent = "SummonBroom";

	private const string AreaEffect1 = "AreaEffect_70061WuYu_Skill8_BroomAttack_1_1";

	private const string AreaEffect2 = "AreaEffect_70061WuYu_Skill8_BroomAttack_2";

	private static readonly FP AreaEffectInterval = 1.5;

	private static readonly FP DistanceThreshold = 6;

	private static readonly TSVector2 FarAreaOffset = new TSVector2(0, 1.25);

	private static readonly TSVector2 NearAreaOffset = new TSVector2(0, -1.25);

	private static readonly FP TurnToTargetDuration = 0.3;

	private static readonly FP TurnToTargetSpeed = 180;

	protected override IEnumerator DoMainLogic()
	{
		if (GetLogicTagFpValue(_actor, "Phase").AsInt() >= 3)
		{
			BeginAttack(0, "Skill8_2_BroomAttack", flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("SummonBroom");
			TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
			PlayAreaEffect("AreaEffect_70061WuYu_Skill8_BroomAttack_1_1", entityPosition, FP.Zero);
			yield return WaitTime(AreaEffectInterval);
			entityPosition = GetEntityPosition(GetCurrentPlayer());
			TSVector2 tSVector = GetEntityPosition(_actor) - entityPosition;
			TSVector2 normalized = tSVector.normalized;
			TSVector2 tSVector2 = TSVector2.Rotate(normalized, 90f);
			TSVector2 tSVector3 = ((tSVector.LengthSquared() > DistanceThreshold * DistanceThreshold) ? FarAreaOffset : NearAreaOffset);
			TSVector2 tSVector4 = entityPosition + normalized * tSVector3.y + tSVector2 * tSVector3.x;
			FP angle = (entityPosition - tSVector4).normalized.GetAngle();
			PlayAreaEffect("AreaEffect_70061WuYu_Skill8_BroomAttack_2", tSVector4, angle);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			LogicEntity attackTarget = GetAttackTarget(isUpToDate: true);
			if (CheckTargetIsValid(attackTarget))
			{
				yield return BeginLookAt(attackTarget, TurnToTargetDuration, TurnToTargetSpeed);
			}
			BeginAttack(0, "Skill8_1_BroomAttack", flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}
}
