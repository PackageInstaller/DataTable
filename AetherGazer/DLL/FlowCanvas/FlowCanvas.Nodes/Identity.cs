using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Identity", 10)]
[Category("Utility")]
[Description("Use this for organization. It returns exactly what is provided in the input.")]
[ExposeAsDefinition]
public class Identity<T> : PureFunctionNode<T, T>
{
	public override string name => null;

	public override T Invoke(T value)
	{
		return value;
	}
}
