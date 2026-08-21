using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物停止移动", 0)]
[Category("Logic/抛掷物")]
[Description("抛掷物停止移动,但不停止帧计数,抛掷物移动速度与帧计数有关")]
public class ThrownStopMovement : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID");
		AddFlowInput("In", delegate(Flow f)
		{
			ThrownState thrownState = null;
			if (!ThrownProcessor.TryGetThrown(base.mSimContext, thrownIDVar.GetValue(), out thrownState))
			{
				output.Call(f);
			}
			else
			{
				thrownState.mDontMovement = true;
				output.Call(f);
			}
		});
		AddValueOutput("抛掷物ID", () => thrownIDVar.value);
	}
}
