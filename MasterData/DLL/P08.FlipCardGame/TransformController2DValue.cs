using System;
using UnityEngine;

[Serializable]
public class TransformController2DValue
{
	[SerializeField]
	public Vector3 localScale;

	[SerializeField]
	public Vector3 localPosition;

	[SerializeField]
	public Vector3 localEulerAngles;

	[SerializeField]
	public Quaternion localRotation;

	public bool CopyFromComponent(Component target)
	{
		Transform transform = target as Transform;
		localScale = transform.localScale;
		localPosition = transform.localPosition;
		localRotation = transform.localRotation;
		localEulerAngles = transform.localEulerAngles;
		return true;
	}

	public bool PasteToComponent(Component target, bool isTween, float during, LeanTweenType ease)
	{
		Transform rt = target as Transform;
		if (isTween && Application.isPlaying)
		{
			LeanTween.moveLocal(target.gameObject, localPosition, during).setEase(ease);
			LeanTween.scale(target.gameObject, localScale, during).setEase(ease);
			Quaternion srcRotation = target.transform.localRotation;
			LeanTween.value(0f, 1f, during).setOnUpdate(delegate(float f)
			{
				Quaternion quaternion = Quaternion.Slerp(srcRotation, localRotation, f);
				rt.localRotation = quaternion;
			});
		}
		else
		{
			rt.localScale = localScale;
			rt.localRotation = localRotation;
			rt.localPosition = localPosition;
			rt.localEulerAngles = localEulerAngles;
		}
		return true;
	}

	public bool IsEqualTo(Component target)
	{
		Transform transform = target as Transform;
		if (localPosition == transform.localPosition && localEulerAngles == transform.localEulerAngles && localScale == transform.localScale)
		{
			return localRotation == transform.localRotation;
		}
		return false;
	}
}
