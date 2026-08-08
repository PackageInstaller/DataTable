using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Int3")]
[Name("Int3GetVector3", 0)]
[Description("Int3 Int3SetXYZ")]
public class Int3GetVector3 : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Int3> valueInput = AddValueInput<Int3>("Int3");
		AddValueOutput("Vector3", () => (Vector3)valueInput.value);
	}
}
