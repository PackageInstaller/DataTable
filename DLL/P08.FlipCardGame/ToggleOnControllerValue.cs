using System;
using UnityEngine;
using UnityEngine.UI;

[Serializable]
public class ToggleOnControllerValue
{
	[SerializeField]
	public bool isOn;

	public static bool CopyFromComponent(NewControllerValue value, Component target)
	{
		Toggle toggle = target as Toggle;
		value.controllerProperty = ControllerProperty.ToggleOn;
		value.intValues = new int[1] { toggle.isOn ? 1 : 0 };
		return true;
	}

	public static bool PasteTo(NewControllerValue value, Component target, bool isTween, float during, LeanTweenType ease)
	{
		(target as Toggle).isOn = value.intValues[0] == 1;
		return true;
	}

	public static bool IsEqualTo(NewControllerValue value, Component target)
	{
		return (target as Toggle).isOn == (value.intValues[0] == 1);
	}
}
