using System.Collections;

namespace AIScript.Monster._30282ShengDanLiWuJi;

public class Skill_Spawn : SkillSimpleBase
{
	private string Attack1 = "Born";

	protected override void OnSkillEnable()
	{
		SetHideModelEnable(autoDisableWhenSkillDisable: false);
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetSearchedImmunityEnable(autoDisableWhenSkillDisable: false);
		SetBlockPriorityToStatic(autoDisableWhenSkillDisable: false);
		SetBattleOutEnable();
		SetCloseBlockEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		PlayEffect("Spawn_boom", 1f, default, GetPosition());
		yield return WaitTime(0.6);
		SetHideModelDisable();
		BeginAttack(1, Attack1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Down");
		SetCloseBlockDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
