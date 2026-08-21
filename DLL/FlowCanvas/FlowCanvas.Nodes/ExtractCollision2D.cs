using System;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Obsolete]
public class ExtractCollision2D : ExtractorNode<Collision2D, ContactPoint2D[], ContactPoint2D, GameObject, Vector2>
{
	public override void Invoke(Collision2D collision, out ContactPoint2D[] contacts, out ContactPoint2D firstContact, out GameObject gameObject, out Vector2 velocity)
	{
		contacts = collision.contacts;
		firstContact = collision.contacts[0];
		gameObject = collision.gameObject;
		velocity = collision.relativeVelocity;
	}
}
