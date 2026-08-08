using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Cache", 9)]
[Category("Utility")]
[Description("Caches the value only when the node is called.")]
[ExposeAsDefinition]
public class Cache<T> : CallableFunctionNode<T, T>
{
	public override T Invoke(T value)
	{
		return value;
	}
}
