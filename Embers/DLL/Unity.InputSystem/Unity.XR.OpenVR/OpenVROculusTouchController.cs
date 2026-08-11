using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.XR;

namespace Unity.XR.OpenVR;

[InputControlLayout(displayName = "Oculus Touch Controller (OpenVR)", commonUsages = new string[] { "LeftHand", "RightHand" }, hideInUI = true)]
public class OpenVROculusTouchController : XRControllerWithRumble
{
	[InputControl]
	public Vector2Control thumbstick { get; protected set; }

	[InputControl]
	public AxisControl trigger { get; protected set; }

	[InputControl]
	public AxisControl grip { get; protected set; }

	[InputControl(aliases = new string[] { "Alternate" })]
	public ButtonControl primaryButton { get; protected set; }

	[InputControl(aliases = new string[] { "Primary" })]
	public ButtonControl secondaryButton { get; protected set; }

	[InputControl]
	public ButtonControl gripPressed { get; protected set; }

	[InputControl]
	public ButtonControl triggerPressed { get; protected set; }

	[InputControl(aliases = new string[] { "primary2DAxisClicked" })]
	public ButtonControl thumbstickClicked { get; protected set; }

	[InputControl(aliases = new string[] { "primary2DAxisTouch" })]
	public ButtonControl thumbstickTouched { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control deviceVelocity { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control deviceAngularVelocity { get; protected set; }

	protected override void FinishSetup()
	{
		base.FinishSetup();
		thumbstick = GetChildControl<Vector2Control>("thumbstick");
		trigger = GetChildControl<AxisControl>("trigger");
		grip = GetChildControl<AxisControl>("grip");
		primaryButton = GetChildControl<ButtonControl>("primaryButton");
		secondaryButton = GetChildControl<ButtonControl>("secondaryButton");
		gripPressed = GetChildControl<ButtonControl>("gripPressed");
		thumbstickClicked = GetChildControl<ButtonControl>("thumbstickClicked");
		thumbstickTouched = GetChildControl<ButtonControl>("thumbstickTouched");
		triggerPressed = GetChildControl<ButtonControl>("triggerPressed");
		deviceVelocity = GetChildControl<Vector3Control>("deviceVelocity");
		deviceAngularVelocity = GetChildControl<Vector3Control>("deviceAngularVelocity");
	}
}
