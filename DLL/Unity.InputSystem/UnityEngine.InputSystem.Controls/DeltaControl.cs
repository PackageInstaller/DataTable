using UnityEngine.InputSystem.Layouts;
using UnityEngine.Scripting;

namespace UnityEngine.InputSystem.Controls;

[Preserve]
public class DeltaControl : Vector2Control
{
	[Preserve]
	[InputControl(useStateFrom = "y", parameters = "clamp=1,clampMin=0,clampMax=3.402823E+38", synthetic = true, displayName = "Up")]
	public AxisControl up { get; set; }

	[Preserve]
	[InputControl(useStateFrom = "y", parameters = "clamp=1,clampMin=-3.402823E+38,clampMax=0,invert", synthetic = true, displayName = "Down")]
	public AxisControl down { get; set; }

	[Preserve]
	[InputControl(useStateFrom = "x", parameters = "clamp=1,clampMin=-3.402823E+38,clampMax=0,invert", synthetic = true, displayName = "Left")]
	public AxisControl left { get; set; }

	[Preserve]
	[InputControl(useStateFrom = "x", parameters = "clamp=1,clampMin=0,clampMax=3.402823E+38", synthetic = true, displayName = "Right")]
	public AxisControl right { get; set; }

	protected override void FinishSetup()
	{
		base.FinishSetup();
		up = GetChildControl<AxisControl>("up");
		down = GetChildControl<AxisControl>("down");
		left = GetChildControl<AxisControl>("left");
		right = GetChildControl<AxisControl>("right");
	}
}
