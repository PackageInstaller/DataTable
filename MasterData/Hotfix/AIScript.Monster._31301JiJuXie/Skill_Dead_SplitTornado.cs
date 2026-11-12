using System.Collections;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Dead_SplitTornado : SkillSimpleBase
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
		yield return WaitFrame(6);
		SetHideModelEnable();
	}
}
