using System.Collections;

namespace AIScript.Monster._50801QiEBaoXiang;

public class Skill_Tool : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		SetHideModelEnable();
		SetBattleOutEnable();
		yield return WaitTime(99999);
	}
}
