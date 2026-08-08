using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Vector3")]
[Name("×", 0)]
[Description("Vector3 Multiply")]
public class Vector3Multiply : PureFunctionNode<Vector3, Vector3, float>
{
	public override Vector3 Invoke(Vector3 a, float b)
	{
		return a * b;
	}
}
