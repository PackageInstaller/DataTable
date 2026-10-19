using System.Collections;

namespace Unity.VisualScripting;

public abstract class LoopUnit : Unit
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput enter { get; private set; }

	[DoNotSerialize]
	public ControlOutput exit { get; private set; }

	[DoNotSerialize]
	public ControlOutput body { get; private set; }

	protected override void Definition()
	{
		enter = ControlInputCoroutine("enter", Loop, LoopCoroutine);
		exit = ControlOutput("exit");
		body = ControlOutput("body");
		Succession(enter, body);
		Succession(enter, exit);
	}

	protected abstract ControlOutput Loop(Flow flow);

	protected abstract IEnumerator LoopCoroutine(Flow flow);
}
