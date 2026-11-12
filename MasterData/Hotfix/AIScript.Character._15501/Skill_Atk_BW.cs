using System.Collections;

namespace AIScript.Character._15501;

public class Skill_Atk_BW : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key_Base = "15501_White_Main_Shoot";

	private string key_P2 = "15501_White_Main_Shoot_Strengthen";

	private string key_P2_2 = "15501_White_Main_Shoot_P02";

	private const int perkId_2 = 515502;

	protected override IEnumerator DoMainLogic()
	{
		_ = _actor.attackTarget;
		string actionKey = key_Base;
		if (GetPerk(515502))
		{
			if (_actor.logicVariable.GetLogicTagToggle("firstSkill"))
			{
				actionKey = key_P2;
				_actor.logicVariable.ToggleLogicTag("firstSkill", value: false);
			}
			else
			{
				actionKey = key_P2_2;
			}
		}
		BeginAttack(keyIndex, actionKey, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		_skill.Clear();
	}
}
