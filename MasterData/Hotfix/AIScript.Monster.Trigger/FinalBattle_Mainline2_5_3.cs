using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster.Trigger;

public class FinalBattle_Mainline2_5_3 : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		List<LogicEntity> targetByDataID = GetTargetByDataID(1400511);
		List<LogicEntity> targetByDataID2 = GetTargetByDataID(1400512);
		List<LogicEntity> targetByDataID3 = GetTargetByDataID(1400505);
		List<LogicEntity> targetByDataID4 = GetTargetByDataID(1400514);
		List<LogicEntity> list = new List<LogicEntity>();
		list.AddRange(targetByDataID);
		list.AddRange(targetByDataID2);
		list.AddRange(targetByDataID3);
		list.AddRange(targetByDataID4);
		foreach (LogicEntity item in list)
		{
			SetLogicTagToggleValue(item, "AIStart", value: true);
		}
		yield break;
	}
}
