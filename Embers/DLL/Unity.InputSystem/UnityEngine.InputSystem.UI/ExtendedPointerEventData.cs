using System;
using System.Text;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Utilities;
using UnityEngine.UIElements;

namespace UnityEngine.InputSystem.UI;

public class ExtendedPointerEventData : PointerEventData
{
	public InputControl control { get; set; }

	public InputDevice device { get; set; }

	public int touchId { get; set; }

	public UIPointerType pointerType { get; set; }

	public int uiToolkitPointerId { get; set; }

	public Vector3 trackedDevicePosition { get; set; }

	public Quaternion trackedDeviceOrientation { get; set; }

	public ExtendedPointerEventData(EventSystem eventSystem)
		: base(eventSystem)
	{
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append(base.ToString());
		stringBuilder.AppendLine("button: " + base.button);
		stringBuilder.AppendLine("clickTime: " + base.clickTime);
		stringBuilder.AppendLine("clickCount: " + base.clickCount);
		stringBuilder.AppendLine("device: " + device);
		stringBuilder.AppendLine("pointerType: " + pointerType);
		stringBuilder.AppendLine("touchId: " + touchId);
		stringBuilder.AppendLine("pressPosition: " + base.pressPosition.ToString());
		stringBuilder.AppendLine("trackedDevicePosition: " + trackedDevicePosition.ToString());
		stringBuilder.AppendLine("trackedDeviceOrientation: " + trackedDeviceOrientation.ToString());
		stringBuilder.AppendLine("pressure" + base.pressure);
		stringBuilder.AppendLine("radius: " + base.radius.ToString());
		stringBuilder.AppendLine("azimuthAngle: " + base.azimuthAngle);
		stringBuilder.AppendLine("altitudeAngle: " + base.altitudeAngle);
		stringBuilder.AppendLine("twist: " + base.twist);
		return stringBuilder.ToString();
	}

	internal static int MakePointerIdForTouch(int deviceId, int touchId)
	{
		return (deviceId << 24) + touchId;
	}

	internal static int TouchIdFromPointerId(int pointerId)
	{
		return pointerId & 0xFF;
	}

	internal void ReadDeviceState()
	{
		if (control.parent is Pen pen)
		{
			uiToolkitPointerId = GetPenPointerId(pen);
			base.pressure = pen.pressure.magnitude;
			base.azimuthAngle = (pen.tilt.value.x + 1f) * MathF.PI / 2f;
			base.altitudeAngle = (pen.tilt.value.y + 1f) * MathF.PI / 2f;
			base.twist = pen.twist.value * MathF.PI * 2f;
		}
		else if (control.parent is TouchControl touchControl)
		{
			uiToolkitPointerId = GetTouchPointerId(touchControl);
			base.pressure = touchControl.pressure.magnitude;
			base.radius = touchControl.radius.value;
		}
		else if (control.parent is Touchscreen touchscreen)
		{
			uiToolkitPointerId = GetTouchPointerId(touchscreen.primaryTouch);
			base.pressure = touchscreen.pressure.magnitude;
			base.radius = touchscreen.radius.value;
		}
		else
		{
			uiToolkitPointerId = PointerId.mousePointerId;
		}
	}

	private static int GetPenPointerId(Pen pen)
	{
		int num = 0;
		foreach (InputDevice device in InputSystem.devices)
		{
			if (device is Pen pen2)
			{
				if (pen == pen2)
				{
					return PointerId.penPointerIdBase + Mathf.Min(num, PointerId.penPointerCount - 1);
				}
				num++;
			}
		}
		return PointerId.penPointerIdBase;
	}

	private static int GetTouchPointerId(TouchControl touchControl)
	{
		int value = ((Touchscreen)touchControl.device).touches.IndexOfReference(touchControl);
		return PointerId.touchPointerIdBase + Mathf.Clamp(value, 0, PointerId.touchPointerCount - 1);
	}
}
