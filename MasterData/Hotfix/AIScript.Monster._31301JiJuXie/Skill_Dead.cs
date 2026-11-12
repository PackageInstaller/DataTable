using System.Collections;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Dead : SkillSimpleBase
{
	private static readonly string combo_Die = "Die";

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
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
