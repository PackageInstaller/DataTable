using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("实体(ID)是否死亡", 0)]
[Category("Logic/Attribute")]
[Description("判断实体是否死亡")]
[ExposeAsDefinition]
public class EntityIsDeadByID : CallableFunctionNode<bool, int>
{
	public override bool Invoke(int targetID)
	{
		return AIProcessor.IsAIDeath(targetID);
	}
}
