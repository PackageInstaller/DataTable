using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取黑板属性(pure)(枚举)", 0)]
[Category("Logic/Attribute")]
[Description("获取实体黑板属性,如果不存在的话,就加一个0(int)")]
public class GetEntityBlackboardAttributeByNamePure : PureFunctionNode<long, int, EntityVarName>
{
	public override long Invoke(int entityID, EntityVarName varName)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, (int)varName, out var baseValue, out var _, out var _);
			return baseValue;
		}
		return 0L;
	}
}
