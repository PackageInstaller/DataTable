using Unity.VisualScripting;
using Unity.VisualScripting.Community.Utility;

[TypeIcon(typeof(WaitUnit))]
[UnitCategory("Community/Control")]
[UnitTitle("WaitForPress")]
public class WaitForManualPress : Unit
{
	[NodeButton("Trigger")]
	[UnitHeaderInspectable]
	public NodeButton button;

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput input;

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlOutput output;

	private bool IsWaiting;

	private GraphReference reference;

	private bool coroutine;

	protected override void Definition()
	{
		input = ControlInput("input", Wait);
		output = ControlOutput("output");
		Succession(input, output);
	}

	private ControlOutput Wait(Flow flow)
	{
		reference = flow.stack.ToReference();
		coroutine = flow.isCoroutine;
		IsWaiting = true;
		return null;
	}

	public void Trigger(GraphReference reference)
	{
		if (IsWaiting)
		{
			IsWaiting = false;
			Flow flow = Flow.New(reference);
			if (coroutine)
			{
				flow.StartCoroutine(output);
			}
			else
			{
				flow.Run(output);
			}
		}
	}
}
