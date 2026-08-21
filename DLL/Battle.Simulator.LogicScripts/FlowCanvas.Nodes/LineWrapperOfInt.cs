using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("理线器(Int)", 0)]
[Category("通用/理线器")]
[Description("传递 Int 类型的数值")]
public class LineWrapperOfInt : PureFunctionNode<Int, Int>
{
	public override Int Invoke(Int a)
	{
		return a;
	}
}
