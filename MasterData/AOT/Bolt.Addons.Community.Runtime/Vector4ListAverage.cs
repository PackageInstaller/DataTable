using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

[UnitTitle("List Average (Vector4)")]
[TypeIcon(typeof(Vector4Average))]
[UnitCategory("Community/Math")]
public class Vector4ListAverage : Unit
{
	[DoNotSerialize]
	public ValueInput numbers;

	[DoNotSerialize]
	public ValueOutput average;

	protected override void Definition()
	{
		numbers = ValueInput<List<Vector4>>("numbers");
		average = ValueOutput("average", Result);
	}

	private Vector4 Result(Flow flow)
	{
		List<Vector4> value = flow.GetValue<List<Vector4>>(numbers);
		if (value == null || value.Count == 0)
		{
			return default;
		}
		Vector4 vector = default;
		foreach (Vector4 item in value)
		{
			vector += item;
		}
		return vector / value.Count;
	}
}
