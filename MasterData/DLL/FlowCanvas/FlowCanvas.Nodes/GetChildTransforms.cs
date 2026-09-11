using System.Collections.Generic;
using System.Linq;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Unity")]
[Description("Get all child transforms of specified parent")]
public class GetChildTransforms : PureFunctionNode<IEnumerable<Transform>, Transform>
{
	public override IEnumerable<Transform> Invoke(Transform parent)
	{
		return parent.Cast<Transform>();
	}
}
