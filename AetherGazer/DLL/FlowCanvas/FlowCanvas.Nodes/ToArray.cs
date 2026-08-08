using System;
using System.Collections.Generic;
using System.Linq;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Utilities/Converters")]
[Obsolete]
public class ToArray<T> : PureFunctionNode<T[], IList<T>>
{
	public override T[] Invoke(IList<T> list)
	{
		return list.ToArray();
	}
}
