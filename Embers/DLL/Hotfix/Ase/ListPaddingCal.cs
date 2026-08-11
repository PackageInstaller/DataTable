using System;
using SuperScrollView;
using UnityEngine;

namespace Ase;

[Serializable]
public class ListPaddingCal
{
	public float padding;

	public float itemWidth;

	public float paddingLeft;

	public int GetMaxVisibleItemCount(float rtfWidth)
	{
		if (rtfWidth <= 0f || itemWidth <= 0f)
		{
			return 0;
		}
		float num = rtfWidth - paddingLeft;
		if (num <= 0f)
		{
			return 1;
		}
		int b = Mathf.FloorToInt((num + padding) / (itemWidth + padding));
		return Mathf.Max(1, b);
	}

	public ListItemArrangeType Cal(int itemCount, float rtfWidth)
	{
		int num = Mathf.Clamp(itemCount - 1, 0, itemCount - 1);
		if (!(rtfWidth >= (float)num * padding + (float)itemCount * itemWidth + paddingLeft))
		{
			return ListItemArrangeType.LeftToRight;
		}
		return ListItemArrangeType.LeftToRight_Center;
	}
}
