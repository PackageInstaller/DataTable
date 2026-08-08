using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Int3")]
[Name("Int3Cross", 0)]
[Description("Int3 向量叉乘")]
public class Int3Cross : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Int3> xInput = AddValueInput<Int3>("a");
		ValueInput<Int3> yInput = AddValueInput<Int3>("b");
		AddValueOutput("Int3", () => Int3.Cross(xInput.value, yInput.value));
	}
}
