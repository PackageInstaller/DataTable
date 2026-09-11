using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改抛掷物目标", 0)]
[Category("Logic/事件")]
[Description("修改抛掷物目标")]
public class ModifyThrownTarget : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID", "thrownIDVar");
		ValueInput<int> targetEntityIDVar = AddValueInput<int>("目标实体ID", "targetEntityIDVar");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (!ThrownProcessor.TryGetThrown(base.mSimContext, thrownIDVar.value, out var thrownState))
			{
				error.Call(f);
			}
			else
			{
				thrownState.mTargetID = targetEntityIDVar.value;
				output.Call(f);
			}
		});
		AddValueOutput("抛掷物ID", "thrownID", () => thrownIDVar.GetValue());
		AddValueOutput("目标实体ID", "targetEntityID", () => targetEntityIDVar.GetValue());
	}
}
