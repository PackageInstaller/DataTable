using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name(">>", 0)]
[Category("Bitwise Operators/Integers")]
[Description("位运算")]
public class BitwiseOperatorsMoveRight : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> op1 = AddValueInput<int>("A");
		ValueInput<int> op2 = AddValueInput<int>("B");
		AddValueOutput("", () => op1.value >> op2.value);
	}
}
