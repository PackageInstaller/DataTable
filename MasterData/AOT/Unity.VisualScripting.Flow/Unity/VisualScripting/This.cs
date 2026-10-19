using UnityEngine;

namespace Unity.VisualScripting;

[RenamedFrom("Unity.VisualScripting.Self")]
[SpecialUnit]
[RenamedFrom("Bolt.Self")]
public sealed class This : Unit
{
	[PortLabelHidden]
	[DoNotSerialize]
	[PortLabel("This")]
	public ValueOutput self { get; private set; }

	protected override void Definition()
	{
		self = ValueOutput("self", Result).PredictableIf(IsPredictable);
	}

	private GameObject Result(Flow flow)
	{
		return flow.stack.self;
	}

	private bool IsPredictable(Flow flow)
	{
		return flow.stack.self != null;
	}
}
