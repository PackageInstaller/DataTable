using System.Collections;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Dead_OctopusBattery : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		SetCloseBlockEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		SendDeclareDeadEvent();
		_actor.PlayDeathAnim();
		BeginAttack(1, "Death", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetHideModelEnable();
	}
}
