using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Earth._50311DaWuGui;

public class Earth_Attack07_Summon : SkillSimpleBase
{
	private FP HomeDistance;

	protected override void OnSkillEnable()
	{
		SetHideModelEnable();
		SetUnparalleledEnable();
		SetSearchedImmunityEnable();
		SetCloseBlockEnable();
		SetHideOutEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetTargetByTeammateIndex(0).get_Item(0);
		if (GetBuffNum(target, 503110002) >= 1)
		{
			PlayAreaEffect("Area_50311_DaWuGui_Skill07_01");
			yield return WaitTime(1);
			PlayAreaEffect("Area_50311_DaWuGui_Skill07_02");
			yield return WaitTime(1);
			PlayAreaEffect("Area_50311_DaWuGui_Skill07_03");
		}
		else
		{
			PlayAreaEffect("Area_50311_DaWuGui_Skill07_01");
			yield return WaitTime(1);
			PlayAreaEffect("Area_50311_DaWuGui_Skill07_04");
			yield return WaitTime(2);
			PlayAreaEffect("Area_50311_DaWuGui_Skill07_05");
		}
		yield return WaitTime(2);
		ClearActors(new List<LogicEntity> { _actor });
	}
}
