using System;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Utilities/Constructors")]
[Obsolete]
public class NewBounds : PureFunctionNode<Bounds, Vector3, Vector3>
{
	public override Bounds Invoke(Vector3 center, Vector3 size)
	{
		return new Bounds(center, size);
	}
}
