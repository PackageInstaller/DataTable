namespace UnityEngine.UI;

[ExecuteAlways]
public abstract class HorizontalOrVerticalLayoutGroup : LayoutGroup
{
	[SerializeField]
	protected float m_Spacing;

	[SerializeField]
	protected bool m_ChildForceExpandWidth = true;

	[SerializeField]
	protected bool m_ChildForceExpandHeight = true;

	[SerializeField]
	protected bool m_ChildControlWidth = true;

	[SerializeField]
	protected bool m_ChildControlHeight = true;

	[SerializeField]
	protected bool m_ChildScaleWidth;

	[SerializeField]
	protected bool m_ChildScaleHeight;

	[SerializeField]
	protected bool m_ReverseArrangement;

	public float spacing
	{
		get
		{
			return m_Spacing;
		}
		set
		{
			SetProperty(ref m_Spacing, value);
		}
	}

	public bool childForceExpandWidth
	{
		get
		{
			return m_ChildForceExpandWidth;
		}
		set
		{
			SetProperty(ref m_ChildForceExpandWidth, value);
		}
	}

	public bool childForceExpandHeight
	{
		get
		{
			return m_ChildForceExpandHeight;
		}
		set
		{
			SetProperty(ref m_ChildForceExpandHeight, value);
		}
	}

	public bool childControlWidth
	{
		get
		{
			return m_ChildControlWidth;
		}
		set
		{
			SetProperty(ref m_ChildControlWidth, value);
		}
	}

	public bool childControlHeight
	{
		get
		{
			return m_ChildControlHeight;
		}
		set
		{
			SetProperty(ref m_ChildControlHeight, value);
		}
	}

	public bool childScaleWidth
	{
		get
		{
			return m_ChildScaleWidth;
		}
		set
		{
			SetProperty(ref m_ChildScaleWidth, value);
		}
	}

	public bool childScaleHeight
	{
		get
		{
			return m_ChildScaleHeight;
		}
		set
		{
			SetProperty(ref m_ChildScaleHeight, value);
		}
	}

	public bool reverseArrangement
	{
		get
		{
			return m_ReverseArrangement;
		}
		set
		{
			SetProperty(ref m_ReverseArrangement, value);
		}
	}

	protected void CalcAlongAxis(int axis, bool isVertical)
	{
		float num = ((axis == 0) ? base.padding.horizontal : base.padding.vertical);
		bool controlSize = ((axis == 0) ? m_ChildControlWidth : m_ChildControlHeight);
		bool flag = ((axis == 0) ? m_ChildScaleWidth : m_ChildScaleHeight);
		bool childForceExpand = ((axis == 0) ? m_ChildForceExpandWidth : m_ChildForceExpandHeight);
		float num2 = num;
		float num3 = num;
		float num4 = 0f;
		bool flag2 = isVertical ^ (axis == 1);
		int count = base.rectChildren.Count;
		for (int i = 0; i < count; i++)
		{
			RectTransform rectTransform = base.rectChildren[i];
			GetChildSizes(rectTransform, axis, controlSize, childForceExpand, out var min, out var preferred, out var flexible);
			if (flag)
			{
				float num5 = rectTransform.localScale[axis];
				min *= num5;
				preferred *= num5;
				flexible *= num5;
			}
			if (flag2)
			{
				num2 = Mathf.Max(min + num, num2);
				num3 = Mathf.Max(preferred + num, num3);
				num4 = Mathf.Max(flexible, num4);
			}
			else
			{
				num2 += min + spacing;
				num3 += preferred + spacing;
				num4 += flexible;
			}
		}
		if (!flag2 && base.rectChildren.Count > 0)
		{
			num2 -= spacing;
			num3 -= spacing;
		}
		num3 = Mathf.Max(num2, num3);
		SetLayoutInputForAxis(num2, num3, num4, axis);
	}

