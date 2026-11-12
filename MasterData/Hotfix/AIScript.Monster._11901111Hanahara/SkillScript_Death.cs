using System.Collections;

namespace AIScript.Monster._11901111Hanahara;

public class SkillScript_Death : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key = "Death";

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
		BeginAttack(keyIndex, key, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
