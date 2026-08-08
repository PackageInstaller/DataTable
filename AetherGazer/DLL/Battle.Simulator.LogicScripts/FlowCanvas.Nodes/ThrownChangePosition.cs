using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物修改坐标", 0)]
[Category("Logic/抛掷物")]
[Description("强制修改抛掷物当前位置,不会修改抛掷物上一次记录的位置")]
public class ThrownChangePosition : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput success = AddFlowOutput("成功");
		FlowOutput abnormal = AddFlowOutput("异常");
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID");
		ValueInput<Int3> positionVar = AddValueInput<Int3>("坐标");
		AddFlowInput("In", delegate(Flow f)
		{
			ThrownState thrownState = null;
			if (!ThrownProcessor.TryGetThrown(base.mSimContext, thrownIDVar.GetValue(), out thrownState))
			{
				abnormal.Call(f);
			}
			else
			{
				thrownState.mPosition = positionVar.value;
				success.Call(f);
			}
		});
		AddValueOutput("抛掷物ID", () => thrownIDVar.value);
	}
}
