using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Obsolete]
[Category("Utility")]
[Description("Return a value from the list by index")]
[ExposeAsDefinition]
public class PickValue<T> : PureFunctionNode<T, int, IList<T>>
{
	public override T Invoke(int index, IList<T> values)
	{
		try
		{
			return values[index];
		}
		catch
		{
			return default(T);
		}
	}
}
