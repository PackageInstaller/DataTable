using System.Collections;

namespace AIScript.Monster._13021XiaoMan;

public class Skill_Spawn_With3 : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] Spawn_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey._1 };

	protected override IEnumerator DoMainLogic()
	{
		SetBattleOutEnable();
		ShowCenterHpBar();
		BeginAttack(1, Spawn_Combo);
		yield return WaitCustomEvent("Start");
		SetBattleOutDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
