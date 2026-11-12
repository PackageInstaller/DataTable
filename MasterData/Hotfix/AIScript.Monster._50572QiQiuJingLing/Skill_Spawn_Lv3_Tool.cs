using System.Collections;

namespace AIScript.Monster._50572QiQiuJingLing;

public class Skill_Spawn_Lv3_Tool : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Spawn_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey._1 };

	protected override IEnumerator DoMainLogic()
	{
		SetLogicTagFpValue(_actor, "VolumeLevel", 1);
		SetLogicTagFpValue(_actor, "SkillMode", 2);
		SetLogicTagFpValue(_actor, "Difficulty", 3);
		SetHideModelEnable();
		SetBattleOutEnable();
		BeginAttack(1, Spawn_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		SetHideModelDisable();
		yield return WaitCustomEvent("BattleStart");
		SetBattleOutDisable();
		AddShieldToTarget(_actor, 507042210);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
