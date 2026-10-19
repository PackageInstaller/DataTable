using System;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Events/Physics")]
[TypeIcon(typeof(CharacterController))]
public sealed class OnControllerColliderHit : GameObjectEventUnit<ControllerColliderHit>
{
	public override Type MessageListenerType => typeof(UnityOnControllerColliderHitMessageListener);

	protected override string hookName => "OnControllerColliderHit";

	[DoNotSerialize]
	public ValueOutput collider { get; private set; }

	[DoNotSerialize]
	public ValueOutput controller { get; private set; }

	[DoNotSerialize]
	public ValueOutput moveDirection { get; private set; }

	[DoNotSerialize]
	public ValueOutput moveLength { get; private set; }

	[DoNotSerialize]
	public ValueOutput normal { get; private set; }

	[DoNotSerialize]
	public ValueOutput point { get; private set; }

	[DoNotSerialize]
	public ValueOutput data { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		collider = ValueOutput<Collider>("collider");
		controller = ValueOutput<CharacterController>("controller");
		moveDirection = ValueOutput<Vector3>("moveDirection");
		moveLength = ValueOutput<float>("moveLength");
		normal = ValueOutput<Vector3>("normal");
		point = ValueOutput<Vector3>("point");
		data = ValueOutput<ControllerColliderHit>("data");
	}

	protected override void AssignArguments(Flow flow, ControllerColliderHit hitData)
	{
		flow.SetValue(collider, hitData.collider);
		flow.SetValue(controller, hitData.controller);
		flow.SetValue(moveDirection, hitData.moveDirection);
		flow.SetValue(moveLength, hitData.moveLength);
		flow.SetValue(normal, hitData.normal);
		flow.SetValue(point, hitData.point);
		flow.SetValue(data, hitData);
	}
}
