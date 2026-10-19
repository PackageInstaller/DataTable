using System;

namespace Unity.VisualScripting;

[UnitCategory("Events/Physics")]
public sealed class OnJointBreak : GameObjectEventUnit<float>
{
	public override Type MessageListenerType => typeof(UnityOnJointBreakMessageListener);

	protected override string hookName => "OnJointBreak";

	[DoNotSerialize]
	public ValueOutput breakForce { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		breakForce = ValueOutput<float>("breakForce");
	}

	protected override void AssignArguments(Flow flow, float breakForce)
	{
		flow.SetValue(this.breakForce, breakForce);
	}
}
