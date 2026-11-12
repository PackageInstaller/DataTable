using System.Collections;
using TrueSync;

namespace AIScript.Monster._50572QiQiuJingLing;

public class Skill_Spawn_Zizouqi : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Spawn_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey._1 };

	protected override IEnumerator DoMainLogic()
	{
		Skill_Spawn_Zizouqi skill_Spawn_Zizouqi = this;
		TSVector2 position = GetPosition();
		skill_Spawn_Zizouqi.PlayEarlyWarningEffect("SpawnWarning", 1f, default, position, default, 0.5f);
		SetHideModelEnable();
		SetBattleOutEnable();
		yield return WaitTime(0.5);
		BeginAttack(1, Spawn_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		SetHideModelDisable();
		yield return WaitCustomEvent("BattleStart");
		SetBattleOutDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
