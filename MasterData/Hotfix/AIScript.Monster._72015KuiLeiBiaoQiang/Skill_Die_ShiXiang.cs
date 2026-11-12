using System.Collections;

namespace AIScript.Monster._72015KuiLeiBiaoQiang;

public class Skill_Die_ShiXiang : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		SendDeclareDeadEvent();
		SetHideModelEnable();
		BeginAttack(0, "ShiXiangDie", flushInputedKeys: true, forceInterruptAttack: true);
		PlayWwiseSound("amb_Ruin_stonebreak", _actor);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
