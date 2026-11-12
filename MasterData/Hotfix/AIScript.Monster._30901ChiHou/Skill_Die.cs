using System.Collections;

namespace AIScript.Monster._30901ChiHou;

public class Skill_Die : SkillSimpleBase
{
	private readonly string Die = "Die";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		AddBuffToTarget(_actor, 990020140);
		SetBlockPriorityToStatic();
	}

	protected override IEnumerator DoMainLogic()
	{
		SendDeclareDeadEvent();
		BeginAttack(1, Die, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Disappear");
		SetHideModelEnable();
		SetCloseBlockEnable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(1);
	}
}
