using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Collections/Dictionaries")]
[ExposeAsDefinition]
public class AddDictionaryItem<T> : CallableFunctionNode<IDictionary<string, T>, IDictionary<string, T>, string, T>
{
	public override IDictionary<string, T> Invoke(IDictionary<string, T> dict, string key, T item)
	{
		dict.Add(key, item);
		return dict;
	}
}
