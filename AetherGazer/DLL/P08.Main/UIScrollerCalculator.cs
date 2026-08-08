using UnityEngine;
using UnityEngine.UI;

public class UIScrollerCalculator
{
	public static Vector2 GetItemPlacePos(UIScroller uilist, int index)
	{
		if (uilist.ItemPrefab == null)
		{
			return Vector2.zero;
		}
		Vector2 contentSize = GetContentSize(uilist, uilist._itemNum);
		float x = 0f;
		float y = 0f;
		ScrollRect component = uilist.GetComponent<ScrollRect>();
		float num = 0f;
		float num2 = 0f;
		_ = uilist._itemNum;
		int num3 = 1;
		int num4 = 1;
		Rect rect = (uilist.ItemPrefab.transform as RectTransform).rect;
		if (uilist.Orientation == UIScrollerOrientation.SingleVertical)
		{
			VerticalLayoutGroup component2 = component.content.GetComponent<VerticalLayoutGroup>();
			Vector2 vector = new Vector2(0f, component2.spacing);
			RectOffset padding = component2.padding;
			num = rect.width + vector.x;
			num2 = rect.height + vector.y;
			x = (float)padding.left + (float)(index % num3) * num;
			y = (float)(-padding.top) - (float)(index / num3) * num2;
			float num5 = 0f;
			float num6 = contentSize.x - (num * (float)num3 - vector.x);
			if (component2.childAlignment == TextAnchor.UpperCenter || component2.childAlignment == TextAnchor.MiddleCenter || component2.childAlignment == TextAnchor.LowerCenter)
			{
				num5 = (num6 - (float)padding.horizontal) / 2f;
			}
			else if (component2.childAlignment == TextAnchor.LowerRight || component2.childAlignment == TextAnchor.MiddleRight || component2.childAlignment == TextAnchor.UpperRight)
			{
				num5 = num6 - (float)padding.right;
			}
			x += num5;
		}
		else if (uilist.Orientation == UIScrollerOrientation.SingleHorizontal)
		{
			HorizontalLayoutGroup component3 = component.content.GetComponent<HorizontalLayoutGroup>();
			Vector2 vector = new Vector2(component3.spacing, 0f);
			RectOffset padding = component3.padding;
			num = rect.width + vector.x;
			num2 = rect.height + vector.y;
			x = (float)padding.left + (float)(index / num4) * num;
			y = (float)(-padding.top) - (float)(index % num4) * num2;
			float num7 = 0f;
			float num8 = contentSize.y - (num2 * (float)num4 - vector.y);
			if (component3.childAlignment != TextAnchor.UpperCenter && component3.childAlignment != TextAnchor.UpperLeft && component3.childAlignment != TextAnchor.UpperRight)
			{
				if (component3.childAlignment == TextAnchor.MiddleCenter || component3.childAlignment == TextAnchor.MiddleLeft || component3.childAlignment == TextAnchor.MiddleRight)
				{
					num7 = (num8 - (float)padding.vertical) / 2f;
				}
				else if (component3.childAlignment == TextAnchor.LowerCenter || component3.childAlignment == TextAnchor.LowerLeft || component3.childAlignment == TextAnchor.LowerRight)
				{
					num7 = num8 - (float)padding.top;
				}
			}
			y -= num7;
		}
		return new Vector2(x, y);
	}

	public static float GetStartPosition(UIScroller uiList, int index, bool atCenter = false, float offset = 0f)
	{
		Vector2 contentSize = GetContentSize(uiList, uiList._itemNum);
		Rect rect = (uiList.ItemPrefab.transform as RectTransform).rect;
		float width = rect.width;
		float height = rect.height;
		RectTransform viewport = uiList._viewport;
		RectTransform content = uiList.content;
		int num = 1;
		int num2 = 1;
		float num3 = 0f;
		if (uiList.IsVertical())
		{
			VerticalLayoutGroup component = uiList.content.GetComponent<VerticalLayoutGroup>();
			Vector2 vector = new Vector2(0f, component.spacing);
			RectOffset padding = component.padding;
			int num4 = index / num;
			float num5 = contentSize.y - viewport.rect.height / content.localScale.y;
			float num6 = (float)padding.top + (float)num4 * (height + vector.y);
			if (atCenter)
			{
				num6 -= (viewport.rect.height / content.localScale.y - height) / 2f;
			}
			num3 = num6 / num5;
		}
		else if (uiList.IsHorizontal())
		{
			HorizontalLayoutGroup component2 = uiList.content.GetComponent<HorizontalLayoutGroup>();
			Vector2 vector = new Vector2(component2.spacing, 0f);
			RectOffset padding2 = component2.padding;
			int num7 = index / num2;
			float num8 = contentSize.x - viewport.rect.width / content.localScale.x;
			float num9 = (float)padding2.left + (float)num7 * (width + vector.x);
			if (atCenter)
			{
				num9 -= (viewport.rect.width / content.localScale.x - width) / 2f;
			}
			num3 = num9 / num8;
		}
		num3 += 0.0001f;
		if (num3 < 0f)
		{
			num3 = 0f;
		}
		if (num3 > 1f)
		{
			num3 = 1f;
		}
		if (uiList.IsVertical())
		{
			num3 = 1f - num3;
		}
		return num3;
	}

	public static Vector2 GetContentSize(UIScroller uiList, int itemNum)
	{
		if (uiList.ItemPrefab == null)
		{
			return Vector2.zero;
		}
		Rect rect = (uiList.ItemPrefab.transform as RectTransform).rect;
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
		int num2 = 1;
		int num3 = 1;
		RectTransform viewport = uiList._viewport;
		if (uiList.Orientation == UIScrollerOrientation.SingleHorizontal)
		{
			HorizontalLayoutGroup component = uiList.content.GetComponent<HorizontalLayoutGroup>();
			Vector2 vector = new Vector2(component.spacing, 0f);
			RectOffset padding = component.padding;
			int num4 = ((itemNum == 0) ? 1 : ((itemNum - 1) / num2 + 1));
			sizeDelta.x = (float)(padding.left + padding.right) + (float)num4 * rect.width + (float)(num4 - 1) * vector.x;
			sizeDelta.y = viewport.rect.height / content.localScale.y;
			if (sizeDelta.x < uiList._viewport.rect.width)
			{
				sizeDelta.x = uiList._viewport.rect.width + num;
			}
		}
		else if (uiList.Orientation == UIScrollerOrientation.SingleVertical)
		{
			VerticalLayoutGroup component2 = uiList.content.GetComponent<VerticalLayoutGroup>();
			Vector2 vector = new Vector2(0f, component2.spacing);
			RectOffset padding = component2.padding;
			int num5 = ((itemNum == 0) ? 1 : ((itemNum - 1) / num3 + 1));
			sizeDelta.x = viewport.rect.width / content.localScale.x;
			sizeDelta.y = (float)(padding.top + padding.bottom) + (float)num5 * rect.height + (float)(num5 - 1) * vector.y;
			if (sizeDelta.y < uiList._viewport.rect.height)
			{
				sizeDelta.y = uiList._viewport.rect.height + num;
			}
		}
		return sizeDelta;
	}
}
