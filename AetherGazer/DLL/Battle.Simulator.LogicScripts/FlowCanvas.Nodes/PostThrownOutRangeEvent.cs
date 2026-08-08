using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("发送抛掷物出界事件", 0)]
[Category("Logic/抛掷物")]
[Description("当抛掷物离开网格范围时候,发出该事件")]
public class PostThrownOutRangeEvent : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID");
		ValueInput<Int3> borderPosVar = AddValueInput<Int3>("边缘坐标");
		AddFlowInput("In", delegate(Flow f)
		{
			ThrownOutRangeEvent evt = ThrownOutRangeEvent.Claim(thrownIDVar.value, borderPosVar.value);
			base.mSimContext.PostEvent(evt);
			output.Call(f);
		});
		AddValueOutput("抛掷物ID", () => thrownIDVar.value);
	}
}
