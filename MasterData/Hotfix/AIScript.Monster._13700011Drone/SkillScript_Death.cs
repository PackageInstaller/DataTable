using System.Collections;

namespace AIScript.Monster._13700011Drone;

public class SkillScript_Death : SkillSimpleBase
{
	public const int keyIndex = 1;

	public const string key = "Dead";

	protected override IEnumerator DoMainLogic()
	{
		_actor.PlayDeathAnim();
		BeginAttack(1, "Dead", flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
