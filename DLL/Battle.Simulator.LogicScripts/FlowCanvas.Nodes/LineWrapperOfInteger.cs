using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("理线器(integer)", 0)]
[Category("通用/理线器")]
[Description("传递 int 类型的数值,")]
public class LineWrapperOfInteger : PureFunctionNode<int, int>
{
	public override int Invoke(int a)
	{
		return a;
	}
}
