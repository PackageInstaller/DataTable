using System.Collections;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_Die_ChongFengKuiLei_10_1 : SkillSimpleBase
{
	private static readonly string combo_Die = "Die_10_1";

	private static readonly string evt_Invisible = "Invisible";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		SetCloseBlockEnable();
		SendDeclareDeadEvent();
		_actor.PlayDeathAnim();
		BeginAttack(1, combo_Die);
		yield return WaitCustomEvent(evt_Invisible);
		SetHideModelEnable();
		yield return WaitTime(1.2);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
