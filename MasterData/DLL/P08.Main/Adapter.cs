using System;
using UnityEngine;
using UnityEngine.UI;

public class Adapter : MonoBehaviour
{
	public ADAPTER_TYPE adapterType;

	public GridLayoutGroup layoutGroup;

	public float minGap;

	private Vector2 viewSize;

	private void Awake()
	{
		AdaptToView();
	}

	public void AdaptToView()
	{
		viewSize = base.gameObject.GetComponent<RectTransform>().rect.size;
		if (layoutGroup == null)
		{
			return;
		}
		float num = viewSize.x - (float)layoutGroup.padding.left - (float)layoutGroup.padding.right;
		if (ADAPTER_TYPE.FLEXIBLE_ITEM_NUM == adapterType)
		{
			float x = layoutGroup.cellSize.x;
			int num3;
			for (int num2 = (num3 = (int)Math.Floor(num / x)); num2 > 0; num2--)
			{
				if ((float)num2 * x + (float)(num2 - 1) * minGap <= num)
				{
					num3 = num2;
					break;
				}
			}
			layoutGroup.constraintCount = num3;
			float x2 = (num - (float)num3 * x) / (float)(num3 - 1);
			layoutGroup.spacing = new Vector2(x2, layoutGroup.spacing.y);
		}
		else if (ADAPTER_TYPE.FIXED_ITEM_NUM == adapterType)
		{
			int constraintCount = layoutGroup.constraintCount;
			float x3 = layoutGroup.spacing.x;
			float x4 = (num - (float)(constraintCount - 1) * x3) / (float)constraintCount;
			layoutGroup.cellSize = new Vector2(x4, layoutGroup.cellSize.y);
		}
	}
}
