namespace UnityEngine.UI;

[AddComponentMenu("UI/Loop Vertical Scroll Rect(MultiPrefab)", 53)]
[DisallowMultipleComponent]
public class LoopVerticalScrollRectMulti : LoopScrollRectMulti
{
	private LoopVerticalScrollRectMulti()
	{
		direction = LoopScrollRectDirection.Vertical;
	}

	protected override float GetSize(RectTransform item, bool includeSpacing)
	{
		float num = (includeSpacing ? base.contentSpacing : 0f);
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

	protected override bool UpdateItems(ref Bounds viewBounds, ref Bounds contentBounds)
	{
		bool flag = false;
		if (viewBounds.size.y < contentBounds.min.y - viewBounds.max.y && itemTypeEnd > itemTypeStart)
		{
			int num = -1;
			if (totalCount >= 0)
			{
				num = Mathf.Max(0, totalCount - (itemTypeEnd - itemTypeStart));
			}
			float y = contentBounds.size.y;
			float num2 = (y - base.contentSpacing * (float)(base.CurrentLines - 1)) / (float)base.CurrentLines;
			ReturnToTempPool(fromStart: true, itemTypeEnd - itemTypeStart);
			itemTypeStart = itemTypeEnd;
			int num3 = Mathf.FloorToInt((contentBounds.min.y - viewBounds.max.y) / (num2 + base.contentSpacing));
			if (num >= 0 && itemTypeStart + num3 * base.contentConstraintCount > num)
			{
				num3 = Mathf.FloorToInt((float)(num - itemTypeStart) / (float)base.contentConstraintCount);
			}
			itemTypeStart += num3 * base.contentConstraintCount;
			if (totalCount >= 0)
			{
				itemTypeStart = Mathf.Max(itemTypeStart, 0);
			}
			itemTypeEnd = itemTypeStart;
			float num4 = (float)num3 * (num2 + base.contentSpacing);
			m_Content.anchoredPosition -= new Vector2(0f, num4 + (reverseDirection ? 0f : y));
			contentBounds.center -= new Vector3(0f, num4 + y / 2f, 0f);
			contentBounds.size = Vector3.zero;
			flag = true;
		}
		if (viewBounds.min.y - contentBounds.max.y > viewBounds.size.y && itemTypeEnd > itemTypeStart)
		{
			float y2 = contentBounds.size.y;
			float num5 = (y2 - base.contentSpacing * (float)(base.CurrentLines - 1)) / (float)base.CurrentLines;
			ReturnToTempPool(fromStart: false, itemTypeEnd - itemTypeStart);
			itemTypeEnd = itemTypeStart;
			int num6 = Mathf.FloorToInt((viewBounds.min.y - contentBounds.max.y) / (num5 + base.contentSpacing));
			if (totalCount >= 0 && itemTypeStart - num6 * base.contentConstraintCount < 0)
			{
				num6 = Mathf.FloorToInt((float)itemTypeStart / (float)base.contentConstraintCount);
			}
			itemTypeStart -= num6 * base.contentConstraintCount;
			if (totalCount >= 0)
			{
				itemTypeStart = Mathf.Max(itemTypeStart, 0);
			}
			itemTypeEnd = itemTypeStart;
			float num7 = (float)num6 * (num5 + base.contentSpacing);
			m_Content.anchoredPosition += new Vector2(0f, num7 + (reverseDirection ? y2 : 0f));
			contentBounds.center += new Vector3(0f, num7 + y2 / 2f, 0f);
			contentBounds.size = Vector3.zero;
			flag = true;
		}
		if (viewBounds.min.y < contentBounds.min.y + m_ContentBottomPadding)
		{
			float num8 = NewItemAtEnd();
			float num9 = num8;
			while (num8 > 0f && viewBounds.min.y < contentBounds.min.y + m_ContentBottomPadding - num9)
			{
				num8 = NewItemAtEnd();
				num9 += num8;
			}
			if (num9 > 0f)
			{
				flag = true;
			}
		}
		if (viewBounds.max.y > contentBounds.max.y - m_ContentTopPadding)
		{
			float num10 = NewItemAtStart();
			float num11 = num10;
			while (num10 > 0f && viewBounds.max.y > contentBounds.max.y - m_ContentTopPadding + num11)
			{
				num10 = NewItemAtStart();
				num11 += num10;
			}
			if (num11 > 0f)
			{
				flag = true;
			}
		}
		if (viewBounds.min.y > contentBounds.min.y + threshold + m_ContentBottomPadding)
		{
			float num12 = DeleteItemAtEnd();
			float num13 = num12;
			while (num12 > 0f && viewBounds.min.y > contentBounds.min.y + threshold + m_ContentBottomPadding + num13)
			{
				num12 = DeleteItemAtEnd();
				num13 += num12;
			}
			if (num13 > 0f)
			{
				flag = true;
			}
		}
		if (viewBounds.max.y < contentBounds.max.y - threshold - m_ContentTopPadding)
		{
			float num14 = DeleteItemAtStart();
			float num15 = num14;
			while (num14 > 0f && viewBounds.max.y < contentBounds.max.y - threshold - m_ContentTopPadding - num15)
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
}
