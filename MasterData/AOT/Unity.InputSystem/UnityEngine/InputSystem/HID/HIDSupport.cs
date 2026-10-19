using System.Linq;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.HID;

public static class HIDSupport
{
	public struct HIDPageUsage
	{
		public HID.UsagePage page;

		public int usage;

		public HIDPageUsage(HID.UsagePage page, int usage)
		{
			this.page = page;
			this.usage = usage;
		}

		public HIDPageUsage(HID.GenericDesktop usage)
		{
			page = HID.UsagePage.GenericDesktop;
			this.usage = (int)usage;
		}
	}

	private static HIDPageUsage[] s_SupportedHIDUsages;

	public static ReadOnlyArray<HIDPageUsage> supportedHIDUsages
	{
		get
		{
			return s_SupportedHIDUsages;
		}
		set
		{
			s_SupportedHIDUsages = value.ToArray();
			InputSystem.s_Manager.AddAvailableDevicesThatAreNowRecognized();
			for (int i = 0; i < InputSystem.devices.Count; i++)
			{
				InputDevice inputDevice = InputSystem.devices[i];
				if (inputDevice is HID hID && !s_SupportedHIDUsages.Contains(new HIDPageUsage(hID.hidDescriptor.usagePage, hID.hidDescriptor.usage)))
				{
					InputSystem.RemoveLayout(inputDevice.layout);
					i--;
				}
			}
		}
	}

	internal static void Initialize()
	{
		s_SupportedHIDUsages = new HIDPageUsage[3]
		{
			new HIDPageUsage(HID.GenericDesktop.Joystick),
			new HIDPageUsage(HID.GenericDesktop.Gamepad),
			new HIDPageUsage(HID.GenericDesktop.MultiAxisController)
		};
		InputSystem.RegisterLayout<HID>();
		InputSystem.onFindLayoutForDevice += HID.OnFindLayoutForDevice;
	}
}
