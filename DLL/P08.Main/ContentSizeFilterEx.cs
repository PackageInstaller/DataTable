using System;
using UnityEngine.UI;

public class ContentSizeFilterEx : ContentSizeFitter
{
	public Action onSizeChange;

	public override void SetLayoutHorizontal()
	{
		base.SetLayoutHorizontal();
		onSizeChange?.Invoke();
	}

	public override void SetLayoutVertical()
	{
		base.SetLayoutVertical();
		onSizeChange?.Invoke();
	}

	protected override void OnRectTransformDimensionsChange()
	{
		base.OnRectTransformDimensionsChange();
		onSizeChange?.Invoke();
	}
}
