using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Integers")]
[Name("÷", 0)]
[Description("Integer Divide")]
public class IntegerDivide : PureFunctionNode<int, int, int>
{
	public override int Invoke(int a, int b)
	{
		if (b != 0)
		{
			return a / b;
		}
		return 0;
	}
}
