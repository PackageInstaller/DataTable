using System;
using UnityEngine;

[Serializable]
public class NewControllerValue
{
	[SerializeField]
	public ControllerProperty controllerProperty;

	[SerializeField]
	public UnityEngine.Object[] objs;

	[SerializeField]
	public int[] intValues;

	[SerializeField]
	public float[] floatValues;

	[SerializeField]
	public string[] stringValues;

	[SerializeField]
	public uint flag;

	[SerializeField]
	public bool isTween;

	[SerializeField]
	public float during = 0.3f;

	[SerializeField]
	public LeanTweenType ease = LeanTweenType.linear;

	public void SetFlag(uint flag)
	{
		this.flag = flag;
	}

	public void ChangeProperty(ControllerProperty property)
	{
		controllerProperty = property;
		objs = null;
		floatValues = null;
		stringValues = null;
		intValues = null;
	}

	public static NewControllerValue CreateFromComponent(ControllerProperty property, Component target)
	{
		NewControllerValue newControllerValue = new NewControllerValue();
		newControllerValue.controllerProperty = property;
		newControllerValue.CopyFromComponent(target);
		return newControllerValue;
	}

	public void CopyFromComponent(Component target)
	{
		switch (controllerProperty)
		{
		case ControllerProperty.Active:
			ActiveControllerValue.CopyFromComponent(this, target);
			break;
		case ControllerProperty.Image:
			ImageControllerValue.CopyFromComponent(this, target);
			break;
		case ControllerProperty.ToggleOn:
			ToggleOnControllerValue.CopyFromComponent(this, target);
			break;
		case ControllerProperty.RectTransform:
			RectTransformControllerValue.CopyFromComponent(this, target);
			break;
		case ControllerProperty.TextStyle:
			TextStyleControllerValue.CopyFromComponent(this, target);
			break;
		case ControllerProperty.TextValue:
			TextValueControllerValue.CopyFromComponent(this, target);
			break;
		case ControllerProperty.CanvasGroup:
			CanvasGroupControllerValue.CopyFromComponent(this, target);
			break;
		}
	}

	public void PasteToComponent(Component target, bool immediately)
	{
		bool flag = !immediately && isTween;
		switch (controllerProperty)
		{
		case ControllerProperty.Active:
			ActiveControllerValue.PasteTo(this, target, flag, during, ease);
			break;
		case ControllerProperty.Image:
			ImageControllerValue.PasteTo(this, target, flag, during, ease);
			break;
		case ControllerProperty.ToggleOn:
			ToggleOnControllerValue.PasteTo(this, target, flag, during, ease);
			break;
		case ControllerProperty.RectTransform:
			RectTransformControllerValue.PasteTo(this, target, flag, during, ease);
			break;
		case ControllerProperty.TextStyle:
			TextStyleControllerValue.PasteTo(this, target, flag, during, ease);
			break;
		case ControllerProperty.TextValue:
			TextValueControllerValue.PasteTo(this, target, flag, during, ease);
			break;
		case ControllerProperty.CanvasGroup:
			CanvasGroupControllerValue.PasteTo(this, target, flag, during, ease);
			break;
		}
	}

	public void PasteToComponentWithCallback(Component target, Action callback)
	{
		PasteToComponent(target, immediately: false);
		if (during > 0f)
		{
			LeanTween.delayedCall(target.gameObject, during, (Action)delegate
			{
				callback();
			});
		}
		else
		{
			callback?.Invoke();
		}
	}

	public ControllerCompareData IsEqual(ControllerProperty property, Component target)
	{
		switch (property)
		{
		case ControllerProperty.TextStyle:
			if (!TextStyleControllerValue.IsEqualTo(this, target))
			{
				return new ControllerCompareData(target.gameObject, property);
			}
			return null;
		case ControllerProperty.TextValue:
			if (!TextValueControllerValue.IsEqualTo(this, target))
			{
				return new ControllerCompareData(target.gameObject, property);
			}
			return null;
		case ControllerProperty.RectTransform:
			if (!RectTransformControllerValue.IsEqualTo(this, target))
			{
				return new ControllerCompareData(target.gameObject, property);
			}
			return null;
		case ControllerProperty.Active:
			if (!ActiveControllerValue.IsEqualTo(this, target))
			{
				return new ControllerCompareData(target.gameObject, property);
			}
			return null;
		case ControllerProperty.ToggleOn:
			if (!ToggleOnControllerValue.IsEqualTo(this, target))
			{
				return new ControllerCompareData(target.gameObject, property);
			}
			return null;
		case ControllerProperty.Image:
			if (!ImageControllerValue.IsEqualTo(this, target))
			{
				return new ControllerCompareData(target.gameObject, property);
			}
			return null;
		case ControllerProperty.CanvasGroup:
			if (!CanvasGroupControllerValue.IsEqualTo(this, target))
			{
				return new ControllerCompareData(target.gameObject, property);
			}
			return null;
		default:
			return null;
		}
	}

	public bool IsNull()
	{
		if (objs == null && floatValues == null && stringValues == null)
		{
			return intValues == null;
		}
		return false;
	}

	public void StopTween(GameObject go)
	{
		LeanTween.cancel(go);
	}
}
