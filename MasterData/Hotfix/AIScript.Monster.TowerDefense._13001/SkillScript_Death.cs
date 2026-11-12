using System.Collections;

namespace AIScript.Monster.TowerDefense._13001;

public class SkillScript_Death : SkillSimpleBase
{
	private int keyIndex1 = 1;

	private string key_Base = "Die1";

	private string key_P4 = "Die2";

	private int perkId_4 = 1300104;

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
		_actor.PlayDeathAnim();
		string actionKey = (GetPerk(perkId_4) ? key_P4 : key_Base);
		BeginAttack(keyIndex1, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		_skill?.Clear();
	}
}
