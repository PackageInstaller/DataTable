using System;
using UnityEngine;
using UnityEngine.UI;

public class UIListCalculator
{
	private static Vector2 _tmpVector = Vector2.zero;

	public static Vector2 GetItemPlacePos(UIList uilist, int index)
	{
		if (uilist.ItemPrefab == null)
		{
			return Vector2.zero;
		}
		Rect contentRect = uilist.GetContentRect();
		float x = 0f;
		float y = 0f;
		Vector2 spacing = uilist._spacing;
		float num = 0f;
		float num2 = 0f;
		UIListAlignment uiListAlignment = uilist.uiListAlignment;
		int itemNum = uilist._itemNum;
		RectOffset padding = uilist._padding;
		int colLimit = uilist._colLimit;
		int rowLimit = uilist._rowLimit;
		Rect itemRect = GetItemRect(uilist);
		if (uilist.Orientation == Orientation.Vertical)
		{
			float num3 = 0f;
			if (uilist.AutoSplit && colLimit > 1)
			{
				num3 = (contentRect.width - (float)padding.horizontal - ((itemRect.width + spacing.x) * (float)colLimit - spacing.x)) / (float)(colLimit - 1);
			}
			num = itemRect.width + spacing.x + num3;
			num2 = itemRect.height + spacing.y;
			x = (float)padding.left + (float)(index % colLimit) * num;
			y = (float)(-padding.top) - (float)(index / colLimit) * num2;
			float num4 = 0f;
			float num5 = contentRect.width - (num * (float)colLimit - spacing.x - num3);
			switch (uiListAlignment)
			{
			case UIListAlignment.Right:
				num4 = num5 - (float)padding.right;
				break;
			case UIListAlignment.Center:
				num4 = (num5 - (float)padding.horizontal) / 2f;
				break;
			case UIListAlignment.Center2:
			{
				int num6 = (itemNum - 1) / colLimit + 1;
				int num7 = ((index / colLimit < num6 - 1) ? (colLimit - 1) : ((itemNum - 1) % colLimit));
				float num8 = (float)(num7 + 1) * num - spacing.x;
				float num9 = num * (float)colLimit - spacing.x;
				num4 = (num5 - (float)padding.horizontal) / 2f + (num9 - num8) / 2f;
				break;
			}
			}
			x += num4;
		}
		else if (uilist.Orientation == Orientation.Horizontal)
		{
			float num10 = 0f;
			if (uilist.AutoSplit && rowLimit > 1)
			{
				num10 = (contentRect.height - (float)padding.vertical - ((itemRect.height + spacing.y) * (float)rowLimit - spacing.y)) / (float)(rowLimit - 1);
			}
			num = itemRect.width + spacing.x;
			num2 = itemRect.height + spacing.y + num10;
			x = (float)padding.left + (float)(index / rowLimit) * num;
			y = (float)(-padding.top) - (float)(index % rowLimit) * num2;
			float num11 = 0f;
			float num12 = contentRect.height - (num2 * (float)rowLimit - spacing.y - num10);
			switch (uiListAlignment)
			{
			case UIListAlignment.Bottom:
				num11 = num12 - (float)padding.top;
				break;
			case UIListAlignment.Center:
				num11 = (num12 - (float)padding.vertical) / 2f;
				break;
			case UIListAlignment.Center2:
			{
				int num13 = (itemNum - 1) / rowLimit + 1;
				int num14 = ((index / rowLimit < num13 - 1) ? (rowLimit - 1) : ((itemNum - 1) % rowLimit));
				float num15 = (float)(num14 + 1) * num2 - spacing.y;
				float num16 = num2 * (float)rowLimit - spacing.y;
				num11 = (num12 - (float)padding.vertical) / 2f + (num16 - num15) / 2f;
				break;
			}
			}
			y -= num11;
		}
		else if (uilist.Orientation == Orientation.SingleVertical)
		{
			num = itemRect.width;
			num2 = itemRect.height + spacing.y;
			x = padding.left;
			if (contentRect.height > uilist._viewport.rect.height + 1f)
			{
				y = (float)(-padding.top) - (float)index * num2;
			}
			else
			{
				int childCount = uilist.GetChildCount();
				y = (float)(-padding.top) - (float)index * num2;
				float num17 = 0f;
				if (uilist.uiListAlignmentWhenLess != UIListAlignmentWhenLess.Top)
				{
					if (uilist.uiListAlignmentWhenLess == UIListAlignmentWhenLess.Center)
					{
						num17 = contentRect.height + uilist._spacing.y - (float)uilist._padding.vertical - (itemRect.height + uilist._spacing.y) * (float)childCount;
						num17 /= 2f;
					}
					else if (uilist.uiListAlignmentWhenLess == UIListAlignmentWhenLess.Bottom)
					{
						num17 = contentRect.height + uilist._spacing.y - (float)uilist._padding.vertical - (itemRect.height + uilist._spacing.y) * (float)childCount;
					}
				}
				y -= num17;
			}
			float num18 = 0f;
			float num19 = contentRect.width - num;
			if (!uilist.SingleRowColFitItemSize)
			{
				switch (uiListAlignment)
				{
				case UIListAlignment.Right:
					num18 = num19 - (float)padding.right;
					break;
				case UIListAlignment.Center:
					num18 = (num19 - (float)padding.horizontal) / 2f;
					break;
				}
			}
			x += num18;
		}
		else if (uilist.Orientation == Orientation.SingleHorizontal)
		{
			num = itemRect.width + spacing.x;
			num2 = itemRect.height;
			y = -padding.top;
			if (contentRect.width > uilist._viewport.rect.width + 1f)
			{
				x = (float)padding.left + (float)(index / rowLimit) * num;
			}
			else
			{
				int childCount2 = uilist.GetChildCount();
				x = (float)padding.left + (float)index * num;
				float num20 = 0f;
				if (uilist.uiListAlignmentWhenLess != UIListAlignmentWhenLess.Left)
				{
					if (uilist.uiListAlignmentWhenLess == UIListAlignmentWhenLess.Center)
					{
						num20 = contentRect.width + uilist._spacing.x - (float)uilist._padding.horizontal - (itemRect.width + uilist._spacing.x) * (float)childCount2;
						num20 /= 2f;
					}
					else if (uilist.uiListAlignmentWhenLess == UIListAlignmentWhenLess.Right)
					{
						num20 = contentRect.width + uilist._spacing.x - (float)uilist._padding.horizontal - (itemRect.width + uilist._spacing.x) * (float)childCount2;
					}
				}
				x += num20;
			}
			float num21 = 0f;
			float num22 = contentRect.height - (num2 * (float)rowLimit - spacing.y);
			if (!uilist.SingleRowColFitItemSize)
			{
				switch (uiListAlignment)
				{
				case UIListAlignment.Top:
					num21 = num22 - (float)padding.top;
					break;
				case UIListAlignment.Center:
					num21 = (num22 - (float)padding.vertical) / 2f;
					break;
				}
			}
			y -= num21;
		}
		return new Vector2(x, y);
	}

