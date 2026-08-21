using Config;

namespace FlowCanvas.Nodes;

public class SummonedUnitHelper
{
	public static SimEntity CreateSummonedUnit(SimContext simContext, int creatorID, Int3 position, Int3 forward, RoleType camp, int roleID, int hpStripCount, int aiID = 0, int skinID = 0)
	{
		ConfigHelper.GetInstance().GetConfig<RoleConfig>(roleID);
		SimEntity simEntity = SpawnProcessor.SpawnUnit(0L, position, forward, new Int3(0, 1, 0), camp, (aiID == 0) ? roleID : aiID, isLocalPlayer: false, roleID, 0, MemberPosition.None, 1000, 8000, hpStripCount, null, null, skinID);
		simEntity.entityBlackboard.var.creator = creatorID;
		simEntity.entityBlackboard.var.mRobotType = RobotType.SummonedUnit;
		CopyAttributeToSummonedUnit(simContext, creatorID, simEntity.creationIndex);
		charactor_param config = ConfigHelper.GetInstance().GetConfig<charactor_param>(roleID);
		AttributeProcessor.SetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2201, config.BestDistance, 0L, 0L);
		AttributeProcessor.SetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2202, config.ApproachDistance, 0L, 0L);
		return simEntity;
	}

	public static void CopyAttributeToSummonedUnit(SimContext simContext, int srcEntityID, int dstEntityID)
	{
		SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(srcEntityID);
		SimEntity entityWithEntityID2 = simContext.GetEntityWithEntityID(dstEntityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			long mMaxHP = entityWithEntityID.entityBlackboard.var.mMaxHP;
			mMaxHP = ((mMaxHP < 1) ? 1 : mMaxHP);
			long mHP = entityWithEntityID.entityBlackboard.var.mHP;
			mHP = ((mHP < 1) ? 1 : mHP);
			entityWithEntityID2.entityBlackboard.var.mMaxHP = mMaxHP;
			entityWithEntityID2.entityBlackboard.var.mHP = mHP;
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 1, out var baseValue, out var plusValue, out var tempPlusValue);
			AttributeProcessor.SetAttributeWithIntName(entityWithEntityID2.entityBlackboard.var.mAttributeID, 1, baseValue, plusValue, tempPlusValue);
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2, out baseValue, out plusValue, out tempPlusValue);
			AttributeProcessor.SetAttributeWithIntName(entityWithEntityID2.entityBlackboard.var.mAttributeID, 2, baseValue, plusValue, tempPlusValue);
		}
	}
}
