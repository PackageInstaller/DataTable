using Unity.VisualScripting;
using UnityEngine;

[UnitCategory("Community\\ObjectPooling")]
[UnitTitle("Retrieve Object")]
public class RetrieveObjectNode : Unit
{
	[DoNotSerialize]
	public ControlInput Enter;

	[DoNotSerialize]
	public ControlOutput Retrieved;

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput Pool;

	[DoNotSerialize]
	public ValueOutput Result;

	protected override void Definition()
	{
		Enter = ControlInput("Enter", OnEnter);
		Retrieved = ControlOutput("Retrieved");
		Pool = ValueInput<CustomObjectPool>("Pool");
		Result = ValueOutput<GameObject>("Result");
		Succession(Enter, Retrieved);
		Assignment(Enter, Result);
	}

	private ControlOutput OnEnter(Flow flow)
	{
		CustomObjectPool value = flow.GetValue<CustomObjectPool>(Pool);
		if (value != null)
		{
			GameObject value2 = value.RetrieveObjectFromPool();
			flow.SetValue(Result, value2);
		}
		return Retrieved;
	}
}
