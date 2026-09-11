using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移除实体移动组件", 0)]
[Category("Logic/PosAndRot")]
[Description("移除实体移动组件")]
public class RemoveEntityMoveDirection : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityActionMoveDirection)
			{
				falseOut.Call(f);
			}
			else
			{
				entityWithEntityID.RemoveEntityActionMoveDirection();
				trueOut.Call(f);
			}
		});
	}
}
