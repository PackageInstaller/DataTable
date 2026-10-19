using System;

namespace UnityEngine.UI;

[AddComponentMenu("UI/Loop Horizontal Scroll Rect", 50)]
[DisallowMultipleComponent]
public class LoopHorizontalScrollRect : LoopScrollRect
{
	protected override float GetSize(RectTransform item, bool includeSpacing)
	{
		float num = (includeSpacing ? contentSpacing : 0f);
		num = ((!(m_GridLayout != null)) ? (num + LayoutUtility.GetPreferredWidth(item)) : (num + m_GridLayout.cellSize.x));
		return num * m_Content.localScale.x;
	}

	protected override float GetDimension(Vector2 vector)
	{
		return 0f - vector.x;
	}

	protected override float GetAbsDimension(Vector2 vector)
	{
		return vector.x;
	}

	protected override Vector2 GetVector(float value)
	{
		return new Vector2(0f - value, 0f);
	}

	protected override void Awake()
	{
		direction = LoopScrollRectDirection.Horizontal;
		base.Awake();
	}

	protected override void OnEnable()
	{
		if ((bool)m_Content)
		{
			GridLayoutGroup component = m_Content.GetComponent<GridLayoutGroup>();
			if (component != null && component.constraint != GridLayoutGroup.Constraint.FixedRowCount)
			{
				Debug.LogWarning("[LoopScrollRect] unsupported GridLayoutGroup constraint!");
			}
		}
	}

