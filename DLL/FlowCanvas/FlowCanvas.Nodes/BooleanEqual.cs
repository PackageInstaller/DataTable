using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Boolean")]
[Name("=", 0)]
[Description("Boolean Equal To")]
public class BooleanEqual : PureFunctionNode<bool, bool, bool>
{
	public override bool Invoke(bool a, bool b)
	{
		return a == b;
	}
}
