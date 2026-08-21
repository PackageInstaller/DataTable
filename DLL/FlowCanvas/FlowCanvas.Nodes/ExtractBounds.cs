using System;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Obsolete]
public class ExtractBounds : ExtractorNode<Bounds, Vector3, Vector3, Vector3, Vector3, Vector3>
{
	public override void Invoke(Bounds bounds, out Vector3 center, out Vector3 extents, out Vector3 max, out Vector3 min, out Vector3 size)
	{
		center = bounds.center;
		extents = bounds.extents;
		max = bounds.max;
		min = bounds.min;
		size = bounds.size;
	}
}
