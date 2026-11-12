using System.Collections;

namespace AIScript.Monster._50531DaGuanZi;

public class Skill_Spawn : SkillSimpleBase
{
	protected override void OnSkillDisable()
	{
		ShowCenterHpBar();
	}

	protected override IEnumerator DoMainLogic()
	{
		SetBattleOutEnable();
		GetAttackTarget(isUpToDate: true);
		while (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) >= 10)
		{
			yield return null;
		}
		SetBattleOutDisable();
	}
}
