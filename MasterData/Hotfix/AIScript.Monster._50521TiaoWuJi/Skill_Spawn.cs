using System.Collections;

namespace AIScript.Monster._50521TiaoWuJi;

public class Skill_Spawn : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
		SetBattleOutEnable();
	}

	protected override void OnSkillDisable()
	{
		ShowCenterHpBar();
	}

	protected override IEnumerator DoMainLogic()
	{
		while (Distance(GetPosition(), GetEntityPositionObsoleted(GetCurrentPlayer())) > 15)
		{
			yield return WaitTime(0.5);
		}
	}
}
