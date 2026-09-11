using System.Collections.Generic;
using System.Linq;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Collections/Lists")]
[ExposeAsDefinition]
public class GetFirstListItem<T> : PureFunctionNode<T, IList<T>>
{
	public override T Invoke(IList<T> list)
	{
		return list.FirstOrDefault();
	}
}
