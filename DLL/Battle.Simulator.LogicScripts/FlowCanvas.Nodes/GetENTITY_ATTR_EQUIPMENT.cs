using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取装备(自动生成)", 0)]
[Category("Logic/Attribute/AutoGen")]
[Description("获取装备")]
public class GetENTITY_ATTR_EQUIPMENT : PureFunctionNode<long, int>
{
	public override long Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		EntityVarName varName = EntityVarName.ENTITY_ATTR_EQUIPMENT;
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, (int)varName, out var baseValue, out var _, out var _);
			return baseValue;
		}
		return 0L;
	}
}
