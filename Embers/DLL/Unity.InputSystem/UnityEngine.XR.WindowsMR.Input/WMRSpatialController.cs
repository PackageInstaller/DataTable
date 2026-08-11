using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.XR;

namespace UnityEngine.XR.WindowsMR.Input;

[InputControlLayout(displayName = "Windows MR Controller", commonUsages = new string[] { "LeftHand", "RightHand" }, hideInUI = true)]
public class WMRSpatialController : XRControllerWithRumble
{
	[InputControl(aliases = new string[] { "Primary2DAxis", "thumbstickaxes" })]
	public Vector2Control joystick { get; protected set; }

	[InputControl(aliases = new string[] { "Secondary2DAxis", "touchpadaxes" })]
	public Vector2Control touchpad { get; protected set; }

	[InputControl(aliases = new string[] { "gripaxis" })]
	public AxisControl grip { get; protected set; }

	[InputControl(aliases = new string[] { "gripbutton" })]
	public ButtonControl gripPressed { get; protected set; }

	[InputControl(aliases = new string[] { "Primary", "menubutton" })]
	public ButtonControl menu { get; protected set; }

	[InputControl(aliases = new string[] { "triggeraxis" })]
	public AxisControl trigger { get; protected set; }

	[InputControl(aliases = new string[] { "triggerbutton" })]
	public ButtonControl triggerPressed { get; protected set; }

	[InputControl(aliases = new string[] { "thumbstickpressed" })]
	public ButtonControl joystickClicked { get; protected set; }

	[InputControl(aliases = new string[] { "joystickorpadpressed", "touchpadpressed" })]
	public ButtonControl touchpadClicked { get; protected set; }

	[InputControl(aliases = new string[] { "joystickorpadtouched", "touchpadtouched" })]
	public ButtonControl touchpadTouched { get; protected set; }

	[InputControl(noisy = true, aliases = new string[] { "gripVelocity" })]
	public Vector3Control deviceVelocity { get; protected set; }

	[InputControl(noisy = true, aliases = new string[] { "gripAngularVelocity" })]
	public Vector3Control deviceAngularVelocity { get; protected set; }

	[InputControl(noisy = true)]
	public AxisControl batteryLevel { get; protected set; }

	[InputControl(noisy = true)]
	public AxisControl sourceLossRisk { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control sourceLossMitigationDirection { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control pointerPosition { get; protected set; }

	[InputControl(noisy = true, aliases = new string[] { "PointerOrientation" })]
	public QuaternionControl pointerRotation { get; protected set; }

	protected override void FinishSetup()
	{
		base.FinishSetup();
		joystick = GetChildControl<Vector2Control>("joystick");
		trigger = GetChildControl<AxisControl>("trigger");
		touchpad = GetChildControl<Vector2Control>("touchpad");
		grip = GetChildControl<AxisControl>("grip");
		gripPressed = GetChildControl<ButtonControl>("gripPressed");
		menu = GetChildControl<ButtonControl>("menu");
		joystickClicked = GetChildControl<ButtonControl>("joystickClicked");
		triggerPressed = GetChildControl<ButtonControl>("triggerPressed");
		touchpadClicked = GetChildControl<ButtonControl>("touchpadClicked");
		touchpadTouched = GetChildControl<ButtonControl>("touchPadTouched");
		deviceVelocity = GetChildControl<Vector3Control>("deviceVelocity");
		deviceAngularVelocity = GetChildControl<Vector3Control>("deviceAngularVelocity");
		batteryLevel = GetChildControl<AxisControl>("batteryLevel");
		sourceLossRisk = GetChildControl<AxisControl>("sourceLossRisk");
		sourceLossMitigationDirection = GetChildControl<Vector3Control>("sourceLossMitigationDirection");
		pointerPosition = GetChildControl<Vector3Control>("pointerPosition");
		pointerRotation = GetChildControl<QuaternionControl>("pointerRotation");
	}
}
