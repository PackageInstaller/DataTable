using System.Collections;

namespace AIScript.Character._16101.Summoned.FangWeiBiao;

public class SkillScript_FangWeiBiao_Attack : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key = "Sup_Attack";

	private string key_P24 = "Sup_Attack_P24";

	private const int perkId_24 = 516124;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(keyIndex, GetPerk(516124) ? key_P24 : key, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		_skill?.Clear();
	}
}
