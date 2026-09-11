using System;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Obsolete]
public class ExtractCollision : ExtractorNode<Collision, ContactPoint[], ContactPoint, GameObject, Vector3>
{
	public override void Invoke(Collision collision, out ContactPoint[] contacts, out ContactPoint firstContact, out GameObject gameObject, out Vector3 velocity)
	{
		contacts = collision.contacts;
		firstContact = collision.contacts[0];
		gameObject = collision.gameObject;
		velocity = collision.relativeVelocity;
	}
}
