using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Int")]
[Name("IntGetI", 0)]
[Description("IntGetI")]
public class IntGetI : PureFunctionNode<int, Int>
{
	public override int Invoke(Int a)
	{
		return a.i;
	}
}
