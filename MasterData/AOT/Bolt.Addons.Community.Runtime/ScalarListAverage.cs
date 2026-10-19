using System.Collections.Generic;
using Unity.VisualScripting;

[TypeIcon(typeof(ScalarAverage))]
[UnitTitle("List Average (Scalar)")]
[UnitCategory("Community/Math")]
public class ScalarListAverage : Unit
{
	[DoNotSerialize]
	public ValueInput numbers;

	[DoNotSerialize]
	public ValueOutput average;

	protected override void Definition()
	{
		numbers = ValueInput<List<float>>("numbers");
		average = ValueOutput("average", Result);
	}

	private float Result(Flow flow)
	{
		List<float> value = flow.GetValue<List<float>>(numbers);
		if (value == null || value.Count == 0)
		{
			return 0f;
		}
		float num = 0f;
		foreach (float item in value)
		{
			num += item;
		}
		return num / (float)value.Count;
	}
}
