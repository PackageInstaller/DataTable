using System.Collections;

namespace AIScript.Monster._70061WuYu.HorrorGhost;

public class Skill_Dead_TerrorGhost : SkillSimpleBase
{
	private const string DeadKey = "Death";

	private const int DeadIndex = 0;

	protected override IEnumerator DoMainLogic()
	{
		_actor.PlayDeathAnim();
		BeginAttack(0, "Death", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
