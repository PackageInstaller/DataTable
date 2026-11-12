using System.Collections;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Dead_IceMaker : SkillSimpleBase
{
	private static readonly string Death = "Die";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		SetCloseBlockEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		SendDeclareDeadEvent();
		_actor.PlayDeathAnim();
		BeginAttack(1, Death, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.5);
		SetHideModelEnable();
	}
}
