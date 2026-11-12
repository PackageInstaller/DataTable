using System.Collections;
using TrueSync;

namespace AIScript.Monster._50572QiQiuJingLing;

public class Skill_Spawn_Lv3 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Spawn_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey._1 };

	protected override IEnumerator DoMainLogic()
	{
		SetLogicTagFpValue(_actor, "VolumeLevel", 1);
		SetLogicTagFpValue(_actor, "SkillMode", 2);
		SetLogicTagFpValue(_actor, "Difficulty", 3);
		Skill_Spawn_Lv3 skill_Spawn_Lv = this;
		TSVector2 position = GetPosition();
		skill_Spawn_Lv.PlayEarlyWarningEffect("SpawnWarning", 1f, default, position, default, 0.5f);
		SetHideModelEnable();
		SetBattleOutEnable();
		yield return WaitTime(0.5);
		BeginAttack(1, Spawn_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		SetHideModelDisable();
		yield return WaitCustomEvent("BattleStart");
		SetBattleOutDisable();
		AddShieldToTarget(_actor, 507042210);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
