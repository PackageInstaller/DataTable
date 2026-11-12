using System.Collections;

namespace AIScript.Monster._31801FeiLong;

public class SkillScript_ToughnessBrokenByFly : SkillScript_Base
{
	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(0, "Idle");
		_actor.ResumeAnimationGroup();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
