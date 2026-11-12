using System.Collections;

namespace AIScript.Monster._15510FengNiao;

public class Skill_Flower_Spawn_Deactive : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		SetImmuneControlEnable(autoDisableWhenSkillDisable: false);
		SetLockHpAbsEnable(isAbs: true, 1, autoDisableWhenSkillDisable: false);
		SetBattleOutEnable(autoDisableWhenSkillDisable: false);
		DirectDamage(_actor, (int)_actor.actorHealthInfo.hpMax, null, showHud: false);
		ReplaceAnimationGroup(1);
		yield break;
	}
}
