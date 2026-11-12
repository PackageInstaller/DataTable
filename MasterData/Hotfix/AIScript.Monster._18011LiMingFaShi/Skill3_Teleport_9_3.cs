using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._18011LiMingFaShi;

public class Skill3_Teleport_9_3 : SkillSimpleBase
{
	private readonly string Skill3 = "Skill3_Teleport";

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Skill3, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Teleport_Start");
		SetHideModelEnable();
		SetUnparalleledEnable();
		SetCloseBlockEnable();
		yield return WaitTime(0.8);
		ClearActors(new List<LogicEntity> { _actor });
	}
}
