using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.XR;

namespace Unity.XR.Oculus.Input;

[InputControlLayout(displayName = "Oculus Headset", hideInUI = true)]
public class OculusHMD : XRHMD
{
	[InputControl(name = "isTracked", layout = "Button", aliases = new string[] { "deviceistracked" })]
	[InputControl(name = "trackingState", layout = "Integer", aliases = new string[] { "devicetrackingstate" })]
	[InputControl]
	public ButtonControl userPresence { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control deviceAngularVelocity { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control deviceAcceleration { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control deviceAngularAcceleration { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control leftEyeAngularVelocity { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control leftEyeAcceleration { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control leftEyeAngularAcceleration { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control rightEyeAngularVelocity { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control rightEyeAcceleration { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control rightEyeAngularAcceleration { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control centerEyeAngularVelocity { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control centerEyeAcceleration { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control centerEyeAngularAcceleration { get; protected set; }

	protected override void FinishSetup()
	{
		base.FinishSetup();
		userPresence = GetChildControl<ButtonControl>("userPresence");
		deviceAngularVelocity = GetChildControl<Vector3Control>("deviceAngularVelocity");
		deviceAcceleration = GetChildControl<Vector3Control>("deviceAcceleration");
		deviceAngularAcceleration = GetChildControl<Vector3Control>("deviceAngularAcceleration");
		leftEyeAngularVelocity = GetChildControl<Vector3Control>("leftEyeAngularVelocity");
		leftEyeAcceleration = GetChildControl<Vector3Control>("leftEyeAcceleration");
		leftEyeAngularAcceleration = GetChildControl<Vector3Control>("leftEyeAngularAcceleration");
		rightEyeAngularVelocity = GetChildControl<Vector3Control>("rightEyeAngularVelocity");
		rightEyeAcceleration = GetChildControl<Vector3Control>("rightEyeAcceleration");
		rightEyeAngularAcceleration = GetChildControl<Vector3Control>("rightEyeAngularAcceleration");
		centerEyeAngularVelocity = GetChildControl<Vector3Control>("centerEyeAngularVelocity");
		centerEyeAcceleration = GetChildControl<Vector3Control>("centerEyeAcceleration");
		centerEyeAngularAcceleration = GetChildControl<Vector3Control>("centerEyeAngularAcceleration");
	}
}
