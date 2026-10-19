using System.ComponentModel;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.Composites;

[DisplayStringFormat("{up}+{down}/{left}+{right}/{forward}+{backward}")]
[DisplayName("Up/Down/Left/Right/Forward/Backward Composite")]
public class Vector3Composite : InputBindingComposite<Vector3>
{
	public enum Mode
	{
		Analog,
		DigitalNormalized,
		Digital
	}

	[InputControl(layout = "Axis")]
	public int up;

	[InputControl(layout = "Axis")]
	public int down;

	[InputControl(layout = "Axis")]
	public int left;

	[InputControl(layout = "Axis")]
	public int right;

	[InputControl(layout = "Axis")]
	public int forward;

	[InputControl(layout = "Axis")]
	public int backward;

	public Mode mode;

	public override Vector3 ReadValue(ref InputBindingCompositeContext context)
	{
		if (mode == Mode.Analog)
		{
			float num = context.ReadValue<float>(up);
			float num2 = context.ReadValue<float>(down);
			float num3 = context.ReadValue<float>(left);
			float num4 = context.ReadValue<float>(right);
			float num5 = context.ReadValue<float>(forward);
			float num6 = context.ReadValue<float>(backward);
			return new Vector3(num4 - num3, num - num2, num5 - num6);
		}
		float num7 = (context.ReadValueAsButton(up) ? 1f : 0f);
		float num8 = (context.ReadValueAsButton(down) ? (-1f) : 0f);
		float num9 = (context.ReadValueAsButton(left) ? (-1f) : 0f);
		float num10 = (context.ReadValueAsButton(right) ? 1f : 0f);
		float num11 = (context.ReadValueAsButton(forward) ? 1f : 0f);
		float num12 = (context.ReadValueAsButton(backward) ? (-1f) : 0f);
		Vector3 result = new Vector3(num9 + num10, num7 + num8, num11 + num12);
		if (mode == Mode.DigitalNormalized)
		{
			return result.normalized;
		}
		return result;
	}

	public override float EvaluateMagnitude(ref InputBindingCompositeContext context)
	{
		return ReadValue(ref context).magnitude;
	}
}
