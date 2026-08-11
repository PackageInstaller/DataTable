using System;
using System.ComponentModel;
using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.Composites;

[DisplayName("Up/Down/Left/Right Composite")]
[DisplayStringFormat("{up}/{left}/{down}/{right}")]
public class Vector2Composite : InputBindingComposite<Vector2>
{
	public enum Mode
	{
		Analog = 2,
		DigitalNormalized = 0,
		Digital = 1
	}

	[InputControl(layout = "Axis")]
	public int up;

	[InputControl(layout = "Axis")]
	public int down;

	[InputControl(layout = "Axis")]
	public int left;

	[InputControl(layout = "Axis")]
	public int right;

	[Obsolete("Use Mode.DigitalNormalized with 'mode' instead")]
	public bool normalize = true;

	public Mode mode;

	public override Vector2 ReadValue(ref InputBindingCompositeContext context)
	{
		Mode mode = this.mode;
		if (mode == Mode.Analog)
		{
			float num = context.ReadValue<float>(up);
			float num2 = context.ReadValue<float>(down);
			float num3 = context.ReadValue<float>(left);
			float num4 = context.ReadValue<float>(right);
			return DpadControl.MakeDpadVector(num, num2, num3, num4);
		}
		bool num5 = context.ReadValueAsButton(up);
		bool flag = context.ReadValueAsButton(down);
		bool flag2 = context.ReadValueAsButton(left);
		bool flag3 = context.ReadValueAsButton(right);
		if (!normalize)
		{
			mode = Mode.Digital;
		}
		return DpadControl.MakeDpadVector(num5, flag, flag2, flag3, mode == Mode.DigitalNormalized);
	}

	public override float EvaluateMagnitude(ref InputBindingCompositeContext context)
	{
		return ReadValue(ref context).magnitude;
	}
}