	protected override bool UpdateItems(ref Bounds viewBounds, ref Bounds contentBounds)
	{
		CheckBound();
		CheckCenterBound();
		bool flag = false;
		Bounds bounds = new Bounds(viewBounds.center, viewBounds.size + viewPortExtends);
		if (bounds.size.x < contentBounds.min.x - bounds.max.x && itemTypeEnd > itemTypeStart)
		{
			float x = contentBounds.size.x;
			float num = (x - contentSpacing * (float)(CurrentLines - 1)) / (float)CurrentLines;
			ReturnToTempPool(fromStart: false, itemTypeEnd - itemTypeStart);
			itemTypeEnd = itemTypeStart;
			int num2 = Mathf.FloorToInt((contentBounds.min.x - bounds.max.x) / (num + contentSpacing));
			if (totalCount >= 0 && itemTypeStart - num2 * contentConstraintCount < 0)
			{
				num2 = Mathf.FloorToInt((float)itemTypeStart / (float)contentConstraintCount);
			}
			itemTypeStart -= num2 * contentConstraintCount;
			if (totalCount >= 0)
			{
				itemTypeStart = Mathf.Max(itemTypeStart, 0);
			}
			itemTypeEnd = itemTypeStart;
			float num3 = (float)num2 * (num + contentSpacing);
			m_Content.anchoredPosition -= new Vector2(num3 + (reverseDirection ? x : 0f), 0f);
			contentBounds.center -= new Vector3(num3 + x / 2f, 0f, 0f);
			contentBounds.size = Vector3.zero;
			flag = true;
		}
		if (bounds.min.x - contentBounds.max.x > bounds.size.x && itemTypeEnd > itemTypeStart)
		{
			int num4 = -1;
			if (totalCount >= 0)
			{
				num4 = Mathf.Max(0, totalCount - (itemTypeEnd - itemTypeStart));
				num4 = num4 / contentConstraintCount * contentConstraintCount;
			}
			float x2 = contentBounds.size.x;
			float num5 = (x2 - contentSpacing * (float)(CurrentLines - 1)) / (float)CurrentLines;
			ReturnToTempPool(fromStart: true, itemTypeEnd - itemTypeStart);
			itemTypeStart = itemTypeEnd;
			int num6 = Mathf.FloorToInt((bounds.min.x - contentBounds.max.x) / (num5 + contentSpacing));
			if (num4 >= 0 && itemTypeStart + num6 * contentConstraintCount > num4)
			{
				num6 = Mathf.FloorToInt((float)(num4 - itemTypeStart) / (float)contentConstraintCount);
			}
			itemTypeStart += num6 * contentConstraintCount;
			if (totalCount >= 0)
			{
				itemTypeStart = Mathf.Max(itemTypeStart, 0);
			}
			itemTypeEnd = itemTypeStart;
			float num7 = (float)num6 * (num5 + contentSpacing);
			m_Content.anchoredPosition += new Vector2(num7 + (reverseDirection ? 0f : x2), 0f);
			contentBounds.center += new Vector3(num7 + x2 / 2f, 0f, 0f);
			contentBounds.size = Vector3.zero;
			flag = true;
		}
		if (bounds.max.x > contentBounds.max.x - m_ContentRightPadding)
		{
			float num8 = NewItemAtEnd();
			float num9 = num8;
			while (num8 > 0f && bounds.max.x > contentBounds.max.x - m_ContentRightPadding + num9)
			{
				num8 = NewItemAtEnd();
				num9 += num8;
			}
			if (num9 > 0f)
			{
				flag = true;
			}
		}
		if (bounds.min.x < contentBounds.min.x + m_ContentLeftPadding)
		{
			float num10 = NewItemAtStart();
			float num11 = num10;
			while (num10 > 0f && bounds.min.x < contentBounds.min.x + m_ContentLeftPadding - num11)
			{
				num10 = NewItemAtStart();
				num11 += num10;
			}
			if (num11 > 0f)
			{
				flag = true;
			}
		}
		if (bounds.max.x < contentBounds.max.x - threshold - m_ContentRightPadding)
		{
			float num12 = DeleteItemAtEnd();
			float num13 = num12;
			while (num12 > 0f && bounds.max.x < contentBounds.max.x - threshold - m_ContentRightPadding - num13)
			{
				num12 = DeleteItemAtEnd();
				num13 += num12;
			}
			if (num13 > 0f)
			{
				flag = true;
			}
		}
		if (bounds.min.x > contentBounds.min.x + threshold + m_ContentLeftPadding)
		{
			float num14 = DeleteItemAtStart();
			float num15 = num14;
			while (num14 > 0f && bounds.min.x > contentBounds.min.x + threshold + m_ContentLeftPadding + num15)
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

	protected override void SetContentToIndex(int index)
	{
		throw new NotImplementedException();
	}

	public bool TryGetRightBoundCenterItem(out ILoopScrollDataSource item, out bool centerInside)
	{
		item = null;
		centerInside = false;
		if (m_Content == null || m_CachedAvailableRect == null || m_CachedAvailableRect.Count <= 0)
		{
			return false;
		}
		Vector3[] array = new Vector3[4];
		viewRect.GetWorldCorners(array);
		float num = RectTransformUtility.WorldToScreenPoint(m_UICamera, array[2]).x + m_ContentRightPadding;
		Vector3[] array2 = new Vector3[4];
		RectTransform rectTransform = null;
		float num2 = 0f;
		for (int i = 0; i < m_CachedAvailableRect.Count; i++)
		{
			RectTransform rectTransform2 = m_CachedAvailableRect[i];
			if ((bool)rectTransform2)
			{
				rectTransform2.GetWorldCorners(array2);
				float x = RectTransformUtility.WorldToScreenPoint(m_UICamera, array2[1]).x;
				float x2 = RectTransformUtility.WorldToScreenPoint(m_UICamera, array2[2]).x;
				if (x <= num)
				{
					rectTransform = rectTransform2;
					num2 = (x + x2) * 0.5f;
				}
			}
		}
		if (rectTransform == null)
		{
			return false;
		}
		item = rectTransform.GetComponent<ILoopScrollDataSource>();
		centerInside = num2 <= num;
		return item != null;
	}

	private void CheckCenterBound()
	{
		if (m_Content == null || m_CachedAvailableRect.Count <= 0)
		{
			return;
		}
		Vector3[] array = new Vector3[4];
		viewRect.GetWorldCorners(array);
		float num = RectTransformUtility.WorldToScreenPoint(m_UICamera, array[1]).x - m_ContentLeftPadding;
		float num2 = RectTransformUtility.WorldToScreenPoint(m_UICamera, array[2]).x + m_ContentRightPadding;
		Vector3[] array2 = new Vector3[4];
		RectTransform rectTransform = null;
		float num3 = 0f;
		RectTransform rectTransform2 = null;
		float num4 = 0f;
		for (int i = 0; i < m_CachedAvailableRect.Count; i++)
		{
			RectTransform rectTransform3 = m_CachedAvailableRect[i];
			if ((bool)rectTransform3)
			{
				rectTransform3.GetWorldCorners(array2);
				float x = RectTransformUtility.WorldToScreenPoint(m_UICamera, array2[1]).x;
				float x2 = RectTransformUtility.WorldToScreenPoint(m_UICamera, array2[2]).x;
				float num5 = (x + x2) * 0.5f;
				if (rectTransform == null && x2 >= num)
				{
					rectTransform = rectTransform3;
					num3 = num5;
				}
				if (x <= num2)
				{
					rectTransform2 = rectTransform3;
					num4 = num5;
				}
			}
		}
		if (rectTransform != null)
		{
			bool flag = num3 >= num;
			ILoopScrollDataSource component = rectTransform.GetComponent<ILoopScrollDataSource>();
			if (component != m_LastCenterReachBoundItem || flag != m_LastCenterInsideStart)
			{
				m_LastCenterReachBoundItem = component;
				m_LastCenterInsideStart = flag;
				OnItemCenterReachBound?.Invoke(component, ReachBoundDirection.Left, flag);
			}
		}
		if (rectTransform2 != null)
		{
			bool flag2 = num4 <= num2;
			ILoopScrollDataSource component2 = rectTransform2.GetComponent<ILoopScrollDataSource>();
			if (component2 != m_LastCenterReachBoundItemEnd || flag2 != m_LastCenterInsideEnd)
			{
				m_LastCenterReachBoundItemEnd = component2;
				m_LastCenterInsideEnd = flag2;
				OnItemCenterReachBound?.Invoke(component2, ReachBoundDirection.Right, flag2);
			}
		}
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
			if (!rectTransform)
			{
				continue;
			}
			Vector3[] array = new Vector3[4];
			Vector3[] array2 = new Vector3[4];
			rectTransform.GetWorldCorners(array);
			viewRect.GetWorldCorners(array2);
			float x = RectTransformUtility.WorldToScreenPoint(m_UICamera, array[1]).x;
			float x2 = RectTransformUtility.WorldToScreenPoint(m_UICamera, array[2]).x;
			float num = RectTransformUtility.WorldToScreenPoint(m_UICamera, array2[1]).x - m_ContentLeftPadding;
			float num2 = RectTransformUtility.WorldToScreenPoint(m_UICamera, array2[2]).x + m_ContentRightPadding;
			if ((x - num) * (x2 - num) <= 0f)
			{
				ILoopScrollDataSource component = rectTransform.GetComponent<ILoopScrollDataSource>();
				if (component != m_LastReachBoundItem)
				{
					m_LastReachBoundItem = component;
					OnItemReachBound?.Invoke(component, ReachBoundDirection.Left);
				}
			}
			if ((x - num2) * (x2 - num2) <= 0f)
			{
				ILoopScrollDataSource component2 = rectTransform.GetComponent<ILoopScrollDataSource>();
				if (component2 != m_LastReachBoundItemEnd)
				{
					m_LastReachBoundItemEnd = component2;
					OnItemReachBound?.Invoke(component2, ReachBoundDirection.Right);
				}
			}
		}
	}
}
