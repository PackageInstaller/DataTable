using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Events/Physics 2D")]
public abstract class TriggerEvent2DUnit : GameObjectEventUnit<Collider2D>
{
	[DoNotSerialize]
	public ValueOutput collider { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		collider = ValueOutput<Collider2D>("collider");
	}

	protected override void AssignArguments(Flow flow, Collider2D other)
	{
		flow.SetValue(collider, other);
	}
}
