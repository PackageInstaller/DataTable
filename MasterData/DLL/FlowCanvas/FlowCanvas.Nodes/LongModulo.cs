using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Long")]
[Name("%", 0)]
[Description("Long Modulo")]
public class LongModulo : PureFunctionNode<long, long, long>
{
	public override long Invoke(long value, long mod)
	{
		return value % mod;
	}
}
