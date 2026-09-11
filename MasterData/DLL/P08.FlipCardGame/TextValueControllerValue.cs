using System;
using UnityEngine;
using UnityEngine.UI;

[Serializable]
public class TextValueControllerValue
{
	[SerializeField]
	public string text;

	public static bool CopyFromComponent(NewControllerValue value, Component target)
	{
		value.controllerProperty = ControllerProperty.TextValue;
		Text text = target as Text;
		value.stringValues = new string[1] { text.text };
		return true;
	}

	public static bool PasteTo(NewControllerValue value, Component target, bool isTween, float during, LeanTweenType ease)
	{
		string text = value.stringValues[0];
		(target as Text).text = text;
		return true;
	}

	public static bool IsEqualTo(NewControllerValue value, Component target)
	{
		return (target as Text).text == value.stringValues[0];
	}
}
