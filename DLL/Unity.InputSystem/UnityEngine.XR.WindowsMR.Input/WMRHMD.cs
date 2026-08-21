using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.XR;

namespace UnityEngine.XR.WindowsMR.Input;

[InputControlLayout(displayName = "Windows MR Headset", hideInUI = true)]
public class WMRHMD : XRHMD
{
	[InputControl(name = "deviceRotation", layout = "Quaternion", aliases = new string[] { "HeadRotation" })]
	[InputControl]
	[InputControl(name = "devicePosition", layout = "Vector3", aliases = new string[] { "HeadPosition" })]
	public ButtonControl userPresence { get; protected set; }

	protected override void FinishSetup()
	{
		base.FinishSetup();
		userPresence = GetChildControl<ButtonControl>("userPresence");
	}
}
