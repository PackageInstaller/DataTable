using System.Collections;

namespace AIScript.Monster._15510FengNiao;

public class Skill_Spawn : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		SetLogicTagFpValue(_actor, "LightDistance", 6.5);
		SetLogicTagToggleValue(_actor, "IsMasterActive", value: false);
		GetAttackTarget(isUpToDate: true);
		SetBattleOutEnable();
		while (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) >= 11)
		{
			yield return null;
		}
		SetLogicTagToggleValue(_actor, "IsMasterActive", value: true);
		SetBattleOutDisable();
		ShowCenterHpBar();
	}
}