	public static int GetStartIndexByPercent(UIList uiList, float percent)
	{
		Rect contentRect = uiList.GetContentRect();
		RectTransform viewport = uiList._viewport;
		RectTransform content = uiList.content;
		RectOffset padding = uiList._padding;
		int num = 0;
		Vector2 spacing = uiList._spacing;
		int colLimit = uiList._colLimit;
		int rowLimit = uiList._rowLimit;
		Rect itemRect = GetItemRect(uiList);
		if (uiList.IsVertical())
		{
			percent = 1f - percent;
			num = Mathf.FloorToInt(((contentRect.height - viewport.rect.height / content.localScale.y) * percent + 0.001f - (float)padding.top) / (spacing.y + itemRect.height)) * colLimit;
		}
		else if (uiList.IsHorizontal())
		{
			num = Mathf.FloorToInt(((contentRect.width - viewport.rect.width / content.localScale.x) * percent + 0.001f - (float)padding.left) / (spacing.x + itemRect.width)) * rowLimit;
		}
		if (num < 0)
		{
			num = 0;
		}
		return num;
	}

	public static int GetEndIndexByPercent(UIList uiList, float percent)
	{
		int itemNum = uiList._itemNum;
		if (!uiList.IsVirtual)
		{
			if (itemNum > 0)
			{
				return itemNum - 1;
			}
			return 0;
		}
		RectTransform viewport = uiList._viewport;
		RectTransform content = uiList.content;
		RectOffset padding = uiList._padding;
		Vector2 spacing = uiList._spacing;
		int colLimit = uiList._colLimit;
		int rowLimit = uiList._rowLimit;
		Rect contentRect = uiList.GetContentRect();
		Rect itemRect = GetItemRect(uiList);
		int num = 0;
		if (uiList.IsVertical())
		{
			percent = 1f - percent;
			num = Mathf.FloorToInt(((contentRect.height - viewport.rect.height / content.localScale.y) * percent + viewport.rect.height / content.localScale.y - (float)padding.top) / (spacing.y + itemRect.height)) * colLimit + (colLimit - 1);
		}
		else if (uiList.IsHorizontal())
		{
			num = Mathf.FloorToInt(((contentRect.width - viewport.rect.width / content.localScale.x) * percent + viewport.rect.width / content.localScale.x - (float)padding.left) / (spacing.x + itemRect.width)) * rowLimit + (rowLimit - 1);
		}
		if (num >= itemNum)
		{
			num = itemNum - 1;
		}
		return num;
	}

