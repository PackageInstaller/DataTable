using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取!实体配置ID(放在属性中)(自动生成)", 0)]
[Category("Logic/Attribute/AutoGen")]
[Description("获取!实体配置ID(放在属性中)")]
public class GetENTITY_CONFIG_ID_ON_ATTR : PureFunctionNode<long, int>
{
	public override long Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		EntityVarName varName = EntityVarName.ENTITY_CONFIG_ID_ON_ATTR;
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, (int)varName, out var baseValue, out var _, out var _);
			return baseValue;
		}
		return 0L;
	}
}
