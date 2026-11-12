using System.Collections;

namespace AIScript.Monster._15510FengNiao;

public class Skill_TransformTo2 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Transform_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey._1 };

	protected override IEnumerator DoMainLogic()
	{
		SetSuperArmorEnable();
		SetLockToughnessEnable();
		BeginAttack(1, Transform_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("AddBuff");
		AddBuffToTarget(_actor, 155109320);
		AddBuffToTarget(_actor, 155109350);
		SetSuperArmorDisable();
		SetLockToughnessDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(1);
	}
}
