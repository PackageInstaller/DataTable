using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Int3")]
[Name("Int3GetXYZ", 0)]
[Description("Int3 Int3GetXYZ")]
public class Int3GetXYZ : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Int3> valueInput = AddValueInput<Int3>("Int3");
		AddValueOutput("X", () => valueInput.value.x);
		AddValueOutput("Y", () => valueInput.value.y);
		AddValueOutput("Z", () => valueInput.value.z);
	}
}
