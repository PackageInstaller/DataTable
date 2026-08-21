using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Boolean")]
[Description("True if A or B is true, but not both")]
public class XOR : PureFunctionNode<bool, bool, bool>
{
	public override bool Invoke(bool a, bool b)
	{
		if (a | b)
		{
			return a != b;
		}
		return false;
	}
}