	public static float GetStartPosition(UIList uiList, int index, bool atCenter = false, float offset = 0f)
	{
		Rect contentRect = uiList.GetContentRect();
		Rect itemRect = GetItemRect(uiList);
		float width = itemRect.width;
		float height = itemRect.height;
		RectTransform viewport = uiList._viewport;
		RectTransform content = uiList.content;
		RectOffset padding = uiList._padding;
		Vector2 spacing = uiList._spacing;
		int colLimit = uiList._colLimit;
		int rowLimit = uiList._rowLimit;
		float num = 0f;
		if (uiList.IsVertical())
		{
			int num2 = index / colLimit;
			float num3 = contentRect.height - viewport.rect.height / content.localScale.y;
			float num4 = (float)padding.top + (float)num2 * (height + spacing.y);
			if (atCenter)
			{
				num4 -= (viewport.rect.height / content.localScale.y - height) / 2f;
			}
			num = num4 / num3;
		}
		else if (uiList.IsHorizontal())
		{
			int num5 = index / rowLimit;
			float num6 = contentRect.width - viewport.rect.width / content.localScale.x;
			float num7 = (float)padding.left + (float)num5 * (width + spacing.x);
			if (atCenter)
			{
				num7 -= (viewport.rect.width / content.localScale.x - width) / 2f;
			}
			num = num7 / num6;
		}
		num += 0.0001f;
		if (num < 0f)
		{
			num = 0f;
		}
		if (num > 1f)
		{
			num = 1f;
		}
		if (uiList.IsVertical())
		{
			num = 1f - num;
		}
		return num;
	}

	public static float GetEndPosition(UIList uiList, int index)
	{
		Rect contentRect = uiList.GetContentRect();
		Rect itemRect = GetItemRect(uiList);
		float width = itemRect.width;
		float height = itemRect.height;
		RectTransform viewport = uiList._viewport;
		RectTransform content = uiList.content;
		RectOffset padding = uiList._padding;
		Vector2 spacing = uiList._spacing;
		int colLimit = uiList._colLimit;
		int rowLimit = uiList._rowLimit;
		float num = 0f;
		if (uiList.IsVertical())
		{
			int num2 = index / colLimit;
			float num3 = contentRect.height - viewport.rect.height / content.localScale.y;
			num = ((float)padding.top + (float)num2 * (height + spacing.y) - viewport.rect.height / content.localScale.y) / num3;
		}
		else if (uiList.IsHorizontal())
		{
			int num4 = index / rowLimit;
			float num5 = contentRect.width - viewport.rect.width / content.localScale.x;
			num = ((float)padding.left + (float)num4 * (width + spacing.x) - viewport.rect.width / content.localScale.x) / num5;
		}
		if (num < 0f)
		{
			num = 0f;
		}
		if (num > 1f)
		{
			num = 1f;
		}
		if (uiList.IsVertical())
		{
			num = 1f - num;
		}
		return num;
	}

