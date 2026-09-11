using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Collections/Lists")]
[ExposeAsDefinition]
public class InsertListItem<T> : CallableFunctionNode<IList<T>, List<T>, int, T>
{
	public override IList<T> Invoke(List<T> list, int index, T item)
	{
		list.Insert(index, item);
		return list;
	}
}
