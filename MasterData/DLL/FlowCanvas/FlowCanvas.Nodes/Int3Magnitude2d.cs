using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Int3")]
[Name("Magnitude2d", 0)]
[Description("Int3 Magnitude2d")]
public class Int3Magnitude2d : PureFunctionNode<int, Int3>
{
	public override int Invoke(Int3 a)
	{
		return a.magnitude2D;
	}
}
