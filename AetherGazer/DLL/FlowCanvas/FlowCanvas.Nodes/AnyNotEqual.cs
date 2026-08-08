using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Any")]
[Name("≠", 0)]
[Description("Any Not Equal To")]
public class AnyNotEqual : PureFunctionNode<bool, object, object>
{
	public override bool Invoke(object a, object b)
	{
		return !object.Equals(a, b);
	}
}
