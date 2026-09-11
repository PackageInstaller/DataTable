using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Damp (Vector3)", 0)]
[Category("Time")]
[Description("Returns a smoothly interpolated value towards the input value.")]
public class DampVector3 : PureFunctionNode<Vector3, Vector3, Vector3, float>
{
	public override Vector3 Invoke(Vector3 current, Vector3 target, float damp = 1f)
	{
		return Vector3.Lerp(current, target, damp * Time.deltaTime);
	}
}
