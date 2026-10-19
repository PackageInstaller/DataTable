using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

[UnitCategory("Community\\ObjectPooling")]
[UnitTitle("Return All")]
public class ReturnAllObjectsToPoolNode : Unit
{
	[DoNotSerialize]
	public ControlInput Enter;

	[DoNotSerialize]
	public ControlOutput Exit;

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput Pool;

	protected override void Definition()
	{
		Enter = ControlInput("Enter", OnEnter);
		Exit = ControlOutput("Exit");
		Pool = ValueInput<CustomObjectPool>("Pool");
		Succession(Enter, Exit);
	}

	private ControlOutput OnEnter(Flow flow)
	{
		CustomObjectPool value = flow.GetValue<CustomObjectPool>(Pool);
		if (value != null)
		{
			foreach (GameObject item in new List<GameObject>(value.GetActiveObjects()))
			{
				value.ReturnObjectToPool(item);
			}
		}
		return Exit;
	}
}
