using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("理线器(Int3)", 0)]
[Category("通用/理线器")]
[Description("传递 Int3 类型的数值")]
public class LineWrapperOfInt3 : PureFunctionNode<Int3, Int3>
{
	public override Int3 Invoke(Int3 a)
	{
		return a;
	}
}
