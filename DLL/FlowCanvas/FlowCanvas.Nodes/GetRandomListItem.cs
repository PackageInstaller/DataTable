using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Collections/Lists")]
[ExposeAsDefinition]
public class GetRandomListItem<T> : PureFunctionNode<T, IList<T>>
{
	public override T Invoke(IList<T> list)
	{
		if (list.Count <= 0)
		{
			return default(T);
		}
		return list[UnityEngine.Random.Range(0, list.Count)];
	}
}
