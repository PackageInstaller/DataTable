using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物返程更新方向", 0)]
[Category("Logic/抛掷物")]
[Description("抛掷物返程过程中,更新抛掷物的方向")]
public class UpdateThrownForwardOnBack : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID", "thrownID");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (!ThrownProcessor.TryGetThrown(base.mSimContext, thrownIDVar.GetValue(), out var thrownState))
			{
				errorOut.Call(f);
			}
			else
			{
				if (thrownState.mBackTargetPosition != Int3.up)
				{
					Int3 targetDirection = ThrownProcessor.GetTargetDirection(thrownState, thrownState.mBackTargetPosition);
					thrownState.mForward = targetDirection;
				}
				output.Call(f);
			}
		});
		AddValueOutput("抛掷物ID", "thrownID", () => thrownIDVar.GetValue());
	}
}
