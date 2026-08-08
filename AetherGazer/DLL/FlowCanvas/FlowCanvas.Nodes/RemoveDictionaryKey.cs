using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Collections/Dictionaries")]
[ExposeAsDefinition]
public class RemoveDictionaryKey<T> : CallableFunctionNode<IDictionary<string, T>, IDictionary<string, T>, string>
{
	public override IDictionary<string, T> Invoke(IDictionary<string, T> dict, string key)
	{
		dict.Remove(key);
		return dict;
	}
}
