using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

[AddComponentMenu("Layout/Extensions/Flow Layout Group")]
public class FlowLayoutGroup : LayoutGroup
{
	public enum Axis
	{
		Horizontal,
		Vertical
	}

	private float _layoutHeight;

	private float _layoutWidth;

	public float SpacingX;

	public float SpacingY;

	public bool ExpandHorizontalSpacing;

	public bool ChildForceExpandWidth;

	public bool ChildForceExpandHeight;

	public bool invertOrder;

	[SerializeField]
	protected Axis m_StartAxis;

	private readonly IList<RectTransform> _itemList = new List<RectTransform>();

	public Axis StartAxis
	{
		get
		{
			return m_StartAxis;
		}
		set
		{
			SetProperty(ref m_StartAxis, value);
		}
	}

	protected bool IsCenterAlign
	{
		get
		{
			if (childAlignment != TextAnchor.LowerCenter && childAlignment != TextAnchor.MiddleCenter)
			{
				return childAlignment == TextAnchor.UpperCenter;
			}
			return true;
		}
	}

	protected bool IsRightAlign
	{
		get
		{
			if (childAlignment != TextAnchor.LowerRight && childAlignment != TextAnchor.MiddleRight)
			{
				return childAlignment == TextAnchor.UpperRight;
			}
			return true;
		}
	}

	protected bool IsMiddleAlign
	{
		get
		{
			if (childAlignment != TextAnchor.MiddleLeft && childAlignment != TextAnchor.MiddleRight)
			{
				return childAlignment == TextAnchor.MiddleCenter;
			}
			return true;
		}
	}

	protected bool IsLowerAlign
	{
		get
		{
			if (childAlignment != TextAnchor.LowerLeft && childAlignment != TextAnchor.LowerRight)
			{
				return childAlignment == TextAnchor.LowerCenter;
			}
			return true;
		}
	}

	public override void CalculateLayoutInputHorizontal()
	{
		if (StartAxis == Axis.Horizontal)
		{
			base.CalculateLayoutInputHorizontal();
			float totalMin = GetGreatestMinimumChildWidth() + (float)padding.left + (float)padding.right;
			SetLayoutInputForAxis(totalMin, -1f, -1f, 0);
		}
		else
		{
			_layoutWidth = SetLayout(0, layoutInput: true);
		}
	}

	public override void SetLayoutHorizontal()
	{
		SetLayout(0, layoutInput: false);
	}

	public override void SetLayoutVertical()
	{
		SetLayout(1, layoutInput: false);
	}

	public override void CalculateLayoutInputVertical()
	{
		if (StartAxis == Axis.Horizontal)
		{
			_layoutHeight = SetLayout(1, layoutInput: true);
			return;
		}
		base.CalculateLayoutInputHorizontal();
		float totalMin = GetGreatestMinimumChildHeigth() + (float)padding.bottom + (float)padding.top;
		SetLayoutInputForAxis(totalMin, -1f, -1f, 1);
	}

