using System;

namespace UnityEngine.UI;

[AddComponentMenu("UI/Loop Vertical Scroll Rect", 51)]
[DisallowMultipleComponent]
public class LoopVerticalScrollRect : LoopScrollRect
{
	protected override float GetSize(RectTransform item, bool includeSpacing)
	{
		LayoutElement layoutElement = ((item != null) ? item.GetComponent<LayoutElement>() : null);
		if (layoutElement != null && (layoutElement.ignoreLayout || layoutElement.preferredHeight == 0f))
		{
			return 0f;
		}
		float num = (includeSpacing ? contentSpacing : 0f);
		num = ((!(m_GridLayout != null)) ? (num + LayoutUtility.GetPreferredHeight(item)) : (num + m_GridLayout.cellSize.y));
		return num * m_Content.localScale.y;
	}

	protected override float GetDimension(Vector2 vector)
	{
		return vector.y;
	}

	protected override float GetAbsDimension(Vector2 vector)
	{
		return vector.y;
	}

	protected override Vector2 GetVector(float value)
	{
		return new Vector2(0f, value);
	}

	protected override void Awake()
	{
		direction = LoopScrollRectDirection.Vertical;
		base.Awake();
		if ((bool)m_Content)
		{
			GridLayoutGroup component = m_Content.GetComponent<GridLayoutGroup>();
			if (component != null && component.constraint != GridLayoutGroup.Constraint.FixedColumnCount)
			{
				Debug.LogWarning("[LoopScrollRect] unsupported GridLayoutGroup constraint!");
			}
		}
	}

	protected override void SetContentToIndex(int index)
	{
		throw new NotImplementedException();
	}

	protected override bool UpdateItems(ref Bounds viewBounds, ref Bounds contentBounds)
	{
		CheckBound();
		bool flag = false;
		Bounds bounds = new Bounds(viewBounds.center, viewBounds.size + viewPortExtends);
		if (bounds.size.y < contentBounds.min.y - bounds.max.y && itemTypeEnd > itemTypeStart)
		{
			int num = -1;
			if (totalCount >= 0)
			{
				num = Mathf.Max(0, totalCount - (itemTypeEnd - itemTypeStart));
			}
			float y = contentBounds.size.y;
			float num2 = (y - contentSpacing * (float)(CurrentLines - 1)) / (float)CurrentLines;
			ReturnToTempPool(fromStart: true, itemTypeEnd - itemTypeStart);
			itemTypeStart = itemTypeEnd;
			int num3 = Mathf.FloorToInt((contentBounds.min.y - bounds.max.y) / (num2 + contentSpacing));
			if (num >= 0 && itemTypeStart + num3 * contentConstraintCount > num)
			{
				num3 = Mathf.FloorToInt((float)(num - itemTypeStart) / (float)contentConstraintCount);
			}
			itemTypeStart += num3 * contentConstraintCount;
			if (totalCount >= 0)
			{
				itemTypeStart = Mathf.Max(itemTypeStart, 0);
			}
			itemTypeEnd = itemTypeStart;
			float num4 = (float)num3 * (num2 + contentSpacing);
			m_Content.anchoredPosition -= new Vector2(0f, num4 + (reverseDirection ? 0f : y));
			contentBounds.center -= new Vector3(0f, num4 + y / 2f, 0f);
			contentBounds.size = Vector3.zero;
			flag = true;
		}
		if (bounds.min.y - contentBounds.max.y > bounds.size.y && itemTypeEnd > itemTypeStart)
		{
			float y2 = contentBounds.size.y;
			float num5 = (y2 - contentSpacing * (float)(CurrentLines - 1)) / (float)CurrentLines;
			ReturnToTempPool(fromStart: false, itemTypeEnd - itemTypeStart);
			itemTypeEnd = itemTypeStart;
			int num6 = Mathf.FloorToInt((bounds.min.y - contentBounds.max.y) / (num5 + contentSpacing));
			if (totalCount >= 0 && itemTypeStart - num6 * contentConstraintCount < 0)
			{
				num6 = Mathf.FloorToInt((float)itemTypeStart / (float)contentConstraintCount);
			}
			itemTypeStart -= num6 * contentConstraintCount;
			if (totalCount >= 0)
			{
				itemTypeStart = Mathf.Max(itemTypeStart, 0);
			}
			itemTypeEnd = itemTypeStart;
			float num7 = (float)num6 * (num5 + contentSpacing);
			m_Content.anchoredPosition += new Vector2(0f, num7 + (reverseDirection ? y2 : 0f));
			contentBounds.center += new Vector3(0f, num7 + y2 / 2f, 0f);
			contentBounds.size = Vector3.zero;
			flag = true;
		}
		if (bounds.min.y < contentBounds.min.y + m_ContentBottomPadding)
		{
			float num8 = NewItemAtEnd();
			float num9 = num8;
			while (num8 > 0f && bounds.min.y < contentBounds.min.y + m_ContentBottomPadding - num9)
			{
				num8 = NewItemAtEnd();
				num9 += num8;
			}
			if (num9 > 0f)
			{
				flag = true;
			}
		}
		if (bounds.max.y > contentBounds.max.y - m_ContentTopPadding)
		{
			float num10 = NewItemAtStart();
			float num11 = num10;
			while (num10 > 0f && bounds.max.y > contentBounds.max.y - m_ContentTopPadding + num11)
			{
				num10 = NewItemAtStart();
				num11 += num10;
			}
			if (num11 > 0f)
			{
				flag = true;
			}
		}
		if (bounds.min.y > contentBounds.min.y + threshold + m_ContentBottomPadding)
		{
			float num12 = DeleteItemAtEnd();
			float num13 = num12;
			while (num12 > 0f && bounds.min.y > contentBounds.min.y + threshold + m_ContentBottomPadding + num13)
			{
				num12 = DeleteItemAtEnd();
				num13 += num12;
			}
			if (num13 > 0f)
			{
				flag = true;
			}
		}
		if (bounds.max.y < contentBounds.max.y - threshold - m_ContentTopPadding)
		{
			float num14 = DeleteItemAtStart();
			float num15 = num14;
			while (num14 > 0f && bounds.max.y < contentBounds.max.y - threshold - m_ContentTopPadding - num15)
			{
				num14 = DeleteItemAtStart();
				num15 += num14;
			}
			if (num15 > 0f)
			{
				flag = true;
			}
		}
		if (flag)
		{
			ClearTempPool();
		}
		return flag;
	}

