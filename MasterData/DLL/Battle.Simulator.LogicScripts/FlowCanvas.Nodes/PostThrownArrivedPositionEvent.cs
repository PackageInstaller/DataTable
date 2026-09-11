using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("发送抛掷物到达目标点事件", 0)]
[Category("Logic/抛掷物")]
[Description("当抛掷物到达目标点的时候,发出该事件")]
public class PostThrownArrivedPositionEvent : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID");
		ValueInput<Int3> arrivedPosVar = AddValueInput<Int3>("目标点坐标");
		AddFlowInput("In", delegate(Flow f)
		{
			ThrownArriedPositionEvent evt = ThrownArriedPositionEvent.Claim(thrownIDVar.value, arrivedPosVar.value);
			base.mSimContext.PostEvent(evt);
			output.Call(f);
		});
		AddValueOutput("抛掷物ID", () => thrownIDVar.value);
	}
}
