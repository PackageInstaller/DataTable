using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取将要命中我的实体ID(自动生成)", 0)]
[Category("Logic/Attribute/AutoGen")]
[Description("获取将要命中我的实体ID")]
public class GetENTITY_AI_ENTITY_ID_TO_AVOID : PureFunctionNode<long, int>
{
	public override long Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		EntityVarName varName = EntityVarName.ENTITY_AI_ENTITY_ID_TO_AVOID;
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, (int)varName, out var baseValue, out var _, out var _);
			return baseValue;
		}
		return 0L;
	}
}
