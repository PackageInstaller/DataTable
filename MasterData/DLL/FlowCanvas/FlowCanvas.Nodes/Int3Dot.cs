using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Int3")]
[Name("Int3Dot", 0)]
[Description("Int3 向量点乘")]
public class Int3Dot : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Int3> xInput = AddValueInput<Int3>("a");
		ValueInput<Int3> yInput = AddValueInput<Int3>("b");
		AddValueOutput("Int3", () => Int3.Dot(xInput.value, yInput.value));
	}
}
