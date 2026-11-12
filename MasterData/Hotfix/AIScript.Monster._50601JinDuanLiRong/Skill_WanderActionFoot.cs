using System.Collections;

namespace AIScript.Monster._50601JinDuanLiRong;

public class Skill_WanderActionFoot : JinDuanLiRongSkillBase
{
	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(JinDuanLiRongSkillBase.warnderAction_Foot_Index, JinDuanLiRongSkillBase.warnderAction_Foot_Key, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
