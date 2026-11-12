using System.Collections;

namespace AIScript.Monster._31801FeiLong;

public class SkillScript_Death : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		if (_actor.logicVariable.GetLogicTagToggle("IsFlyState"))
		{
			BeginAttack(0, "Die_Fly", flushInputedKeys: true, forceInterruptAttack: true);
		}
		else
		{
			BeginAttack(0, "Die_Ground", flushInputedKeys: true, forceInterruptAttack: true);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
