using System.ComponentModel;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.Processors;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.Composites;

[DisplayStringFormat("{negative}/{positive}")]
[DisplayName("Positive/Negative Binding")]
public class AxisComposite : InputBindingComposite<float>
{
	public enum WhichSideWins
	{
		Neither,
		Positive,
		Negative
	}

	[InputControl(layout = "Axis")]
	public int negative;

	[InputControl(layout = "Axis")]
	public int positive;

	[Tooltip("Value to return when the negative side is fully actuated.")]
	public float minValue = -1f;

	[Tooltip("Value to return when the positive side is fully actuated.")]
	public float maxValue = 1f;

	[Tooltip("If both the positive and negative side are actuated, decides what value to return. 'Neither' (default) means that the resulting value is the midpoint between min and max. 'Positive' means that max will be returned. 'Negative' means that min will be returned.")]
	public WhichSideWins whichSideWins;

	public float midPoint => (maxValue + minValue) / 2f;

	public override float ReadValue(ref InputBindingCompositeContext context)
	{
		float num = Mathf.Abs(context.ReadValue<float>(negative));
		float num2 = Mathf.Abs(context.ReadValue<float>(positive));
		bool flag = num > Mathf.Epsilon;
		bool flag2 = num2 > Mathf.Epsilon;
		if (flag == flag2)
		{
			switch (whichSideWins)
			{
			case WhichSideWins.Negative:
				flag2 = false;
				break;
			case WhichSideWins.Positive:
				flag = false;
				break;
			case WhichSideWins.Neither:
				return midPoint;
			}
		}
		float num3 = midPoint;
		if (flag)
		{
			return num3 - (num3 - minValue) * num;
		}
		return num3 + (maxValue - num3) * num2;
	}

	public override float EvaluateMagnitude(ref InputBindingCompositeContext context)
	{
		float num = ReadValue(ref context);
		if (num < midPoint)
		{
			num = Mathf.Abs(num - midPoint);
			return NormalizeProcessor.Normalize(num, 0f, Mathf.Abs(minValue), 0f);
		}
		num = Mathf.Abs(num - midPoint);
		return NormalizeProcessor.Normalize(num, 0f, Mathf.Abs(maxValue), 0f);
	}
}
