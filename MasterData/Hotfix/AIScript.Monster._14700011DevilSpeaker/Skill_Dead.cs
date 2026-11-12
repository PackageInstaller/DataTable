using System.Collections;

namespace AIScript.Monster._14700011DevilSpeaker;

public class Skill_Dead : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key = "Death";

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		_actor.PlayDeathAnim();
		BeginAttack(keyIndex, key, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
