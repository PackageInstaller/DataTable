using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取实体准备移动的角度(跑酷用)", 0)]
[Category("Logic/PosAndRot")]
[Description("获取实体下一次位置移动相对于自身的向量(相对于摇杆位置)")]
[ExposeAsDefinition]
public class GetEntityNextDir : FlowNode
{
	protected override void RegisterPorts()
	{
		Int3 Dir = Int3.zero;
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		FlowOutput Output = AddFlowOutput("");
		FlowOutput Error = AddFlowOutput("Error");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.GetValue());
			if (entityWithEntityID == null)
			{
				Error.Call(f);
			}
			else
			{
				Dir = Int3.zero;
				if (entityWithEntityID.hasEntityActionMoveDirection)
				{
					Dir = entityWithEntityID.entityActionMoveDirection.mMovementDirection;
				}
				Output.Call(f);
			}
		});
		AddValueOutput("方向", () => Dir);
	}
}
