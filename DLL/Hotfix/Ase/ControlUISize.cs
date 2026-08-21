using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ControlUISize : MonoBehaviour
{
	private bool finish;

	public Vector2 fixedSize;

	public List<RectTransform> vItems;

	public RectTransform cItem;

	public CanvasGroup canvasGroup;

	private void OnEnable()
	{
		finish = false;
		canvasGroup.alpha = 0.01f;
	}

	private async void Update()
	{
		if (!finish)
		{
			await new WaitForEndOfFrame();
			Vector2 sizeDelta = new Vector2(fixedSize.x, fixedSize.y + cItem.sizeDelta.y);
			foreach (RectTransform vItem in vItems)
			{
				vItem.sizeDelta = sizeDelta;
				LayoutRebuilder.ForceRebuildLayoutImmediate(vItem);
			}
			finish = true;
		}
		else if (canvasGroup.alpha != 1f)
		{
			canvasGroup.alpha = 1f;
		}
	}
}
