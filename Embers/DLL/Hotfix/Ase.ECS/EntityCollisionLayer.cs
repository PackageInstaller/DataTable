using System.Collections.Generic;
using UnityEngine;

namespace Ase.ECS;

[RequireComponent(typeof(CapsuleCollider))]
public class EntityCollisionLayer : CollisionLayer
{
	public CapsuleCollider body;

	public List<Collider> others = new List<Collider>();

	public override string CollisionType => "Entity";
}
