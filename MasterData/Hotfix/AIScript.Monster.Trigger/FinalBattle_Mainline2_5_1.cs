using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster.Trigger;

public class FinalBattle_Mainline2_5_1 : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		List<LogicEntity> targetByDataID = GetTargetByDataID(1400507);
		List<LogicEntity> targetByDataID2 = GetTargetByDataID(1400508);
		List<LogicEntity> targetByDataID3 = GetTargetByDataID(1400509);
		List<LogicEntity> targetByDataID4 = GetTargetByDataID(1400510);
		List<LogicEntity> targetByDataID5 = GetTargetByDataID(1400511);
		List<LogicEntity> targetByDataID6 = GetTargetByDataID(1400512);
		List<LogicEntity> targetByDataID7 = GetTargetByDataID(1400505);
		List<LogicEntity> targetByDataID8 = GetTargetByDataID(1400514);
		List<LogicEntity> list = new List<LogicEntity>();
		list.AddRange(targetByDataID);
		list.AddRange(targetByDataID2);
		list.AddRange(targetByDataID3);
		list.AddRange(targetByDataID4);
		list.AddRange(targetByDataID5);
		list.AddRange(targetByDataID6);
		list.AddRange(targetByDataID7);
		list.AddRange(targetByDataID8);
		foreach (LogicEntity item in list)
		{
			SetLogicTagToggleValue(item, "BattleStart", value: true);
		}
		List<LogicEntity> list2 = new List<LogicEntity>();
		list2.AddRange(targetByDataID);
		list2.AddRange(targetByDataID2);
		foreach (LogicEntity item2 in list2)
		{
			SetLogicTagToggleValue(item2, "AIStart", value: true);
		}
		yield break;
	}
}
