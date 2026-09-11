using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Boolean")]
[Name("≠", 0)]
[Description("Boolean Not Equal To")]
public class BooleanNotEqual : PureFunctionNode<bool, bool, bool>
{
	public override bool Invoke(bool a, bool b)
	{
		return a != b;
	}
}
