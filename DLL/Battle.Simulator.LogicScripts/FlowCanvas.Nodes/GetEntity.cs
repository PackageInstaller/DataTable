using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取实体", 0)]
[Category("Logic/Attribute")]
[Description("获取实体")]
[ExposeAsDefinition]
public class GetEntity : CallableFunctionNode<SimEntity, int>
{
	public override SimEntity Invoke(int entityID)
	{
		return base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
	}
}
