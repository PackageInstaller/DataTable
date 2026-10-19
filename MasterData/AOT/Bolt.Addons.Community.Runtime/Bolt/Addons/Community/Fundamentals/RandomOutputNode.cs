using Unity.VisualScripting;
using UnityEngine;

namespace Bolt.Addons.Community.Fundamentals;

[UnitTitle("ChanceFlow")]
[UnitCategory("Community\\Control")]
[TypeIcon(typeof(SwitchOnInteger))]
public class RandomOutputNode : Unit
{
	[DoNotSerialize]
	public ValueInput value;

	[DoNotSerialize]
	public ControlOutput trueOutput;

	[DoNotSerialize]
	public ControlInput enter;

	[DoNotSerialize]
	public ControlOutput falseOutput;

	protected override void Definition()
	{
		value = ValueInput("Probability", 0f);
		trueOutput = ControlOutput("True");
		falseOutput = ControlOutput("False");
		enter = ControlInput("enter", OnEnter);
		Succession(enter, trueOutput);
		Succession(enter, falseOutput);
	}

	public ControlOutput OnEnter(Flow flow)
	{
		float num = flow.GetValue<float>(value);
		if (num > 100f)
		{
			num = 100f;
		}
		if (num < 0f)
		{
			num = 0f;
		}
		value.SetDefaultValue(num);
		num = Mathf.Clamp(num, 0f, 100f) / 100f;
		if (Random.value <= num)
		{
			return trueOutput;
		}
		return falseOutput;
	}
}
