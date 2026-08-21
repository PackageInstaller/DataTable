using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Integers")]
[Description("Integer Round value to closest of interval ( round(value / interval) * interval )")]
public class IntegerSnap : PureFunctionNode<int, int, int>
{
	public override int Invoke(int value, int interval)
	{
		return (int)Mathf.Round(value / interval) * interval;
	}
}
