using System.Collections;

namespace AIScript.Monster._31801FeiLong;

public class SkillScript_Fly : SkillScript_Base
{
	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(0, "Fly_Start");
		ReplaceAnimationGroup();
		_actor.logicVariable.ToggleLogicTag("IsFlyState", value: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
