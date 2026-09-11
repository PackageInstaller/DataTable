using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Int3")]
[Name("Int3Slerp", 0)]
[Description("旋转向量（大圆最短路径）\n由a与b定义一平面，a在该平面内向b旋转，并限制最大旋转角度为maxDegreeDelta")]
public class Int3Slerp : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Int3> xInput = AddValueInput<Int3>("a");
		ValueInput<Int3> yInput = AddValueInput<Int3>("b");
		ValueInput<int> maxDegreeDelta = AddValueInput<int>("maxDegreeDelta");
		AddValueOutput("Int3", () => CommonProcessor.Int3Slerp(xInput.value, yInput.value, new VFactor(maxDegreeDelta.value, 1000L)));
	}
}
