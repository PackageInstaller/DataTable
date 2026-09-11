using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取AI的最佳距离(自动生成)", 0)]
[Category("Logic/Attribute/AutoGen")]
[Description("获取AI的最佳距离")]
public class GetENTITY_AI_BEST_DISTANCE : PureFunctionNode<long, int>
{
	public override long Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		EntityVarName varName = EntityVarName.ENTITY_AI_BEST_DISTANCE;
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, (int)varName, out var baseValue, out var _, out var _);
			return baseValue;
		}
		return 0L;
	}
}
