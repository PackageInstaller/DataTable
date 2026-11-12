using System.Collections;

namespace AIScript.Monster._10008ShaMoXie;

public class Skill_SPSpawn : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		SetBattleOutEnable();
		yield return WaitTime(4);
		SetBattleOutDisable();
	}
}
