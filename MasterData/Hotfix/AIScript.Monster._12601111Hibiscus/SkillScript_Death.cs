using System.Collections;

namespace AIScript.Monster._12601111Hibiscus;

public class SkillScript_Death : SkillSimpleBase
{
	private const string actionTag = "Die";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.PauseMovementAgent();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.EnableMovementAgent();
	}

	protected override IEnumerator DoMainLogic()
	{
		_actor.PlayDeathAnim();
		BeginAttack(1, "Die", flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
