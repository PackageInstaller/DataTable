using UnityEngine.InputSystem.Layouts;

namespace UnityEngine.InputSystem.XR;

[InputControlLayout(commonUsages = new string[] { "LeftHand", "RightHand" }, isGenericTypeOfDevice = true, displayName = "XR Controller")]
public class XRController : TrackedDevice
{
	public static XRController leftHand => InputSystem.GetDevice<XRController>(CommonUsages.LeftHand);

	public static XRController rightHand => InputSystem.GetDevice<XRController>(CommonUsages.RightHand);

	protected override void FinishSetup()
	{
		base.FinishSetup();
	}
}
