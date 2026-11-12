using System.Collections;

namespace AIScript.Monster._10501BanShenShu;

public class Skill_CallMonster_SP : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		UseMonsterCloneActorCastSkill(1050101);
		yield return null;
	}
}
