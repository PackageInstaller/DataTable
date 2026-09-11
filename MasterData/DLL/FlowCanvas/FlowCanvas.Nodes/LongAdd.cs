using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Long")]
[Name("+", 0)]
[Description("Long Add")]
public class LongAdd : PureFunctionNode<long, long, long>
{
	public override long Invoke(long a, long b)
	{
		return a + b;
	}
}
