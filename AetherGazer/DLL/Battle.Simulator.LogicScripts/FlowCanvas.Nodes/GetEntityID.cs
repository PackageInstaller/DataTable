using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic/Attribute")]
[Description("获取实体ID")]
[ExposeAsDefinition]
public class GetEntityID : CallableFunctionNode<int, SimEntity>
{
	public override int Invoke(SimEntity entity)
	{
		return entity.creationIndex;
	}
}
