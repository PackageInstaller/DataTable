using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Min(long)", 0)]
[Category("Common/Math")]
[Description("如题")]
[Color("c0c0c0")]
public class MinOfLong : PureFunctionNode<long, long, long>
{
	public override long Invoke(long a, long b)
	{
		return Math.Min(a, b);
	}
}
