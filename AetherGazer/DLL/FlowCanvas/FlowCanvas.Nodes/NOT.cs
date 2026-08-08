using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Boolean")]
[Description("Inverts the input")]
public class NOT : PureFunctionNode<bool, bool>
{
	public override bool Invoke(bool value)
	{
		return !value;
	}
}
