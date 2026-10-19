using System.Collections;

namespace Unity.VisualScripting.Community;

[UnitTitle("Enumerator")]
[TypeIcon(typeof(WaitUnit))]
[UnitCategory("Community/Time")]
public sealed class EnumeratorNode : Unit
{
	[PortLabelHidden]
	public ControlOutput trigger;

	[PortLabelHidden]
	public ValueOutput enumerator;

	public override bool isControlRoot => true;

	protected override void Definition()
	{
		trigger = ControlOutput("trigger");
		enumerator = ValueOutput("enumerator", Run);
	}

	public IEnumerator Run(Flow flow)
	{
		yield return trigger;
	}
}
