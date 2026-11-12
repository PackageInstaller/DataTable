using System.Collections;

namespace AIScript.Monster._12601111Hibiscus;

public class SkillScript_Spawn : SkillSimpleBase
{
	private const string actionTag = "Born_Skill";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableCloseBlock();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "Born_Skill", flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isRecoveryBegin);
	}
}
