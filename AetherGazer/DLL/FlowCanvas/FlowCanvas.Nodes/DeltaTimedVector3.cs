using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Per Second (Vector3)", 0)]
[Category("Time")]
[Description("Mutliply input value by Time.deltaTime and optional multiplier")]
public class DeltaTimedVector3 : PureFunctionNode<Vector3, Vector3, float>
{
	public override Vector3 Invoke(Vector3 value, float multiplier = 1f)
	{
		return value * multiplier * Time.deltaTime;
	}
}
