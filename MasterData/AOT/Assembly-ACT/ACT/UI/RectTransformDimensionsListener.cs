using System;
using UnityEngine.EventSystems;

namespace ACT.UI;

internal class RectTransformDimensionsListener : UIBehaviour
{
	public Action OnDimensionsChanged;

	protected override void OnRectTransformDimensionsChange()
	{
		base.OnRectTransformDimensionsChange();
		OnDimensionsChanged?.Invoke();
	}
}
