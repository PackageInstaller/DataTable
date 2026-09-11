using System;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Obsolete]
public class ExtractContactPoint : ExtractorNode<ContactPoint, Vector3, Vector3, Collider, Collider>
{
	public override void Invoke(ContactPoint contactPoint, out Vector3 normal, out Vector3 point, out Collider colliderA, out Collider colliderB)
	{
		normal = contactPoint.normal;
		point = contactPoint.point;
		colliderA = contactPoint.thisCollider;
		colliderB = contactPoint.otherCollider;
	}
}
