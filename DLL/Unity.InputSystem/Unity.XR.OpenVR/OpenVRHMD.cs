using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.XR;

namespace Unity.XR.OpenVR;

[InputControlLayout(displayName = "OpenVR Headset", hideInUI = true)]
public class OpenVRHMD : XRHMD
{
	[InputControl(noisy = true)]
	public Vector3Control deviceVelocity { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control deviceAngularVelocity { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control leftEyeVelocity { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control leftEyeAngularVelocity { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control rightEyeVelocity { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control rightEyeAngularVelocity { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control centerEyeVelocity { get; protected set; }

	[InputControl(noisy = true)]
	public Vector3Control centerEyeAngularVelocity { get; protected set; }

	protected override void FinishSetup()
	{
		base.FinishSetup();
		deviceVelocity = GetChildControl<Vector3Control>("deviceVelocity");
		deviceAngularVelocity = GetChildControl<Vector3Control>("deviceAngularVelocity");
		leftEyeVelocity = GetChildControl<Vector3Control>("leftEyeVelocity");
		leftEyeAngularVelocity = GetChildControl<Vector3Control>("leftEyeAngularVelocity");
		rightEyeVelocity = GetChildControl<Vector3Control>("rightEyeVelocity");
		rightEyeAngularVelocity = GetChildControl<Vector3Control>("rightEyeAngularVelocity");
		centerEyeVelocity = GetChildControl<Vector3Control>("centerEyeVelocity");
		centerEyeAngularVelocity = GetChildControl<Vector3Control>("centerEyeAngularVelocity");
	}
}
