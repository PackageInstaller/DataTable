using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Min", 0)]
[Category("Logic/Control")]
[Description("两两比较取小")]
public class GetMin : PureFunctionNode<int, int, int>
{
	public override int Invoke(int a, int b)
	{
		if (a >= b)
		{
			return b;
		}
		return a;
	}
}
