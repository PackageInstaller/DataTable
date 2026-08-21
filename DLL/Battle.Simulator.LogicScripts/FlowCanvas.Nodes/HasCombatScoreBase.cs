using System.Collections.Generic;

namespace FlowCanvas.Nodes;

public class HasCombatScoreBase
{
	public static EnReturnHasOrNone HasCombatScore(SimContext simContext, int entityID, int sourceID, int enumIntValue)
	{
		if (!CommonProcessor.TryGetAliveRole(simContext, entityID, out var simEntity))
		{
			return EnReturnHasOrNone.Error;
		}
		if (!simEntity.hasEntityActionModifyCombatScore)
		{
			return EnReturnHasOrNone.None;
		}
		if (sourceID == 0 && enumIntValue == 0)
		{
			return EnReturnHasOrNone.Has;
		}
		List<ModifyCombatScoreInfo> mModifyInfoList = simEntity.entityActionModifyCombatScore.mModifyInfoList;
		for (int i = 0; i < mModifyInfoList.Count; i++)
		{
			ModifyCombatScoreInfo modifyCombatScoreInfo = mModifyInfoList[i];
			if (sourceID != 0 && enumIntValue != 0)
			{
				if (modifyCombatScoreInfo.mSourceID == sourceID && modifyCombatScoreInfo.mModifyTypeEnumValue == enumIntValue)
				{
					return EnReturnHasOrNone.Has;
				}
				continue;
			}
			if (sourceID != 0 && modifyCombatScoreInfo.mSourceID == sourceID)
			{
				return EnReturnHasOrNone.Has;
			}
			if (enumIntValue != 0 && modifyCombatScoreInfo.mModifyTypeEnumValue == enumIntValue)
			{
				return EnReturnHasOrNone.Has;
			}
		}
		return EnReturnHasOrNone.None;
	}
}
