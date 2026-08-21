using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物有无目标点", 0)]
[Category("Logic/抛掷物/移动")]
[Description("判定抛掷物是否有目标点的分支")]
public class ThrownHasTargetPosition : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput nonTargetPosition = AddFlowOutput("无目标点");
		FlowOutput hasTargetPosition = AddFlowOutput("有目标点");
		FlowOutput abnormal = AddFlowOutput("异常");
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID");
		AddFlowInput("In", delegate(Flow f)
		{
			ThrownState thrownState = null;
			if (!ThrownProcessor.TryGetThrown(base.mSimContext, thrownIDVar.GetValue(), out thrownState))
			{
				abnormal.Call(f);
			}
			else if (thrownState.mTargetPosition != Int3.up)
			{
				hasTargetPosition.Call(f);
			}
			else
			{
				nonTargetPosition.Call(f);
			}
		});
		AddValueOutput("抛掷物ID", () => thrownIDVar.value);
	}
}
