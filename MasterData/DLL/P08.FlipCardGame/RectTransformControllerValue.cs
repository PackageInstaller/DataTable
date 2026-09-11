using System;
using UnityEngine;

[Serializable]
public class RectTransformControllerValue
{
	[SerializeField]
	public Vector3 localScale;

	[SerializeField]
	public Vector3 localPosition;

	[SerializeField]
	public Vector2 anchoredPosition;

	[SerializeField]
	public Vector2 anchorMin;

	[SerializeField]
	public Vector2 anchorMax;

	[SerializeField]
	public Quaternion localRotation;

	[SerializeField]
	public Vector3 localRot;

	[SerializeField]
	public Vector2 sizeDelta;

	public static bool CopyFromComponent(NewControllerValue value, Component target)
	{
		value.controllerProperty = ControllerProperty.RectTransform;
		RectTransform rectTransform = target as RectTransform;
		float[] array = new float[19];
		if ((value.flag & 1) == 0)
		{
			array[3] = rectTransform.localPosition.x;
			array[4] = rectTransform.localPosition.y;
			array[5] = rectTransform.localPosition.z;
			array[15] = rectTransform.sizeDelta.x;
			array[16] = rectTransform.sizeDelta.y;
			array[17] = rectTransform.pivot.x;
			array[18] = rectTransform.pivot.y;
		}
		if ((value.flag & 2) == 0)
		{
			array[6] = rectTransform.anchoredPosition.x;
			array[7] = rectTransform.anchoredPosition.y;
			array[8] = rectTransform.anchorMin.x;
			array[9] = rectTransform.anchorMin.y;
			array[10] = rectTransform.anchorMax.x;
			array[11] = rectTransform.anchorMax.y;
		}
		if ((value.flag & 4) == 0)
		{
			array[12] = rectTransform.localRotation.eulerAngles.x;
			array[13] = rectTransform.localRotation.eulerAngles.y;
			array[14] = rectTransform.localRotation.eulerAngles.z;
		}
		if ((value.flag & 8) == 0)
		{
			array[0] = rectTransform.localScale.x;
			array[1] = rectTransform.localScale.y;
			array[2] = rectTransform.localScale.z;
		}
		value.floatValues = array;
		return true;
	}

