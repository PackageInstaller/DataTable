using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.XR;

namespace Unity.XR.Oculus.Input;

[InputControlLayout(displayName = "GearVR Controller", commonUsages = new string[] { "LeftHand", "RightHand" }, hideInUI = true)]
public class GearVRTrackedController : XRController
{
	[InputControl]
	public Vector2Control touchpad { get; protected set; }

	[InputControl]
	public AxisControl trigger { get; protected set; }

	[InputControl]
	public ButtonControl back { get; protected set; }

	[InputControl]
	public ButtonControl triggerPressed { get; protected set; }

	[InputControl]
	public ButtonControl touchpadClicked { get; protected set; }

	[InputControl]
	public ButtonControl touchpadTouched { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control deviceAngularVelocity { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control deviceAcceleration { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control deviceAngularAcceleration { get; protected set; }

	protected override void FinishSetup()
	{
		base.FinishSetup();
		touchpad = GetChildControl<Vector2Control>("touchpad");
		trigger = GetChildControl<AxisControl>("trigger");
		back = GetChildControl<ButtonControl>("back");
		triggerPressed = GetChildControl<ButtonControl>("triggerPressed");
		touchpadClicked = GetChildControl<ButtonControl>("touchpadClicked");
		touchpadTouched = GetChildControl<ButtonControl>("touchpadTouched");
		deviceAngularVelocity = GetChildControl<Vector3Control>("deviceAngularVelocity");
		deviceAcceleration = GetChildControl<Vector3Control>("deviceAcceleration");
		deviceAngularAcceleration = GetChildControl<Vector3Control>("deviceAngularAcceleration");
	}
}
