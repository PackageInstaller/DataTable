using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Int3")]
[Name("Int3SetXYZ", 0)]
[Description("Int3 Int3SetXYZ")]
public class Int3SetXYZ : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> xInput = AddValueInput<int>("x");
		ValueInput<int> yInput = AddValueInput<int>("y");
		ValueInput<int> zInput = AddValueInput<int>("z");
		AddValueOutput("Int3", () => new Int3(xInput.value, yInput.value, zInput.value));
	}
}
