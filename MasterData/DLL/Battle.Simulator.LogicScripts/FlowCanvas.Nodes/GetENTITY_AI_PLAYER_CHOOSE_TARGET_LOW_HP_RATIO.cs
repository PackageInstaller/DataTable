using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取玩家方选目标低血量系数(自动生成)", 0)]
[Category("Logic/Attribute/AutoGen")]
[Description("获取玩家方选目标低血量系数")]
public class GetENTITY_AI_PLAYER_CHOOSE_TARGET_LOW_HP_RATIO : PureFunctionNode<long, int>
{
	public override long Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		EntityVarName varName = EntityVarName.ENTITY_AI_PLAYER_CHOOSE_TARGET_LOW_HP_RATIO;
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, (int)varName, out var baseValue, out var _, out var _);
			return baseValue;
		}
		return 0L;
	}
}
