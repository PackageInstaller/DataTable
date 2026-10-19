using System;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Events/Physics 2D")]
public sealed class OnJointBreak2D : GameObjectEventUnit<Joint2D>
{
	public override Type MessageListenerType => typeof(UnityOnJointBreak2DMessageListener);

	protected override string hookName => "OnJointBreak2D";

	[DoNotSerialize]
	public ValueOutput breakForce { get; private set; }

	[DoNotSerialize]
	public ValueOutput breakTorque { get; private set; }

	[DoNotSerialize]
	public ValueOutput connectedBody { get; private set; }

	[DoNotSerialize]
	public ValueOutput reactionForce { get; private set; }

	[DoNotSerialize]
	public ValueOutput reactionTorque { get; private set; }

	[DoNotSerialize]
	public ValueOutput joint { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		breakForce = ValueOutput<float>("breakForce");
		breakTorque = ValueOutput<float>("breakTorque");
		connectedBody = ValueOutput<Rigidbody2D>("connectedBody");
		reactionForce = ValueOutput<Vector2>("reactionForce");
		reactionTorque = ValueOutput<float>("reactionTorque");
		joint = ValueOutput<Joint2D>("joint");
	}

	protected override void AssignArguments(Flow flow, Joint2D joint)
	{
		flow.SetValue(breakForce, joint.breakForce);
		flow.SetValue(breakTorque, joint.breakTorque);
		flow.SetValue(connectedBody, joint.connectedBody);
		flow.SetValue(reactionForce, joint.reactionForce);
		flow.SetValue(reactionTorque, joint.reactionTorque);
		flow.SetValue(this.joint, joint);
	}
}
