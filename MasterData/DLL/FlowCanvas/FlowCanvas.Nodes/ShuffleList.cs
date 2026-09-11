using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Collections/Lists")]
[ExposeAsDefinition]
public class ShuffleList<T> : CallableFunctionNode<IList<T>, IList<T>>
{
	public override IList<T> Invoke(IList<T> list)
	{
		for (int num = list.Count - 1; num > 0; num--)
		{
			int index = (int)Mathf.Floor(UnityEngine.Random.value * (float)(num + 1));
			T value = list[num];
			list[num] = list[index];
			list[index] = value;
		}
		return list;
	}
}
