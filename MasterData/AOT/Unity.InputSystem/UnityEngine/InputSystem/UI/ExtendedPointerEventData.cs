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
		stringBuilder.AppendLine("button: " + button);
		stringBuilder.AppendLine("clickTime: " + clickTime);
		stringBuilder.AppendLine("clickCount: " + clickCount);
		stringBuilder.AppendLine("device: " + device);
		stringBuilder.AppendLine("pointerType: " + pointerType);
		stringBuilder.AppendLine("touchId: " + touchId);
		stringBuilder.AppendLine("pressPosition: " + pressPosition.ToString());
		stringBuilder.AppendLine("trackedDevicePosition: " + trackedDevicePosition.ToString());
		stringBuilder.AppendLine("trackedDeviceOrientation: " + trackedDeviceOrientation.ToString());
		stringBuilder.AppendLine("pressure" + pressure);
		stringBuilder.AppendLine("radius: " + radius.ToString());
		stringBuilder.AppendLine("azimuthAngle: " + azimuthAngle);
		stringBuilder.AppendLine("altitudeAngle: " + altitudeAngle);
		stringBuilder.AppendLine("twist: " + twist);
		stringBuilder.AppendLine("displayIndex: " + displayIndex);
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
			pressure = pen.pressure.magnitude;
			azimuthAngle = (pen.tilt.value.x + 1f) * MathF.PI / 2f;
			altitudeAngle = (pen.tilt.value.y + 1f) * MathF.PI / 2f;
			twist = pen.twist.value * MathF.PI * 2f;
			displayIndex = pen.displayIndex.ReadValue();
		}
		else if (control.parent is TouchControl touchControl)
		{
			uiToolkitPointerId = GetTouchPointerId(touchControl);
			pressure = touchControl.pressure.magnitude;
			radius = touchControl.radius.value;
			displayIndex = touchControl.displayIndex.ReadValue();
		}
		else if (control.parent is Touchscreen touchscreen)
		{
			uiToolkitPointerId = GetTouchPointerId(touchscreen.primaryTouch);
			pressure = touchscreen.pressure.magnitude;
			radius = touchscreen.radius.value;
			displayIndex = touchscreen.displayIndex.ReadValue();
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
