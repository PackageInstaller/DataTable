using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("理线器(float)", 0)]
[Category("通用/理线器")]
[Description("传递 float 类型的数值")]
public class LineWrapperOfFloat : PureFunctionNode<float, float>
{
	public override float Invoke(float a)
	{
		return a;
	}
}
