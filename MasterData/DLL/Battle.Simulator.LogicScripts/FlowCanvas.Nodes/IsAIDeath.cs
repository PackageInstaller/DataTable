using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("实体是否死亡", 0)]
[Category("Logic/Attribute")]
[Description("实体是否死亡.....")]
[ExposeAsDefinition]
public class IsAIDeath : CallableFunctionNode<bool, int>
{
	public override bool Invoke(int entityID)
	{
		return AIProcessor.IsAIDeath(entityID);
	}
}
