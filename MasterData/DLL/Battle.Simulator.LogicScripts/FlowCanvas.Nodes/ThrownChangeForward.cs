using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物修改朝向", 0)]
[Category("Logic/抛掷物")]
[Description("强制修改抛掷物当前朝向")]
public class ThrownChangeForward : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput success = AddFlowOutput("成功", "success");
		FlowOutput error = AddFlowOutput("异常", "error");
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID", "thrownID");
		ValueInput<Int3> forwardVar = AddValueInput<Int3>("朝向", "forward");
		AddFlowInput("In", delegate(Flow f)
		{
			ThrownState thrownState = null;
			if (!ThrownProcessor.TryGetThrown(base.mSimContext, thrownIDVar.GetValue(), out thrownState))
			{
				error.Call(f);
			}
			else
			{
				thrownState.mForward = forwardVar.value;
				success.Call(f);
			}
		});
		AddValueOutput("抛掷物ID", () => thrownIDVar.value);
	}
}
