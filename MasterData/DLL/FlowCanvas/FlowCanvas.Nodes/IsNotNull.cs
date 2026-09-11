using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators")]
[Description("Returns if the object is not null")]
[Name("Is Valid", 0)]
public class IsNotNull : PureFunctionNode<bool, object>
{
	public override bool Invoke(object OBJECT)
	{
		if (OBJECT != null)
		{
			return !OBJECT.Equals(null);
		}
		return false;
	}
}
