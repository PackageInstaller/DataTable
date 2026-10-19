using System.ComponentModel;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitShortTitle("Animation Event")]
[UnitTitle("Named Animation Event")]
[TypeIcon(typeof(Animation))]
[UnitCategory("Events/Animation")]
[DisplayName("Visual Scripting Named Animation Event")]
public sealed class BoltNamedAnimationEvent : MachineEventUnit<AnimationEvent>
{
	protected override string hookName => "AnimationEvent";

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput name { get; private set; }

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
		name = ValueInput("name", string.Empty);
		floatParameter = ValueOutput<float>("floatParameter");
		intParameter = ValueOutput<int>("intParameter");
		objectReferenceParameter = ValueOutput<GameObject>("objectReferenceParameter");
	}

	protected override bool ShouldTrigger(Flow flow, AnimationEvent animationEvent)
	{
		return EventUnit<AnimationEvent>.CompareNames(flow, name, animationEvent.stringParameter);
	}

	protected override void AssignArguments(Flow flow, AnimationEvent animationEvent)
	{
		flow.SetValue(floatParameter, animationEvent.floatParameter);
		flow.SetValue(intParameter, animationEvent.intParameter);
		flow.SetValue(objectReferenceParameter, animationEvent.objectReferenceParameter);
	}
}
