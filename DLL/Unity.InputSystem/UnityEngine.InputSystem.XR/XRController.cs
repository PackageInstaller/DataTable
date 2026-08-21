using UnityEngine.InputSystem.Layouts;

namespace UnityEngine.InputSystem.XR;

[InputControlLayout(commonUsages = new string[] { "LeftHand", "RightHand" }, isGenericTypeOfDevice = true, displayName = "XR Controller")]
public class XRController : TrackedDevice
{
	public static XRController leftHand => InputSystem.GetDevice<XRController>(CommonUsages.LeftHand);

	public static XRController rightHand => InputSystem.GetDevice<XRController>(CommonUsages.RightHand);

	protected override void FinishSetup()
	{
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		base.FinishSetup();
		XRDeviceDescriptor xRDeviceDescriptor = XRDeviceDescriptor.FromJson(base.description.capabilities);
		if (xRDeviceDescriptor != null)
		{
			if ((xRDeviceDescriptor.characteristics & 0x100) != 0)
			{
				InputSystem.SetDeviceUsage(this, CommonUsages.LeftHand);
			}
			else if ((xRDeviceDescriptor.characteristics & 0x200) != 0)
			{
				InputSystem.SetDeviceUsage(this, CommonUsages.RightHand);
			}
		}
	}
}
