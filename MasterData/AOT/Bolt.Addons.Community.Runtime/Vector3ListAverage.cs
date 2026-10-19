using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

[UnitCategory("Community/Math")]
[UnitTitle("List Average (Vector3)")]
[TypeIcon(typeof(Vector3Average))]
public class Vector3ListAverage : Unit
{
	[DoNotSerialize]
	public ValueInput numbers;

	[DoNotSerialize]
	public ValueOutput average;

	protected override void Definition()
	{
		numbers = ValueInput<List<Vector3>>("numbers");
		average = ValueOutput("average", Result);
	}

	private Vector3 Result(Flow flow)
	{
		List<Vector3> value = flow.GetValue<List<Vector3>>(numbers);
		if (value == null || value.Count == 0)
		{
			return default;
		}
		Vector3 vector = default;
		foreach (Vector3 item in value)
		{
			vector += item;
		}
		return vector / value.Count;
	}
}
