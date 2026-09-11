using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Collections/Dictionaries")]
[ExposeAsDefinition]
public class DictionaryContainsKey<T> : CallableFunctionNode<bool, IDictionary<string, T>, string>
{
	public override bool Invoke(IDictionary<string, T> dict, string key)
	{
		return dict.ContainsKey(key);
	}
}
