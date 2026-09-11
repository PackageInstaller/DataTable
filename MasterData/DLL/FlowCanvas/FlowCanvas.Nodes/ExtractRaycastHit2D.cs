using System;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Obsolete]
public class ExtractRaycastHit2D : ExtractorNode<RaycastHit2D, GameObject, float, float, Vector3, Vector3>
{
	public override void Invoke(RaycastHit2D hit, out GameObject gameObject, out float distance, out float fraction, out Vector3 normal, out Vector3 point)
	{
		gameObject = ((hit.collider != null) ? hit.collider.gameObject : null);
		distance = hit.distance;
		fraction = hit.fraction;
		normal = hit.normal;
		point = hit.point;
	}
}
