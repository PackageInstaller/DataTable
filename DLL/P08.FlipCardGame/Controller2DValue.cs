using System;
using UnityEngine;

[Serializable]
public class Controller2DValue
{
	[SerializeField]
	public ActiveController2DValue ActiveValue;

	[SerializeField]
	public TransformController2DValue TransformValue;

	[SerializeField]
	public SpriteRendererController2DValue SpriteRendererValue;

	[SerializeField]
	public bool isTween;

	[SerializeField]
	public float during = 0.3f;

	[SerializeField]
	public LeanTweenType ease = LeanTweenType.linear;

	public static Controller2DValue CreateFromComponent(Controller2DProperty property, Component target)
	{
		Controller2DValue controller2DValue = new Controller2DValue();
		switch (property)
		{
		case Controller2DProperty.Active:
		{
			ActiveController2DValue activeController2DValue = new ActiveController2DValue();
			activeController2DValue.CopyFromComponent(target);
			controller2DValue.ActiveValue = activeController2DValue;
			break;
		}
		case Controller2DProperty.Transform:
		{
			TransformController2DValue transformController2DValue = new TransformController2DValue();
			transformController2DValue.CopyFromComponent(target);
			controller2DValue.TransformValue = transformController2DValue;
			break;
		}
		case Controller2DProperty.SpriteRenderer:
		{
			SpriteRendererController2DValue spriteRendererController2DValue = new SpriteRendererController2DValue();
			spriteRendererController2DValue.CopyFromComponent(target);
			controller2DValue.SpriteRendererValue = spriteRendererController2DValue;
			break;
		}
		default:
			Debug.LogError("找不到对应的类型：" + target);
			return null;
		}
		return controller2DValue;
	}

	public bool CopyFromComponent(Controller2DProperty property, Component target)
	{
		switch (property)
		{
		case Controller2DProperty.Active:
			ActiveValue.CopyFromComponent(target);
			break;
		case Controller2DProperty.Transform:
			TransformValue.CopyFromComponent(target);
			break;
		case Controller2DProperty.SpriteRenderer:
			SpriteRendererValue.CopyFromComponent(target);
			break;
		}
		return true;
	}

	public bool PasteToComponent(Controller2DProperty property, Component target)
	{
		switch (property)
		{
		case Controller2DProperty.Active:
			ActiveValue.PasteToComponent(target, isTween, during, ease);
			break;
		case Controller2DProperty.Transform:
			TransformValue.PasteToComponent(target, isTween, during, ease);
			break;
		case Controller2DProperty.SpriteRenderer:
			SpriteRendererValue.PasteToComponent(target, isTween, during, ease);
			break;
		}
		return true;
	}

	public Controller2DCompareData IsEqual(Controller2DProperty property, Component target)
	{
		switch (property)
		{
		case Controller2DProperty.Active:
			if (!ActiveValue.IsEqualTo(target))
			{
				return new Controller2DCompareData(target.gameObject, property);
			}
			return null;
		case Controller2DProperty.Transform:
			if (!TransformValue.IsEqualTo(target))
			{
				return new Controller2DCompareData(target.gameObject, property);
			}
			return null;
		case Controller2DProperty.SpriteRenderer:
			if (!SpriteRendererValue.IsEqualTo(target))
			{
				return new Controller2DCompareData(target.gameObject, property);
			}
			return null;
		default:
			return null;
		}
	}
}
