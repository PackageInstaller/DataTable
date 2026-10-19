using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Events/Physics")]
public abstract class TriggerEventUnit : GameObjectEventUnit<Collider>
{
	[DoNotSerialize]
	public ValueOutput collider { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		collider = ValueOutput<Collider>("collider");
	}

	protected override void AssignArguments(Flow flow, Collider other)
	{
		flow.SetValue(collider, other);
	}
}
