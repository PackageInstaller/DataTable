using System;
using UnityEngine;
using UnityEngine.UI;

[Serializable]
public class TextStyleControllerValue
{
	[SerializeField]
	public Color color;

	[SerializeField]
	public int fontSize;

	public static bool CopyFromComponent(NewControllerValue value, Component target)
	{
		value.controllerProperty = ControllerProperty.TextStyle;
		Text text = target as Text;
		if ((value.flag & 1) == 0)
		{
			Color color = text.color;
			value.floatValues = new float[4] { color.r, color.g, color.b, color.a };
		}
		if ((value.flag & 2) == 0)
		{
			value.intValues = new int[1] { text.fontSize };
		}
		return true;
	}

	public static bool PasteTo(NewControllerValue value, Component target, bool isTween, float during, LeanTweenType ease)
	{
		Text text = target as Text;
		if ((value.flag & 1) == 0)
		{
			Color to = new Color(value.floatValues[0], value.floatValues[1], value.floatValues[2], value.floatValues[3]);
			if (isTween && Application.isPlaying)
			{
				LeanTween.color(text.gameObject, to, during).setEase(ease);
			}
			else
			{
				text.color = to;
			}
		}
		if ((value.flag & 2) == 0)
		{
			int num = value.intValues[0];
			text.fontSize = num;
		}
		return true;
	}

	public static bool IsEqualTo(NewControllerValue value, Component target)
	{
		Text text = target as Text;
		Color color = new Color(value.floatValues[0], value.floatValues[1], value.floatValues[2], value.floatValues[3]);
		bool num = (value.flag & 1) != 0 || color == text.color;
		int num2 = value.intValues[0];
		bool flag = (value.flag & 2) != 0 || num2 == text.fontSize;
		return num & flag;
	}
}
