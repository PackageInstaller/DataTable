using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置移动ID", 0)]
[Category("Logic/AI")]
[Description("设置移动ID, 设置完之后, 所有移动都会用设置的这个ID, 要还原的话, 就把这个设为0")]
public class AISetMoveID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> value = AddValueInput<int>("移动ID");
		int entityID = 0;
		AddValueOutput("实体ID", () => entityID);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
			{
				entityWithEntityID.entityBlackboard.var.mDesiredMoveID = value.value;
			}
			output.Call(f);
		});
	}
}
