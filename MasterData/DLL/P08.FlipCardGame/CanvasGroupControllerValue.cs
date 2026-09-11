using System;
using UnityEngine;

[Serializable]
public class CanvasGroupControllerValue
{
	public static bool CopyFromComponent(NewControllerValue value, Component target)
	{
		value.controllerProperty = ControllerProperty.CanvasGroup;
		CanvasGroup canvasGroup = target as CanvasGroup;
		value.intValues = new int[3]
		{
			canvasGroup.interactable ? 1 : 0,
			canvasGroup.blocksRaycasts ? 1 : 0,
			canvasGroup.ignoreParentGroups ? 1 : 0
		};
		if ((value.flag & 1) == 0)
		{
			value.floatValues = new float[1] { canvasGroup.alpha };
		}
		value.intValues = new int[3];
		if ((value.flag & 2) == 0)
		{
			value.intValues[0] = (canvasGroup.interactable ? 1 : 0);
		}
		if ((value.flag & 4) == 0)
		{
			value.intValues[1] = (canvasGroup.blocksRaycasts ? 1 : 0);
		}
		if ((value.flag & 8) == 0)
		{
			value.intValues[2] = (canvasGroup.ignoreParentGroups ? 1 : 0);
		}
		return true;
	}

	public static bool PasteTo(NewControllerValue value, Component target, bool isTween, float during, LeanTweenType ease)
	{
		float alpha = value.floatValues[0];
		bool interactable = value.intValues[0] == 1;
		bool blocksRaycasts = value.intValues[1] == 1;
		bool ignoreParentGroups = value.intValues[2] == 1;
		CanvasGroup g = target as CanvasGroup;
		if ((value.flag & 1) == 0)
		{
			if (isTween)
			{
				float originAlpha = g.alpha;
				LeanTween.value(0f, 1f, during).setEase(ease).setOnUpdate(delegate(float f)
				{
					float alpha2 = Mathf.Lerp(originAlpha, alpha, f);
					g.alpha = alpha2;
				});
			}
			else
			{
				g.alpha = alpha;
			}
		}
		if ((value.flag & 2) == 0)
		{
			g.interactable = interactable;
		}
		if ((value.flag & 4) == 0)
		{
			g.blocksRaycasts = blocksRaycasts;
		}
		if ((value.flag & 8) == 0)
		{
			g.ignoreParentGroups = ignoreParentGroups;
		}
		return true;
	}

	public static bool IsEqualTo(NewControllerValue value, Component target)
	{
		CanvasGroup canvasGroup = target as CanvasGroup;
		bool num = (value.flag & 1) != 0 || value.floatValues[0] == canvasGroup.alpha;
		bool flag = (value.flag & 2) != 0 || value.intValues[0] == (canvasGroup.interactable ? 1 : 0);
		bool flag2 = (value.flag & 4) != 0 || value.intValues[1] == (canvasGroup.blocksRaycasts ? 1 : 0);
		bool flag3 = (value.flag & 8) != 0 || value.intValues[2] == (canvasGroup.ignoreParentGroups ? 1 : 0);
		return num & flag & flag2 & flag3;
	}
}
