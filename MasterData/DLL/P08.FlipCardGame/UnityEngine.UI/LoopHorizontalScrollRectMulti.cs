namespace UnityEngine.UI;

[AddComponentMenu("UI/Loop Horizontal Scroll Rect(MultiPrefab)", 52)]
[DisallowMultipleComponent]
public class LoopHorizontalScrollRectMulti : LoopScrollRectMulti
{
	private LoopHorizontalScrollRectMulti()
	{
		direction = LoopScrollRectDirection.Horizontal;
	}

	protected override float GetSize(RectTransform item, bool includeSpacing)
	{
		float num = (includeSpacing ? base.contentSpacing : 0f);
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
		base.Awake();
		if ((bool)m_Content)
		{
			GridLayoutGroup component = m_Content.GetComponent<GridLayoutGroup>();
			if (component != null && component.constraint != GridLayoutGroup.Constraint.FixedRowCount)
			{
				Debug.LogError("[LoopScrollRect] unsupported GridLayoutGroup constraint");
			}
		}
	}

	protected override bool UpdateItems(ref Bounds viewBounds, ref Bounds contentBounds)
	{
		bool flag = false;
		if (viewBounds.size.x < contentBounds.min.x - viewBounds.max.x && itemTypeEnd > itemTypeStart)
		{
			float x = contentBounds.size.x;
			float num = (x - base.contentSpacing * (float)(base.CurrentLines - 1)) / (float)base.CurrentLines;
			ReturnToTempPool(fromStart: false, itemTypeEnd - itemTypeStart);
			itemTypeEnd = itemTypeStart;
			int num2 = Mathf.FloorToInt((contentBounds.min.x - viewBounds.max.x) / (num + base.contentSpacing));
			if (totalCount >= 0 && itemTypeStart - num2 * base.contentConstraintCount < 0)
			{
				num2 = Mathf.FloorToInt((float)itemTypeStart / (float)base.contentConstraintCount);
			}
			itemTypeStart -= num2 * base.contentConstraintCount;
			if (totalCount >= 0)
			{
				itemTypeStart = Mathf.Max(itemTypeStart, 0);
			}
			itemTypeEnd = itemTypeStart;
			float num3 = (float)num2 * (num + base.contentSpacing);
			m_Content.anchoredPosition -= new Vector2(num3 + (reverseDirection ? x : 0f), 0f);
			contentBounds.center -= new Vector3(num3 + x / 2f, 0f, 0f);
			contentBounds.size = Vector3.zero;
			flag = true;
		}
		if (viewBounds.min.x - contentBounds.max.x > viewBounds.size.x && itemTypeEnd > itemTypeStart)
		{
			int num4 = -1;
			if (totalCount >= 0)
			{
				num4 = Mathf.Max(0, totalCount - (itemTypeEnd - itemTypeStart));
				num4 = num4 / base.contentConstraintCount * base.contentConstraintCount;
			}
			float x2 = contentBounds.size.x;
			float num5 = (x2 - base.contentSpacing * (float)(base.CurrentLines - 1)) / (float)base.CurrentLines;
			ReturnToTempPool(fromStart: true, itemTypeEnd - itemTypeStart);
			itemTypeStart = itemTypeEnd;
			int num6 = Mathf.FloorToInt((viewBounds.min.x - contentBounds.max.x) / (num5 + base.contentSpacing));
			if (num4 >= 0 && itemTypeStart + num6 * base.contentConstraintCount > num4)
			{
				num6 = Mathf.FloorToInt((float)(num4 - itemTypeStart) / (float)base.contentConstraintCount);
			}
			itemTypeStart += num6 * base.contentConstraintCount;
			if (totalCount >= 0)
			{
				itemTypeStart = Mathf.Max(itemTypeStart, 0);
			}
			itemTypeEnd = itemTypeStart;
			float num7 = (float)num6 * (num5 + base.contentSpacing);
			m_Content.anchoredPosition += new Vector2(num7 + (reverseDirection ? 0f : x2), 0f);
			contentBounds.center += new Vector3(num7 + x2 / 2f, 0f, 0f);
			contentBounds.size = Vector3.zero;
			flag = true;
		}
		if (viewBounds.max.x > contentBounds.max.x - m_ContentRightPadding)
		{
			float num8 = NewItemAtEnd();
			float num9 = num8;
			while (num8 > 0f && viewBounds.max.x > contentBounds.max.x - m_ContentRightPadding + num9)
			{
				num8 = NewItemAtEnd();
				num9 += num8;
			}
			if (num9 > 0f)
			{
				flag = true;
			}
		}
		if (viewBounds.min.x < contentBounds.min.x + m_ContentLeftPadding)
		{
			float num10 = NewItemAtStart();
			float num11 = num10;
			while (num10 > 0f && viewBounds.min.x < contentBounds.min.x + m_ContentLeftPadding - num11)
			{
				num10 = NewItemAtStart();
				num11 += num10;
			}
			if (num11 > 0f)
			{
				flag = true;
			}
		}
		if (viewBounds.max.x < contentBounds.max.x - threshold - m_ContentRightPadding)
		{
			float num12 = DeleteItemAtEnd();
			float num13 = num12;
			while (num12 > 0f && viewBounds.max.x < contentBounds.max.x - threshold - m_ContentRightPadding - num13)
			{
				num12 = DeleteItemAtEnd();
				num13 += num12;
			}
			if (num13 > 0f)
			{
				flag = true;
			}
		}
		if (viewBounds.min.x > contentBounds.min.x + threshold + m_ContentLeftPadding)
		{
			float num14 = DeleteItemAtStart();
			float num15 = num14;
			while (num14 > 0f && viewBounds.min.x > contentBounds.min.x + threshold + m_ContentLeftPadding + num15)
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
