using System.Collections;
using TrueSync;

namespace AIScript.Monster._70061WuYu.HorrorGhost;

public class Skill_GroundHit_GiantGhost : SkillSimpleBase
{
	private const string ComboKey = "Skill2_GroundHit_Giant";

	private const string ComboKey_Fast = "Skill2_GroundHit_Giant_Fast";

	private static readonly FP ChargeTime_Short = 0.2;

	private static readonly FP ChargeTime = 0.5;

	private static readonly FP SelfDestructDelay = 0.6;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(0, "Skill2_GroundHit_Giant_Fast", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(ChargeTime_Short);
		CancelAttack();
		yield return WaitTime(1.1);
		BeginLookAtByDir_NotWait(TSVector2.left, 0.4, 1200);
		BeginAttack(1, "Skill2_GroundHit_Giant_Fast", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(ChargeTime_Short);
		CancelAttack();
		yield return WaitTime(1.1);
		BeginLookAtByDir_NotWait(TSVector2.right, 0.8, 1200);
		BeginAttack(2, "Skill2_GroundHit_Giant", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(ChargeTime);
		CancelAttack();
		yield return WaitCustomEvent("DeathFX");
		yield return WaitTime(SelfDestructDelay);
		_actor.ClearMonsterSelf();
	}
}
