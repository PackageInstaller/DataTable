using Unity.VisualScripting;
using UnityEngine;

[UnitTitle("Return Object")]
[UnitCategory("Community\\ObjectPooling")]
public class ReturnObjectNode : Unit
{
	[DoNotSerialize]
	public ControlInput Enter;

	[DoNotSerialize]
	public ControlOutput Exit;

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput Pool;

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput ObjectToReturn;

	protected override void Definition()
	{
		Enter = ControlInput("Enter", OnEnter);
		Exit = ControlOutput("Exit");
		Pool = ValueInput<CustomObjectPool>("Pool");
		ObjectToReturn = ValueInput<GameObject>("ObjectToReturn");
		Succession(Enter, Exit);
	}

	private ControlOutput OnEnter(Flow flow)
	{
		CustomObjectPool value = flow.GetValue<CustomObjectPool>(Pool);
		GameObject value2 = flow.GetValue<GameObject>(ObjectToReturn);
		if (value != null && value2 != null)
		{
			value.ReturnObjectToPool(value2);
		}
		return Exit;
	}
}