	public float SetLayout(int axis, bool layoutInput)
	{
		float height = base.rectTransform.rect.height;
		float width = base.rectTransform.rect.width;
		float num = 0f;
		float num2 = 0f;
		float num3 = 0f;
		float num4 = 0f;
		float num5 = 0f;
		float num6 = 0f;
		if (StartAxis == Axis.Horizontal)
		{
			num5 = height;
			num6 = width - (float)padding.left - (float)padding.right;
			if (IsLowerAlign)
			{
				num3 = padding.bottom;
				num4 = padding.top;
			}
			else
			{
				num3 = padding.top;
				num4 = padding.bottom;
			}
			num = SpacingY;
			num2 = SpacingX;
		}
		else if (StartAxis == Axis.Vertical)
		{
			num5 = width;
			num6 = height - (float)padding.top - (float)padding.bottom;
			if (IsRightAlign)
			{
				num3 = padding.right;
				num4 = padding.left;
			}
			else
			{
				num3 = padding.left;
				num4 = padding.right;
			}
			num = SpacingX;
			num2 = SpacingY;
		}
		float num7 = 0f;
		float num8 = 0f;
		float num9 = 0f;
		float num10 = 0f;
		float num11 = 0f;
		float num12 = 0f;
		float num13 = 0f;
		for (int i = 0; i < rectChildren.Count; i++)
		{
			int index = i;
			RectTransform rectTransform = rectChildren[index];
			float num14 = 0f;
			float num15 = 0f;
			if (StartAxis == Axis.Horizontal)
			{
				if (invertOrder)
				{
					index = (IsLowerAlign ? (rectChildren.Count - 1 - i) : i);
				}
				rectTransform = rectChildren[index];
				num14 = LayoutUtility.GetPreferredSize(rectTransform, 0);
				num14 = Mathf.Min(num14, num6);
				num15 = LayoutUtility.GetPreferredSize(rectTransform, 1);
			}
			else if (StartAxis == Axis.Vertical)
			{
				if (invertOrder)
				{
					index = (IsRightAlign ? (rectChildren.Count - 1 - i) : i);
				}
				rectTransform = rectChildren[index];
				num14 = LayoutUtility.GetPreferredSize(rectTransform, 1);
				num14 = Mathf.Min(num14, num6);
				num15 = LayoutUtility.GetPreferredSize(rectTransform, 0);
			}
			if (num7 + num14 > num6)
			{
				num7 -= num2;
				if (!layoutInput)
				{
					if (StartAxis == Axis.Horizontal)
					{
						float yOffset = CalculateRowVerticalOffset(num5, num3, num8);
						LayoutRow(_itemList, num7, num8, num6, (float)padding.left + num11, yOffset, axis);
					}
					else if (StartAxis == Axis.Vertical)
					{
						float xOffset = CalculateColHorizontalOffset(num5, num3, num8);
						LayoutCol(_itemList, num8, num7, num6, xOffset, padding.top, axis);
					}
				}
				_itemList.Clear();
				num3 += num8;
				num3 += num;
				num12 += num15;
				if (num12 > num10)
				{
					num13 += Mathf.Max(num10, num8);
					num7 = (num11 = (num9 = (num12 = (num10 = 0f))));
				}
				else
				{
					num11 = (num7 = num9);
				}
				num8 = 0f;
			}
			if (num8 != num15)
			{
				if (num8 - num15 > 0f)
				{
					num9 = num7;
					num10 = num8;
					num12 = num15;
				}
				num8 = num15;
			}
			num7 += num14;
			_itemList.Add(rectTransform);
			num7 += num2;
		}
		if (!layoutInput)
		{
			if (StartAxis == Axis.Horizontal)
			{
				float yOffset2 = CalculateRowVerticalOffset(height, num3, num8);
				num7 -= num2;
				LayoutRow(_itemList, num7, num8, num6, (float)padding.left + num11, yOffset2, axis);
			}
			else if (StartAxis == Axis.Vertical)
			{
				float xOffset2 = CalculateColHorizontalOffset(width, num3, num8);
				num7 -= num2;
				LayoutCol(_itemList, num8, num7, num6, xOffset2, padding.top, axis);
			}
		}
		num13 += Mathf.Max(num10, num8);
		_itemList.Clear();
		num3 += num8;
		num3 += num4;
		if (layoutInput)
		{
			SetLayoutInputForAxis(num13, num13, -1f, axis);
		}
		return num3;
	}

	private float CalculateRowVerticalOffset(float groupHeight, float yOffset, float currentRowHeight)
	{
		if (IsLowerAlign)
		{
			return groupHeight - yOffset - currentRowHeight;
		}
		if (IsMiddleAlign)
		{
			return groupHeight * 0.5f - _layoutHeight * 0.5f + yOffset;
		}
		return yOffset;
	}

	private float CalculateColHorizontalOffset(float groupWidth, float xOffset, float currentColWidth)
	{
		if (IsRightAlign)
		{
			return groupWidth - xOffset - currentColWidth;
		}
		if (IsCenterAlign)
		{
			return groupWidth * 0.5f - _layoutWidth * 0.5f + xOffset;
		}
		return xOffset;
	}

