using System.Collections;

namespace AIScript.BrickBreaker._11101;

public class Skill_Attack : SkillSimpleBase
{
	private string combo_key = "Skill_Base";

	private string combo_key2 = "B1P03_Skill_S2";

	private string combo_key3 = "B1P01_Skill";

	protected readonly ComboInputBuffer.ActionKey[] actionKey_1 = new ComboInputBuffer.ActionKey[3];

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
		BeginAttack(3, combo_key2);
		yield return WaitTime(3);
		CancelAttack();
		yield return WaitTime(0.1);
		BeginAttack(4, combo_key3, flushInputedKeys: false, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}

	private void OnInterrupt()
	{
		_skill?.Clear();
	}

	public void OnUpdate()
	{
	}

	private void onCustomEvent(string evt)
	{
	}
}
