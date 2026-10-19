using System.ComponentModel;

namespace Unity.VisualScripting;

[DisplayName("Visual Scripting Unity Event")]
[UnitOrder(2)]
[UnitTitle("UnityEvent")]
[UnitCategory("Events")]
public sealed class BoltUnityEvent : MachineEventUnit<string>
{
	protected override string hookName => "UnityEvent";

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput name { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		name = ValueInput("name", string.Empty);
	}

	protected override bool ShouldTrigger(Flow flow, string name)
	{
		return EventUnit<string>.CompareNames(flow, this.name, name);
	}
}
