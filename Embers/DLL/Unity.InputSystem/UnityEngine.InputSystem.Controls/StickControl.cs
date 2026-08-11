using UnityEngine.InputSystem.Layouts;

namespace UnityEngine.InputSystem.Controls;

public class StickControl : Vector2Control
{
	[InputControl(useStateFrom = "y", processors = "axisDeadzone", parameters = "clamp=2,clampMin=0,clampMax=1", synthetic = true, displayName = "Up")]
	[InputControl(name = "x", minValue = -1f, maxValue = 1f, layout = "Axis", processors = "axisDeadzone")]
	[InputControl(name = "y", minValue = -1f, maxValue = 1f, layout = "Axis", processors = "axisDeadzone")]
	public ButtonControl up { get; set; }

	[InputControl(useStateFrom = "y", processors = "axisDeadzone", parameters = "clamp=2,clampMin=-1,clampMax=0,invert", synthetic = true, displayName = "Down")]
	public ButtonControl down { get; set; }

	[InputControl(useStateFrom = "x", processors = "axisDeadzone", parameters = "clamp=2,clampMin=-1,clampMax=0,invert", synthetic = true, displayName = "Left")]
	public ButtonControl left { get; set; }

	[InputControl(useStateFrom = "x", processors = "axisDeadzone", parameters = "clamp=2,clampMin=0,clampMax=1", synthetic = true, displayName = "Right")]
	public ButtonControl right { get; set; }

	protected override void FinishSetup()
	{
		base.FinishSetup();
		up = GetChildControl<ButtonControl>("up");
		down = GetChildControl<ButtonControl>("down");
		left = GetChildControl<ButtonControl>("left");
		right = GetChildControl<ButtonControl>("right");
	}
}
