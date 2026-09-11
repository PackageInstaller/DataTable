using System;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Obsolete]
public class ExtractContactPoint2D : ExtractorNode<ContactPoint2D, Vector2, Vector2, Collider2D, Collider2D>
{
	public override void Invoke(ContactPoint2D contactPoint, out Vector2 normal, out Vector2 point, out Collider2D colliderA, out Collider2D colliderB)
	{
		normal = contactPoint.normal;
		point = contactPoint.point;
		colliderA = contactPoint.collider;
		colliderB = contactPoint.otherCollider;
	}
}
