using System.Collections;

namespace AIScript.Monster._50601JinDuanLiRong;

public class Skill_WanderActionHand : JinDuanLiRongSkillBase
{
	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(JinDuanLiRongSkillBase.warnderAction_Hand_Index, JinDuanLiRongSkillBase.warnderAction_Hand_Key, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
