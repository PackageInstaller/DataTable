using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Collections/Dictionaries")]
[ExposeAsDefinition]
public class GetDictionaryItem<T> : CallableFunctionNode<T, IDictionary<string, T>, string>
{
	public override T Invoke(IDictionary<string, T> dict, string key)
	{
		return dict[key];
	}
}
