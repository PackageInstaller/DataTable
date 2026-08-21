using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Collections/Dictionaries")]
[ExposeAsDefinition]
public class TryGetValue<T> : CallableFunctionNode<T, IDictionary<string, T>, string>
{
	public bool exists { get; private set; }

	public override T Invoke(IDictionary<string, T> dict, string key)
	{
		T value = default(T);
		exists = dict.TryGetValue(key, out value);
		return value;
	}
}
