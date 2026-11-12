using System.Collections;
using TrueSync;

namespace AIScript.Monster._10005JiaMianYeZhu;

public class Skill_Spawn_Hardcore : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] Spawn_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };

	protected override IEnumerator DoMainLogic()
	{
		SetBattleOutEnable();
		SetHideModelEnable();
		Skill_Spawn_Hardcore skill_Spawn_Hardcore = this;
		TSVector2 position = GetPosition();
		skill_Spawn_Hardcore.PlayEffect("fx_common_base_monster_in_ground", 1f, default, position);
		yield return WaitTime(0.15);
		Skill_Spawn_Hardcore skill_Spawn_Hardcore2 = this;
		position = GetPosition();
		skill_Spawn_Hardcore2.PlayEffect("fx_common_base_monster_in", 1f, default, position);
		SetHideModelDisable();
		yield return WaitTime(0.5);
		BeginAttack(1, Spawn_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		ShowCenterHpBar();
		SetBattleOutDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
