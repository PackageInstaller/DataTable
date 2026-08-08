using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Utility")]
[Description("Custom cast input object to type T. Note that casts are already automatic at a connection-level. Use this only if necessary in your setup.")]
[ExposeAsDefinition]
public class Cast<T> : PureFunctionNode<T, object>
{
	public override T Invoke(object obj)
	{
		return (T)obj;
	}
}
