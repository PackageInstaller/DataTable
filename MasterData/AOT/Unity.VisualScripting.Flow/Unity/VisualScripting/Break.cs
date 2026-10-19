namespace Unity.VisualScripting;

[UnitOrder(13)]
[UnitTitle("Break Loop")]
[UnitCategory("Control")]
public class Break : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput enter { get; private set; }

	protected override void Definition()
	{
		enter = ControlInput("enter", Operation);
	}

	public ControlOutput Operation(Flow flow)
	{
		flow.BreakLoop();
		return null;
	}
}
