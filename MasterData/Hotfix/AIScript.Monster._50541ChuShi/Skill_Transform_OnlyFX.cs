using System.Collections;

namespace AIScript.Monster._50541ChuShi;

public class Skill_Transform_OnlyFX : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Transform = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.X };

	protected override IEnumerator DoMainLogic()
	{
		SetSuperArmorEnable();
		SetLockToughnessEnable();
		BeginAttack(1, Transform, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetSuperArmorDisable();
		SetLockToughnessDisable();
		yield return WaitTime(0.5);
	}
}
