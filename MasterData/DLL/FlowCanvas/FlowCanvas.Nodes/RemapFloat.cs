using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Utility")]
[Description("Remaps from input min/max to output min/max, by current value provided between input min/max")]
[Name("Remap To Float", 0)]
public class RemapFloat : PureFunctionNode<float, float, float, float, float, float>
{
	public override float Invoke(float current, float iMin, float iMax = 1f, float oMin = 0f, float oMax = 100f)
	{
		return Mathf.Lerp(oMin, oMax, Mathf.InverseLerp(iMin, iMax, current));
	}
}
