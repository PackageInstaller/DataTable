using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster.Trigger;

public class FinalBattle_Mainline2_5_2 : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		List<LogicEntity> targetByDataID = GetTargetByDataID(1400509);
		List<LogicEntity> targetByDataID2 = GetTargetByDataID(1400510);
		List<LogicEntity> list = new List<LogicEntity>();
		list.AddRange(targetByDataID);
		list.AddRange(targetByDataID2);
		foreach (LogicEntity item in list)
		{
			SetLogicTagToggleValue(item, "AIStart", value: true);
		}
		yield break;
	}
}
