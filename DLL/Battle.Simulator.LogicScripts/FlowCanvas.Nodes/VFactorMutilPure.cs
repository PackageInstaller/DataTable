using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("定点数乘法(pure)", 0)]
[Category("Logic/Control")]
[Description("定点数乘法")]
[ExposeAsDefinition]
public class VFactorMutilPure : PureFunctionNode<int, int, int>
{
	public override int Invoke(int a, int b)
	{
		return a * b / 100;
	}
}
