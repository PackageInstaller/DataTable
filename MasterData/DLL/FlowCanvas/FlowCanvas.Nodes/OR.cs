using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Boolean")]
[Description("True if A or B is true")]
public class OR : PureFunctionNode<bool, bool, bool>
{
	public override bool Invoke(bool a, bool b)
	{
		return a | b;
	}
}