	private void CheckBound()
	{
		if (m_Content == null || m_CachedAvailableRect.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < m_CachedAvailableRect.Count; i++)
		{
			RectTransform rectTransform = m_CachedAvailableRect[i];
			if (!rectTransform || !rectTransform.gameObject.activeInHierarchy)
			{
				continue;
			}
			LayoutElement component = rectTransform.GetComponent<LayoutElement>();
			if ((component != null && component.ignoreLayout) || rectTransform.rect.height <= 0.01f)
			{
				continue;
			}
			Vector3[] array = new Vector3[4];
			Vector3[] array2 = new Vector3[4];
			rectTransform.GetWorldCorners(array);
			viewRect.GetWorldCorners(array2);
			float y = RectTransformUtility.WorldToScreenPoint(m_UICamera, array[1]).y;
			float y2 = RectTransformUtility.WorldToScreenPoint(m_UICamera, array[0]).y;
			float num = RectTransformUtility.WorldToScreenPoint(m_UICamera, array2[1]).y - m_ContentTopPadding;
			float num2 = RectTransformUtility.WorldToScreenPoint(m_UICamera, array2[0]).y + m_ContentBottomPadding;
			if (Mathf.Abs(y - y2) <= 0.01f)
			{
				continue;
			}
			if ((y - num) * (y2 - num) <= 0f)
			{
				ILoopScrollDataSource component2 = rectTransform.GetComponent<ILoopScrollDataSource>();
				if (component2 != m_LastReachBoundItem)
				{
					m_LastReachBoundItem = component2;
					OnItemReachBound?.Invoke(component2, ReachBoundDirection.Up);
				}
			}
			if ((y - num2) * (y2 - num2) <= 0f)
			{
				ILoopScrollDataSource component3 = rectTransform.GetComponent<ILoopScrollDataSource>();
				if (component3 != m_LastReachBoundItemEnd)
				{
					m_LastReachBoundItemEnd = component3;
					OnItemReachBound?.Invoke(component3, ReachBoundDirection.Down);
				}
			}
		}
	}
}
