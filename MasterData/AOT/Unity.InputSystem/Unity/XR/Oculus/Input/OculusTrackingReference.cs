using UnityEngine.InputSystem;
using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Layouts;

namespace Unity.XR.Oculus.Input;

public class OculusTrackingReference : TrackedDevice
{
	[InputControl(aliases = new string[] { "trackingReferenceTrackingState" })]
	public new IntegerControl trackingState { get; protected set; }

	[InputControl(aliases = new string[] { "trackingReferenceIsTracked" })]
	public new ButtonControl isTracked { get; protected set; }

	protected override void FinishSetup()
	{
		base.FinishSetup();
		trackingState = GetChildControl<IntegerControl>("trackingState");
		isTracked = GetChildControl<ButtonControl>("isTracked");
	}
}