	public static bool PasteTo(NewControllerValue value, Component target, bool isTween, float during, LeanTweenType ease)
	{
		Vector3 localScale = new Vector3(value.floatValues[0], value.floatValues[1], value.floatValues[2]);
		Vector3 localPosition = new Vector3(value.floatValues[3], value.floatValues[4], value.floatValues[5]);
		Vector2 anchoredPosition = new Vector2(value.floatValues[6], value.floatValues[7]);
		Vector2 anchorMin = new Vector2(value.floatValues[8], value.floatValues[9]);
		Vector2 anchorMax = new Vector2(value.floatValues[10], value.floatValues[11]);
		Quaternion localRotation = Quaternion.Euler(value.floatValues[12], value.floatValues[13], value.floatValues[14]);
		Vector2 sizeDelta = new Vector2(value.floatValues[15], value.floatValues[16]);
		Vector2 pivot = (target.transform as RectTransform).pivot;
		if (value.floatValues.Length > 17)
		{
			pivot = new Vector2(value.floatValues[17], value.floatValues[18]);
		}
		RectTransform rt = target as RectTransform;
		if (isTween && Application.isPlaying)
		{
			LeanTween.cancel(target.gameObject);
			if ((value.flag & 1) == 0)
			{
				LeanTween.moveLocal(target.gameObject, localPosition, during).setEase(ease);
				LeanTween.size(rt, sizeDelta, during).setEase(ease);
				Vector2 srcPivot = (target.transform as RectTransform).pivot;
				LeanTween.value(target.gameObject, delegate(float f)
				{
					Vector2 pivot2 = Vector2.Lerp(srcPivot, pivot, f);
					rt.pivot = pivot2;
				}, 0f, 1f, during).setOnComplete((Action)delegate
				{
					rt.pivot = pivot;
					rt.sizeDelta = sizeDelta;
					rt.localPosition = localPosition;
				});
			}
			if ((value.flag & 2) == 0)
			{
				Vector2 srcAnchorMin = (target.transform as RectTransform).anchorMin;
				Vector2 srcAnchorMax = (target.transform as RectTransform).anchorMax;
				Vector2 srcAnchorPosition = (target.transform as RectTransform).anchoredPosition;
				LeanTween.value(target.gameObject, delegate(float f)
				{
					Vector2 vector = Vector2.Lerp(srcAnchorMin, anchorMin, f);
					Vector2 vector2 = Vector2.Lerp(srcAnchorMax, anchorMax, f);
					Vector2 vector3 = Vector2.Lerp(srcAnchorPosition, anchoredPosition, f);
					rt.anchorMin = vector;
					rt.anchorMax = vector2;
					rt.anchoredPosition = vector3;
				}, 0f, 1f, during).setOnComplete((Action)delegate
				{
					rt.anchorMin = anchorMin;
					rt.anchorMax = anchorMax;
					rt.anchoredPosition = anchoredPosition;
				});
			}
			if ((value.flag & 4) == 0)
			{
				Quaternion srcRotation = target.transform.localRotation;
				LeanTween.value(target.gameObject, delegate(float f)
				{
					Quaternion quaternion = Quaternion.Slerp(srcRotation, localRotation, f);
					rt.localRotation = quaternion;
				}, 0f, 1f, during).setOnComplete((Action)delegate
				{
					rt.localRotation = localRotation;
				});
			}
			if ((value.flag & 8) == 0)
			{
				LeanTween.scale(target.gameObject, localScale, during).setEase(ease).setOnComplete((Action)delegate
				{
					rt.localScale = localScale;
				});
			}
		}
		else
		{
			if ((value.flag & 1) == 0)
			{
				rt.pivot = pivot;
				rt.sizeDelta = sizeDelta;
				rt.localPosition = localPosition;
			}
			if ((value.flag & 2) == 0)
			{
				rt.anchorMax = anchorMax;
				rt.anchorMin = anchorMin;
				rt.anchoredPosition = anchoredPosition;
			}
			if ((value.flag & 4) == 0)
			{
				rt.localRotation = localRotation;
			}
			if ((value.flag & 8) == 0)
			{
				rt.localScale = localScale;
			}
		}
		return true;
	}

	public static bool IsEqualTo(NewControllerValue value, Component target)
	{
		Vector3 a = new Vector3(value.floatValues[0], value.floatValues[1], value.floatValues[2]);
		new Vector3(value.floatValues[3], value.floatValues[4], value.floatValues[5]);
		Vector2 a2 = new Vector2(value.floatValues[6], value.floatValues[7]);
		Vector2 a3 = new Vector2(value.floatValues[8], value.floatValues[9]);
		Vector2 a4 = new Vector2(value.floatValues[10], value.floatValues[11]);
		Quaternion a5 = Quaternion.Euler(value.floatValues[12], value.floatValues[13], value.floatValues[14]);
		Vector2 a6 = new Vector2(value.floatValues[15], value.floatValues[16]);
		RectTransform rectTransform = target as RectTransform;
		Vector2 a7 = rectTransform.pivot;
		if (value.floatValues.Length > 17)
		{
			a7 = new Vector2(value.floatValues[17], value.floatValues[18]);
		}
		bool num = (value.flag & 1) != 0 || (VectorEqual(a2, rectTransform.anchoredPosition) && VectorEqual(a6, rectTransform.sizeDelta) && VectorEqual(a7, rectTransform.pivot));
		bool flag = (value.flag & 2) != 0 || (VectorEqual(a3, rectTransform.anchorMin) && VectorEqual(a4, rectTransform.anchorMax));
		bool flag2 = (value.flag & 4) != 0 || RotationEqual(a5, rectTransform.localRotation);
		bool flag3 = (value.flag & 8) != 0 || VectorEqual(a, rectTransform.localScale);
		return num & flag & flag2 & flag3;
	}

	private static bool VectorEqual(Vector2 a, Vector2 b)
	{
		return Math.Abs((a - b).magnitude) < 0.001f;
	}

	private static bool VectorEqual(Vector3 a, Vector3 b)
	{
		return Math.Abs((a - b).magnitude) < 0.01f;
	}

	private static bool RotationEqual(Quaternion a, Quaternion b)
	{
		return Math.Abs((a.eulerAngles - b.eulerAngles).magnitude) < 0.001f;
	}
}