	protected void SetChildrenAlongAxis(int axis, bool isVertical)
	{
		float num = base.rectTransform.rect.size[axis];
		bool flag = ((axis == 0) ? m_ChildControlWidth : m_ChildControlHeight);
		bool flag2 = ((axis == 0) ? m_ChildScaleWidth : m_ChildScaleHeight);
		bool childForceExpand = ((axis == 0) ? m_ChildForceExpandWidth : m_ChildForceExpandHeight);
		float alignmentOnAxis = GetAlignmentOnAxis(axis);
		bool num2 = isVertical ^ (axis == 1);
		int num3 = (m_ReverseArrangement ? (base.rectChildren.Count - 1) : 0);
		int num4 = ((!m_ReverseArrangement) ? base.rectChildren.Count : 0);
		int num5 = ((!m_ReverseArrangement) ? 1 : (-1));
		if (num2)
		{
			float value = num - (float)((axis == 0) ? base.padding.horizontal : base.padding.vertical);
			for (int i = num3; m_ReverseArrangement ? (i >= num4) : (i < num4); i += num5)
			{
				RectTransform rectTransform = base.rectChildren[i];
				GetChildSizes(rectTransform, axis, flag, childForceExpand, out var min, out var preferred, out var flexible);
				float num6 = (flag2 ? rectTransform.localScale[axis] : 1f);
				float num7 = Mathf.Clamp(value, min, (flexible > 0f) ? num : preferred);
				float startOffset = GetStartOffset(axis, num7 * num6);
				if (flag)
				{
					SetChildAlongAxisWithScale(rectTransform, axis, startOffset, num7, num6);
					continue;
				}
				float num8 = (num7 - rectTransform.sizeDelta[axis]) * alignmentOnAxis;
				SetChildAlongAxisWithScale(rectTransform, axis, startOffset + num8, num6);
			}
			return;
		}
		float num9 = ((axis == 0) ? base.padding.left : base.padding.top);
		float num10 = 0f;
		float num11 = num - GetTotalPreferredSize(axis);
		if (num11 > 0f)
		{
			if (GetTotalFlexibleSize(axis) == 0f)
			{
				num9 = GetStartOffset(axis, GetTotalPreferredSize(axis) - (float)((axis == 0) ? base.padding.horizontal : base.padding.vertical));
			}
			else if (GetTotalFlexibleSize(axis) > 0f)
			{
				num10 = num11 / GetTotalFlexibleSize(axis);
			}
		}
		float t = 0f;
		if (GetTotalMinSize(axis) != GetTotalPreferredSize(axis))
		{
			t = Mathf.Clamp01((num - GetTotalMinSize(axis)) / (GetTotalPreferredSize(axis) - GetTotalMinSize(axis)));
		}
		for (int j = num3; m_ReverseArrangement ? (j >= num4) : (j < num4); j += num5)
		{
			RectTransform rectTransform2 = base.rectChildren[j];
			GetChildSizes(rectTransform2, axis, flag, childForceExpand, out var min2, out var preferred2, out var flexible2);
			float num12 = (flag2 ? rectTransform2.localScale[axis] : 1f);
			float num13 = Mathf.Lerp(min2, preferred2, t);
			num13 += flexible2 * num10;
			if (flag)
			{
				SetChildAlongAxisWithScale(rectTransform2, axis, num9, num13, num12);
			}
			else
			{
				float num14 = (num13 - rectTransform2.sizeDelta[axis]) * alignmentOnAxis;
				SetChildAlongAxisWithScale(rectTransform2, axis, num9 + num14, num12);
			}
			num9 += num13 * num12 + spacing;
		}
	}

	private void GetChildSizes(RectTransform child, int axis, bool controlSize, bool childForceExpand, out float min, out float preferred, out float flexible)
	{
		if (!controlSize)
		{
			min = child.sizeDelta[axis];
			preferred = min;
			flexible = 0f;
		}
		else
		{
			min = LayoutUtility.GetMinSize(child, axis);
			preferred = LayoutUtility.GetPreferredSize(child, axis);
			flexible = LayoutUtility.GetFlexibleSize(child, axis);
		}
		if (childForceExpand)
		{
			flexible = Mathf.Max(flexible, 1f);
		}
	}
}
