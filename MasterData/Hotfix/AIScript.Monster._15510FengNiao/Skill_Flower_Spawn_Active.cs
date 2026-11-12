using System.Collections;

namespace AIScript.Monster._15510FengNiao;

public class Skill_Flower_Spawn_Active : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		SetImmuneControlEnable(autoDisableWhenSkillDisable: false);
		SetLockHpAbsEnable(isAbs: true, 1, autoDisableWhenSkillDisable: false);
		AddBuffToTarget(_actor, 155105320);
		yield break;
	}
}
