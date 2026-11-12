using System.Collections;

namespace AIScript.Monster._13031XinYue;

public class Skill_Spawn : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Spawn_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey._1 };

	protected override IEnumerator DoMainLogic()
	{
		SetBattleOutEnable();
		BeginAttack(1, Spawn_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Battle");
		ShowCenterHpBar();
		SetBattleOutDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
