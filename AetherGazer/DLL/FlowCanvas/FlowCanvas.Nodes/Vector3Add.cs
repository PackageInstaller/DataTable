using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Vector3")]
[Name("+", 0)]
[Description("Vector3 Add")]
public class Vector3Add : PureFunctionNode<Vector3, Vector3, Vector3>
{
	public override Vector3 Invoke(Vector3 a, Vector3 b)
	{
		return a + b;
	}
}
