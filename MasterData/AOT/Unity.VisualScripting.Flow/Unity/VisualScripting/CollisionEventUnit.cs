using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Events/Physics")]
public abstract class CollisionEventUnit : GameObjectEventUnit<Collision>
{
	[DoNotSerialize]
	public ValueOutput collider { get; private set; }

	[DoNotSerialize]
	public ValueOutput contacts { get; private set; }

	[DoNotSerialize]
	public ValueOutput impulse { get; private set; }

	[DoNotSerialize]
	public ValueOutput relativeVelocity { get; private set; }

	[DoNotSerialize]
	public ValueOutput data { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		collider = ValueOutput<Collider>("collider");
		contacts = ValueOutput<ContactPoint[]>("contacts");
		impulse = ValueOutput<Vector3>("impulse");
		relativeVelocity = ValueOutput<Vector3>("relativeVelocity");
		data = ValueOutput<Collision>("data");
	}

	protected override void AssignArguments(Flow flow, Collision collision)
	{
		flow.SetValue(collider, collision.collider);
		flow.SetValue(contacts, collision.contacts);
		flow.SetValue(impulse, collision.impulse);
		flow.SetValue(relativeVelocity, collision.relativeVelocity);
		flow.SetValue(data, collision);
	}
}
