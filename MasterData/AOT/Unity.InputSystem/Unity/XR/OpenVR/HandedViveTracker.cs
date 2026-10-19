using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Layouts;

namespace Unity.XR.OpenVR;

[InputControlLayout(displayName = "Handed Vive Tracker", commonUsages = new string[] { "LeftHand", "RightHand" }, hideInUI = true)]
public class HandedViveTracker : ViveTracker
{
	[InputControl]
	public AxisControl grip { get; protected set; }

	[InputControl]
	public ButtonControl gripPressed { get; protected set; }

	[InputControl]
	public ButtonControl primary { get; protected set; }

	[InputControl(aliases = new string[] { "JoystickOrPadPressed" })]
	public ButtonControl trackpadPressed { get; protected set; }

	[InputControl]
	public ButtonControl triggerPressed { get; protected set; }

	protected override void FinishSetup()
	{
		grip = GetChildControl<AxisControl>("grip");
		primary = GetChildControl<ButtonControl>("primary");
		gripPressed = GetChildControl<ButtonControl>("gripPressed");
		trackpadPressed = GetChildControl<ButtonControl>("trackpadPressed");
		triggerPressed = GetChildControl<ButtonControl>("triggerPressed");
		base.FinishSetup();
	}
}
