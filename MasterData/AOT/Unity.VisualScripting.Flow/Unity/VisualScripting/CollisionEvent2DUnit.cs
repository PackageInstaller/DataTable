using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Events/Physics 2D")]
public abstract class CollisionEvent2DUnit : GameObjectEventUnit<Collision2D>
{
	[DoNotSerialize]
	public ValueOutput collider { get; private set; }

	[DoNotSerialize]
	public ValueOutput contacts { get; private set; }

	[DoNotSerialize]
	public ValueOutput relativeVelocity { get; private set; }

	[DoNotSerialize]
	public ValueOutput enabled { get; private set; }

	[DoNotSerialize]
	public ValueOutput data { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		collider = ValueOutput<Collider2D>("collider");
		contacts = ValueOutput<ContactPoint2D[]>("contacts");
		relativeVelocity = ValueOutput<Vector2>("relativeVelocity");
		enabled = ValueOutput<bool>("enabled");
		data = ValueOutput<Collision2D>("data");
	}

	protected override void AssignArguments(Flow flow, Collision2D collisionData)
	{
		flow.SetValue(collider, collisionData.collider);
		flow.SetValue(contacts, collisionData.contacts);
		flow.SetValue(relativeVelocity, collisionData.relativeVelocity);
		flow.SetValue(enabled, collisionData.enabled);
		flow.SetValue(data, collisionData);
	}
}
