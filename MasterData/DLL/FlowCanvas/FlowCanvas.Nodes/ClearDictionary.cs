using System.Collections;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Collections/Dictionaries")]
[ExposeAsDefinition]
public class ClearDictionary : CallableFunctionNode<IDictionary, IDictionary>
{
	public override IDictionary Invoke(IDictionary dict)
	{
		dict.Clear();
		return dict;
	}
}
