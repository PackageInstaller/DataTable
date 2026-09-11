using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Long")]
[Name("÷", 0)]
[Description("Long Divide")]
public class LongDivide : PureFunctionNode<long, long, long>
{
	public override long Invoke(long a, long b)
	{
		if (b != 0L)
		{
			return a / b;
		}
		return 0L;
	}
}
