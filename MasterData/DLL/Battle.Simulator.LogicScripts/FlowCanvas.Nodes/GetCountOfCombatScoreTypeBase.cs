using System.Collections.Generic;

namespace FlowCanvas.Nodes;

public class GetCountOfCombatScoreTypeBase
{
	public static bool GetCountOfCombatScoreType(SimContext simContext, int entityID, out int count, int enumValue)
	{
		count = 0;
		if (!CommonProcessor.TryGetAliveRole(simContext, entityID, out var simEntity))
		{
			return false;
		}
		if (!simEntity.hasEntityActionModifyCombatScore)
		{
			return true;
		}
		List<ModifyCombatScoreInfo> mModifyInfoList = simEntity.entityActionModifyCombatScore.mModifyInfoList;
		if (enumValue == 0)
		{
			count = mModifyInfoList.Count;
			return true;
		}
		for (int i = 0; i < mModifyInfoList.Count; i++)
		{
			if (mModifyInfoList[i].mModifyTypeEnumValue == enumValue)
			{
				count++;
			}
		}
		return true;
	}
}
