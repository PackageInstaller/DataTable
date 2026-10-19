using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

[UnitCategory("Community/Math")]
[UnitTitle("List Average (Vector2)")]
[TypeIcon(typeof(ScalarAverage))]
public class Vector2ListAverage : Unit
{
	[DoNotSerialize]
	public ValueInput numbers;

	[DoNotSerialize]
	public ValueOutput average;

	protected override void Definition()
	{
		numbers = ValueInput<List<Vector2>>("numbers");
		average = ValueOutput("average", Result);
	}

	private Vector2 Result(Flow flow)
	{
		List<Vector2> value = flow.GetValue<List<Vector2>>(numbers);
		if (value == null || value.Count == 0)
		{
			return default;
		}
		Vector2 vector = default;
		foreach (Vector2 item in value)
		{
			vector += item;
		}
		return vector / value.Count;
	}
}
