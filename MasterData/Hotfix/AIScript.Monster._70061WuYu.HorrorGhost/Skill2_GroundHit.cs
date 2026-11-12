using System.Collections;
using TrueSync;

namespace AIScript.Monster._70061WuYu.HorrorGhost;

public class Skill2_GroundHit : SkillSimpleBase
{
	private const string ComboKey = "Skill2_GroundHit";

	private const string EndFxAlias = "fx_m70061_base_BigHeadGhost_Attack02_01";

	private static readonly FP ChargeTime = 1;

	private static readonly FP FxAdvanceTime = 0.1;

	private static readonly FP LookAtDuration = 0.5;

	private static readonly FP LookAtRotateSpeed = 360;

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		if (logicEntity != null)
		{
			BeginLookAt_NotWait(logicEntity, LookAtDuration, LookAtRotateSpeed);
		}
		BeginAttack(0, "Skill2_GroundHit", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(ChargeTime - FxAdvanceTime);
		Skill2_GroundHit skill2_GroundHit = this;
		TSVector2 position = GetPosition();
		skill2_GroundHit.PlayEffect("fx_m70061_base_BigHeadGhost_Attack02_01", 1f, default, position);
		yield return WaitTime(FxAdvanceTime);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
