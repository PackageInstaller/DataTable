using System.Collections;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Collections/Lists")]
public class ClearList : CallableFunctionNode<IList, IList>
{
	public override IList Invoke(IList list)
	{
		list.Clear();
		return list;
	}
}
