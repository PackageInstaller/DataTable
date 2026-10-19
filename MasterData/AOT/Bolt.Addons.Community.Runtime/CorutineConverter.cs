using Unity.VisualScripting;
using UnityEngine;

[UnitCategory("Community\\Control")]
[TypeIcon(typeof(Flow))]
[UnitTitle("CoroutineToFlow")]
public class CorutineConverter : Unit
{
	[DoNotSerialize]
	public ControlInput In;

	[DoNotSerialize]
	public ControlOutput Converted;

	[DoNotSerialize]
	public ControlOutput Corutine;

	protected override void Definition()
	{
		In = ControlInput("In", Convert);
		Converted = ControlOutput("Flow");
		Corutine = ControlOutput("Coroutine");
		Succession(In, Converted);
		Succession(In, Corutine);
	}

	private ControlOutput Convert(Flow flow)
	{
		GraphReference reference = flow.stack.ToReference();
		if (!flow.isCoroutine)
		{
			Debug.LogWarning("CoroutineToFlow node is used to convert a Corutine flow to a normal flow there is no point in using it in a regular flow", flow.stack.gameObject);
			return Converted;
		}
		Flow.New(reference).Run(Converted);
		return Corutine;
	}
}
