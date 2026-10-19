using System.Collections;

namespace Unity.VisualScripting;

[UnitCategory("Time")]
public abstract class WaitUnit : Unit
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput enter { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlOutput exit { get; private set; }

	protected override void Definition()
	{
		enter = ControlInputCoroutine("enter", Await);
		exit = ControlOutput("exit");
		Succession(enter, exit);
	}

	protected abstract IEnumerator Await(Flow flow);
}
