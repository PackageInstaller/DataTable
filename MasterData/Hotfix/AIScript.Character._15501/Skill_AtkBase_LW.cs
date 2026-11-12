using System.Collections;

namespace AIScript.Character._15501;

public class Skill_AtkBase_LW : SkillSimpleBase
{
	private const int perkId_1 = 515501;

	private int perkId_5 = 515505;

	protected virtual string keyP1 { get; }

	protected virtual string keyP5 { get; }

	protected virtual string keyP1_P5 { get; }

	protected virtual string keyBase { get; }

	protected override IEnumerator DoMainLogic()
	{
		_ = _actor.monsterTarget;
		string actionKey = keyBase;
		if (GetPerk(515501) && GetPerk(perkId_5))
		{
			actionKey = keyP1_P5;
		}
		else
		{
			if (GetPerk(515501))
			{
				actionKey = keyP1;
			}
			if (GetPerk(perkId_5))
			{
				actionKey = keyP5;
			}
		}
		BeginAttack(1, actionKey, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		_skill.Clear();
	}
}