	public static Vector2 GetContentSize(UIList uiList, int itemNum, bool autoFitViewport = true)
	{
		try
		{
			if (uiList.ItemPrefab == null)
			{
				return Vector2.zero;
			}
			Rect itemRect = GetItemRect(uiList);
			RectTransform content = uiList.content;
			Vector2 sizeDelta = content.sizeDelta;
			if (uiList._viewport.rect.width < 0f || uiList._viewport.rect.height < 0f)
			{
				return Vector2.zero;
			}
			float num = 0f;
			switch (uiList.GetComponent<ScrollRect>().movementType)
			{
			case ScrollRect.MovementType.Unrestricted:
				num = 1f;
				break;
			case ScrollRect.MovementType.Elastic:
				num = 1f;
				break;
			case ScrollRect.MovementType.Clamped:
				num = 0f;
				break;
			}
			int rowLimit = uiList._rowLimit;
			int colLimit = uiList._colLimit;
			RectOffset padding = uiList._padding;
			RectTransform viewport = uiList._viewport;
			Vector2 spacing = uiList._spacing;
			if (uiList.Orientation == Orientation.Horizontal)
			{
				int num2 = ((itemNum == 0) ? 1 : ((itemNum - 1) / rowLimit + 1));
				sizeDelta.x = (float)(padding.left + padding.right) + (float)num2 * itemRect.width + (float)(num2 - 1) * spacing.x;
				sizeDelta.y = viewport.rect.height / content.localScale.y;
				if ((sizeDelta.x < uiList._viewport.rect.width) & autoFitViewport)
				{
					sizeDelta.x = uiList._viewport.rect.width + num;
				}
			}
			else if (uiList.Orientation == Orientation.Vertical)
			{
				int num3 = ((itemNum == 0) ? 1 : ((itemNum - 1) / colLimit + 1));
				sizeDelta.x = viewport.rect.width / content.localScale.x;
				sizeDelta.y = (float)(padding.top + padding.bottom) + (float)num3 * itemRect.height + (float)(num3 - 1) * spacing.y;
				if ((sizeDelta.y < uiList._viewport.rect.height) & autoFitViewport)
				{
					sizeDelta.y = uiList._viewport.rect.height + num;
				}
			}
			else if (uiList.Orientation == Orientation.SingleVertical)
			{
				int num4 = ((itemNum == 0) ? 1 : itemNum);
				sizeDelta.x = viewport.rect.width / content.localScale.x;
				sizeDelta.y = (float)(padding.top + padding.bottom) + (float)num4 * itemRect.height + (float)(num4 - 1) * spacing.y;
				if ((sizeDelta.y < uiList._viewport.rect.height) & autoFitViewport)
				{
					sizeDelta.y = uiList._viewport.rect.height + num;
				}
			}
			else if (uiList.Orientation == Orientation.SingleHorizontal)
			{
				int num5 = ((itemNum == 0) ? 1 : itemNum);
				sizeDelta.x = (float)(padding.left + padding.right) + (float)num5 * itemRect.width + (float)(num5 - 1) * spacing.x;
				sizeDelta.y = viewport.rect.height / content.localScale.y;
				if ((sizeDelta.x < uiList._viewport.rect.width) & autoFitViewport)
				{
					sizeDelta.x = uiList._viewport.rect.width + num;
				}
			}
			return sizeDelta;
		}
		catch (Exception ex)
		{
			Debug.LogError("UIListCalculator.GetContentSize出错\n Error：" + ex.Message);
			return Vector2.zero;
		}
	}

	public static Rect GetItemRect(UIList uiList)
	{
		try
		{
			Rect contentRect = uiList.GetContentRect();
			Rect rect = (uiList.ItemPrefab.transform as RectTransform).rect;
			float x = (uiList.ItemPrefab.transform as RectTransform).localScale.x;
			float y = (uiList.ItemPrefab.transform as RectTransform).localScale.y;
			rect.width *= x;
			rect.height *= y;
			if (uiList.Orientation == Orientation.Vertical)
			{
				if (uiList.AdapterType == AdapterType.FixItemSize)
				{
					float width = (contentRect.width - (float)uiList._padding.left - (float)uiList._padding.right - (float)(uiList.FixColOrRowCount - 1) * uiList._spacing.x) / (float)uiList.FixColOrRowCount;
					rect.width = width;
				}
			}
			else if (uiList.Orientation == Orientation.Horizontal)
			{
				if (uiList.AdapterType == AdapterType.FixItemSize)
				{
					float height = (contentRect.height - (float)uiList._padding.top - (float)uiList._padding.bottom - (float)(uiList.FixColOrRowCount - 1) * uiList._spacing.y) / (float)uiList.FixColOrRowCount;
					rect.height = height;
				}
			}
			else if (uiList.Orientation == Orientation.SingleVertical)
			{
				if (uiList.SingleRowColFitItemSize)
				{
					float width2 = contentRect.width - (float)uiList._padding.left - (float)uiList._padding.right;
					rect.width = width2;
				}
			}
			else if (uiList.Orientation == Orientation.SingleHorizontal && uiList.SingleRowColFitItemSize)
			{
				float height2 = contentRect.height - (float)uiList._padding.top - (float)uiList._padding.bottom;
				rect.height = height2;
			}
			return rect;
		}
		catch (Exception ex)
		{
			Debug.LogError("UIListCalculator.GetItemRect出错\n Error：" + ex.Message);
			return default(Rect);
		}
	}
}
