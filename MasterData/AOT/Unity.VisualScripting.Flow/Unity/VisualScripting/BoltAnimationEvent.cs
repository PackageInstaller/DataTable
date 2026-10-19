using System.ComponentModel;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Events/Animation")]
[UnitShortTitle("Animation Event")]
[UnitTitle("Animation Event")]
[TypeIcon(typeof(Animation))]
[DisplayName("Visual Scripting Animation Event")]
public sealed class BoltAnimationEvent : MachineEventUnit<AnimationEvent>
{
	protected override string hookName => "AnimationEvent";

	[DoNotSerialize]
	[PortLabel("String")]
	public ValueOutput stringParameter { get; private set; }

	[DoNotSerialize]
	[PortLabel("Float")]
	public ValueOutput floatParameter { get; private set; }

	[DoNotSerialize]
	[PortLabel("Integer")]
	public ValueOutput intParameter { get; private set; }

	[DoNotSerialize]
	[PortLabel("Object")]
	public ValueOutput objectReferenceParameter { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		stringParameter = ValueOutput<string>("stringParameter");
		floatParameter = ValueOutput<float>("floatParameter");
		intParameter = ValueOutput<int>("intParameter");
		objectReferenceParameter = ValueOutput<Object>("objectReferenceParameter");
	}

	protected override void AssignArguments(Flow flow, AnimationEvent args)
	{
		flow.SetValue(stringParameter, args.stringParameter);
		flow.SetValue(floatParameter, args.floatParameter);
		flow.SetValue(intParameter, args.intParameter);
		flow.SetValue(objectReferenceParameter, args.objectReferenceParameter);
	}
}
