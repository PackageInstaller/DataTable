using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Floats")]
[Description("Float Round value to closest of interval ( round(value / interval) * interval )")]
public class FloatSnap : PureFunctionNode<int, float, int>
{
	public override int Invoke(float value, int interval)
	{
		return (int)Mathf.Round(value / (float)interval) * interval;
	}
}
