using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Damp (Float)", 0)]
[Category("Time")]
[Description("Returns a smoothly interpolated value towards the input value.")]
public class DampFloat : PureFunctionNode<float, float, float, float>
{
	public override float Invoke(float current, float target, float damp = 1f)
	{
		return Mathf.Lerp(current, target, damp * Time.deltaTime);
	}
}
