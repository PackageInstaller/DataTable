using System;

namespace UnityEngine.UI;

[AddComponentMenu("UI/Loop Vertical Scroll Rect(MultiPrefab)", 53)]
[DisallowMultipleComponent]
public class LoopVerticalScrollRectMulti : LoopScrollRectMulti
{
	protected override float GetSize(RectTransform item, bool includeSpacing)
	{
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
				Debug.LogError("[LoopScrollRect] unsupported GridLayoutGroup constraint");
			}
		}
	}

	protected override void ProvideData(ILoopScrollDataSource transform, int index)
	{
		throw new NotImplementedException();
	}

	protected override void OnItemLoaded(ILoopScrollDataSource transform, int index)
	{
		throw new NotImplementedException();
	}

	protected override void OnItemUnLoaded(ILoopScrollDataSource transform, int index)
	{
		throw new NotImplementedException();
	}

	protected GameObject GetObject(int index)
	{
		throw new NotImplementedException();
	}

	protected override void ReturnObject(GameObject trans)
	{
		throw new NotImplementedException();
	}

	protected override bool UpdateItems(ref Bounds viewBounds, ref Bounds contentBounds)
	{
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

	protected override void SetContentToIndex(int index)
	{
		throw new NotImplementedException();
	}
}
