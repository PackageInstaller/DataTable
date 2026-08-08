using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置目标位置", 0)]
[Category("Logic/Attribute")]
[Description("设置目标位置")]
public class SetTargetPosition : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<Int3> targetPositionInput = AddValueInput<Int3>("目标位置");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			base.mSimContext.GetEntityWithEntityID(entityIDInput.value).entityBlackboard.var.mTargetPos = targetPositionInput.value;
			f.Call(output);
		});
	}
}
