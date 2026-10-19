using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.XR;

namespace Unity.XR.OpenVR;

[InputControlLayout(displayName = "Windows MR Controller (OpenVR)", commonUsages = new string[] { "LeftHand", "RightHand" }, hideInUI = true)]
public class OpenVRControllerWMR : XRController
{
	[InputControl(noisy = true)]
	public Vector3Control deviceVelocity { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control deviceAngularVelocity { get; protected set; }

	[InputControl(aliases = new string[] { "primary2DAxisClick", "joystickOrPadPressed" })]
	public ButtonControl touchpadClick { get; protected set; }

	[InputControl(aliases = new string[] { "primary2DAxisTouch", "joystickOrPadTouched" })]
	public ButtonControl touchpadTouch { get; protected set; }

	[InputControl]
	public ButtonControl gripPressed { get; protected set; }

	[InputControl]
	public ButtonControl triggerPressed { get; protected set; }

	[InputControl(aliases = new string[] { "primary" })]
	public ButtonControl menu { get; protected set; }

	[InputControl]
	public AxisControl trigger { get; protected set; }

	[InputControl]
	public AxisControl grip { get; protected set; }

	[InputControl(aliases = new string[] { "secondary2DAxis" })]
	public Vector2Control touchpad { get; protected set; }

	[InputControl(aliases = new string[] { "primary2DAxis" })]
	public Vector2Control joystick { get; protected set; }

	protected override void FinishSetup()
	{
		base.FinishSetup();
		deviceVelocity = GetChildControl<Vector3Control>("deviceVelocity");
		deviceAngularVelocity = GetChildControl<Vector3Control>("deviceAngularVelocity");
		touchpadClick = GetChildControl<ButtonControl>("touchpadClick");
		touchpadTouch = GetChildControl<ButtonControl>("touchpadTouch");
		gripPressed = GetChildControl<ButtonControl>("gripPressed");
		triggerPressed = GetChildControl<ButtonControl>("triggerPressed");
		menu = GetChildControl<ButtonControl>("menu");
		trigger = GetChildControl<AxisControl>("trigger");
		grip = GetChildControl<AxisControl>("grip");
		touchpad = GetChildControl<Vector2Control>("touchpad");
		joystick = GetChildControl<Vector2Control>("joystick");
	}
}
