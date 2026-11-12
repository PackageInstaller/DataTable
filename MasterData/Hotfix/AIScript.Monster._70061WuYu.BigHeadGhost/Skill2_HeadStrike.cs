using System.Collections;
using TrueSync;

namespace AIScript.Monster._70061WuYu.BigHeadGhost;

public class Skill2_HeadStrike : SkillSimpleBase
{
	private const string ComboKey = "Skill2_HeadStrike";

	private static readonly FP LookAtDuration = 0.4;

	private static readonly FP LookAtRotateSpeed = 160;

	private const string LoopFxAlias = "fx_m70061_loop_BigHeadGhost_Attack02";

	private const string BaseFxAlias = "fx_m70061_base_BigHeadGhost_Attack02";

	private static readonly FP LoopStartDelay = 0.1;

	private static readonly FP BaseAdvanceTime = 0.2;

	private static readonly FP ChargeTime = 1;

	private long _loopFxId;

	protected override IEnumerator DoMainLogic()
	{
		SetBlockPriorityToStatic();
		LogicEntity attackTarget = GetAttackTarget();
		BeginAttack(0, "Skill2_HeadStrike", flushInputedKeys: true, forceInterruptAttack: true);
		if (attackTarget != null)
		{
			BeginLookAt_NotWait(attackTarget, LookAtDuration, LookAtRotateSpeed);
		}
		yield return WaitTime(LoopStartDelay);
		Skill2_HeadStrike skill2_HeadStrike = this;
		Skill2_HeadStrike skill2_HeadStrike2 = this;
		TSVector2 position = GetPosition();
		skill2_HeadStrike._loopFxId = skill2_HeadStrike2.PlayEffect("fx_m70061_loop_BigHeadGhost_Attack02", 1f, default, position);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(ChargeTime - BaseAdvanceTime);
		Skill2_HeadStrike skill2_HeadStrike3 = this;
		position = GetPosition();
		skill2_HeadStrike3.PlayEffect("fx_m70061_base_BigHeadGhost_Attack02", 1f, default, position);
		yield return WaitTime(BaseAdvanceTime);
		StopEffect(_loopFxId);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
