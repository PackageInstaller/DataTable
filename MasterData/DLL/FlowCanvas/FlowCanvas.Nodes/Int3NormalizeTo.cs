using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Int3")]
[Name("NormalizeTo", 0)]
[Description("Int3 NormalizeTo")]
public class Int3NormalizeTo : PureFunctionNode<Int3, Int3, int>
{
	public override Int3 Invoke(Int3 a, int b)
	{
		return a.NormalizeTo(b);
	}
}
