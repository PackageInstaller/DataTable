using System.Collections;

namespace AIScript.BrickBreaker._15701;

public class Skill : SkillSimpleBase
{
	private readonly string combo_key = "Skill";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, combo_key, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	public void OnUpdate()
	{
	}

	protected override void OnCustomEvent(int comboIndex, string evt)
	{
	}
}