	protected void LayoutRow(IList<RectTransform> contents, float rowWidth, float rowHeight, float maxWidth, float xOffset, float yOffset, int axis)
	{
		float num = xOffset;
		if (!ChildForceExpandWidth && IsCenterAlign)
		{
			num += (maxWidth - rowWidth) * 0.5f;
		}
		else if (!ChildForceExpandWidth && IsRightAlign)
		{
			num += maxWidth - rowWidth;
		}
		float num2 = 0f;
		float num3 = 0f;
		if (ChildForceExpandWidth)
		{
			num2 = (maxWidth - rowWidth) / (float)contents.Count;
		}
		else if (ExpandHorizontalSpacing)
		{
			num3 = (maxWidth - rowWidth) / (float)(contents.Count - 1);
			if (contents.Count > 1)
			{
				if (IsCenterAlign)
				{
					num -= num3 * 0.5f * (float)(contents.Count - 1);
				}
				else if (IsRightAlign)
				{
					num -= num3 * (float)(contents.Count - 1);
				}
			}
		}
		for (int i = 0; i < contents.Count; i++)
		{
			int index = (IsLowerAlign ? (contents.Count - 1 - i) : i);
			RectTransform rect = contents[index];
			float a = LayoutUtility.GetPreferredSize(rect, 0) + num2;
			float num4 = LayoutUtility.GetPreferredSize(rect, 1);
			if (ChildForceExpandHeight)
			{
				num4 = rowHeight;
			}
			a = Mathf.Min(a, maxWidth);
			float num5 = yOffset;
			if (IsMiddleAlign)
			{
				num5 += (rowHeight - num4) * 0.5f;
			}
			else if (IsLowerAlign)
			{
				num5 += rowHeight - num4;
			}
			if (ExpandHorizontalSpacing && i > 0)
			{
				num += num3;
			}
			if (axis == 0)
			{
				SetChildAlongAxis(rect, 0, num, a);
			}
			else
			{
				SetChildAlongAxis(rect, 1, num5, num4);
			}
			if (i < contents.Count - 1)
			{
				num += a + SpacingX;
			}
		}
	}

	protected void LayoutCol(IList<RectTransform> contents, float colWidth, float colHeight, float maxHeight, float xOffset, float yOffset, int axis)
	{
		float num = yOffset;
		if (!ChildForceExpandHeight && IsMiddleAlign)
		{
			num += (maxHeight - colHeight) * 0.5f;
		}
		else if (!ChildForceExpandHeight && IsLowerAlign)
		{
			num += maxHeight - colHeight;
		}
		float num2 = 0f;
		float num3 = 0f;
		if (ChildForceExpandHeight)
		{
			num2 = (maxHeight - colHeight) / (float)contents.Count;
		}
		else if (ExpandHorizontalSpacing)
		{
			num3 = (maxHeight - colHeight) / (float)(contents.Count - 1);
			if (contents.Count > 1)
			{
				if (IsMiddleAlign)
				{
					num -= num3 * 0.5f * (float)(contents.Count - 1);
				}
				else if (IsLowerAlign)
				{
					num -= num3 * (float)(contents.Count - 1);
				}
			}
		}
		for (int i = 0; i < contents.Count; i++)
		{
			int index = (IsRightAlign ? (contents.Count - 1 - i) : i);
			RectTransform rect = contents[index];
			float num4 = LayoutUtility.GetPreferredSize(rect, 0);
			float a = LayoutUtility.GetPreferredSize(rect, 1) + num2;
			if (ChildForceExpandWidth)
			{
				num4 = colWidth;
			}
			a = Mathf.Min(a, maxHeight);
			float num5 = xOffset;
			if (IsCenterAlign)
			{
				num5 += (colWidth - num4) * 0.5f;
			}
			else if (IsRightAlign)
			{
				num5 += colWidth - num4;
			}
			if (ExpandHorizontalSpacing && i > 0)
			{
				num += num3;
			}
			if (axis == 0)
			{
				SetChildAlongAxis(rect, 0, num5, num4);
			}
			else
			{
				SetChildAlongAxis(rect, 1, num, a);
			}
			if (i < contents.Count - 1)
			{
				num += a + SpacingY;
			}
		}
	}

	public float GetGreatestMinimumChildWidth()
	{
		float num = 0f;
		for (int i = 0; i < rectChildren.Count; i++)
		{
			num = Mathf.Max(LayoutUtility.GetMinWidth(rectChildren[i]), num);
		}
		return num;
	}

	public float GetGreatestMinimumChildHeigth()
	{
		float num = 0f;
		for (int i = 0; i < rectChildren.Count; i++)
		{
			num = Mathf.Max(LayoutUtility.GetMinHeight(rectChildren[i]), num);
		}
		return num;
	}

	protected override void OnDisable()
	{
		m_Tracker.Clear();
		LayoutRebuilder.MarkLayoutForRebuild(rectTransform);
	}
}
