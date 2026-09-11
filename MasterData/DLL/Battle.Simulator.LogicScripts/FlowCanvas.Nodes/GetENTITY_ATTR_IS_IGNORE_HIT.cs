using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取是否忽略命中(砍不到我)(自动生成)", 0)]
[Category("Logic/Attribute/AutoGen")]
[Description("获取是否忽略命中(砍不到我)")]
public class GetENTITY_ATTR_IS_IGNORE_HIT : PureFunctionNode<long, int>
{
	public override long Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		EntityVarName varName = EntityVarName.ENTITY_ATTR_IS_IGNORE_HIT;
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, (int)varName, out var baseValue, out var _, out var _);
			return baseValue;
		}
		return 0L;
	}
}
