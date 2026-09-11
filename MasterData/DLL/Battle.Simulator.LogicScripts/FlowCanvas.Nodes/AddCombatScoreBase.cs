using Config;

namespace FlowCanvas.Nodes;

public class AddCombatScoreBase
{
	public static bool AddCombatScore(SimContext simContext, int entityID, int addValue, int addType, int sourceID, EntityActionStatus entityActionStatus)
	{
		if (!CommonProcessor.TryGetAliveRole(simContext, entityID, out var simEntity))
		{
			return false;
		}
		if (addValue > 0)
		{
			long finalAttributeByAttributeID = AttributeProcessor.GetFinalAttributeByAttributeID(simEntity.entityBlackboard.var.mAttributeID, 1106, AttributeCalcType.AddMul);
			addValue = addValue * (int)finalAttributeByAttributeID / 1000;
		}
		ModifyCombatScoreInfo item = new ModifyCombatScoreInfo
		{
			mModifyTypeEnumValue = addType,
			mSourceID = sourceID,
			mAddValue = addValue,
			mState = entityActionStatus
		};
		if (!simEntity.hasEntityActionModifyCombatScore)
		{
			simEntity.AddEntityActionModifyCombatScore(EntityActionStatus.E_ACTIVE, FrameListPool<ModifyCombatScoreInfo>.Claim());
		}
		simEntity.entityActionModifyCombatScore.mStatus = EntityActionStatus.E_ACTIVE;
		simEntity.entityActionModifyCombatScore.mModifyInfoList.Add(item);
		return true;
	}
}
