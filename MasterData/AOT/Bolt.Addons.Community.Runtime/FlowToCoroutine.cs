using Unity.VisualScripting;
using UnityEngine;

[UnitTitle("FlowToCoroutine")]
[UnitCategory("Community\\Control")]
[TypeIcon(typeof(Coroutine))]
public class FlowToCoroutine : Unit
{
	[DoNotSerialize]
	public ControlInput In;

	[DoNotSerialize]
	public ControlOutput Converted;

	[DoNotSerialize]
	public ControlOutput _flow;

	protected override void Definition()
	{
		In = ControlInput("In", Convert);
		Converted = ControlOutput("Coroutine");
		_flow = ControlOutput("Flow");
		Succession(In, Converted);
		Succession(In, _flow);
	}

	private ControlOutput Convert(Flow flow)
	{
		GraphReference reference = flow.stack.ToReference();
		if (flow.isCoroutine)
		{
			Debug.LogWarning("FlowToCoroutine node is used to convert a normal flow to a Coroutine flow there is no point in using it in a Coroutine flow", flow.stack.gameObject);
			return Converted;
		}
		Flow.New(reference).StartCoroutine(Converted);
		return _flow;
	}
}
