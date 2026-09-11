using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Boolean")]
[Description("True if A and B are both true")]
public class AND : PureFunctionNode<bool, bool, bool>
{
	public override bool Invoke(bool a, bool b)
	{
		return a & b;
	}
}
