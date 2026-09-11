using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Min(integer)", 0)]
[Category("Common/Math")]
[Description("如题")]
[Color("c0c0c0")]
public class MinOfInteger : PureFunctionNode<int, int, int>
{
	public override int Invoke(int a, int b)
	{
		return Math.Min(a, b);
	}
}
