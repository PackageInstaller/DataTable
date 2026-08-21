using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.EventSystems;
using UnityEngine.Pool;

namespace UnityEngine.UI;

[DisallowMultipleComponent]
[ExecuteAlways]
[RequireComponent(typeof(RectTransform))]
public abstract class LayoutGroup : UIBehaviour, ILayoutElement, ILayoutGroup, ILayoutController
{
	[SerializeField]
	protected RectOffset m_Padding = new RectOffset();

	[SerializeField]
	protected TextAnchor m_ChildAlignment;

	[NonSerialized]
	private RectTransform m_Rect;

	protected DrivenRectTransformTracker m_Tracker;

	private Vector2 m_TotalMinSize = Vector2.zero;

	private Vector2 m_TotalPreferredSize = Vector2.zero;

	private Vector2 m_TotalFlexibleSize = Vector2.zero;

	[NonSerialized]
	private List<RectTransform> m_RectChildren = new List<RectTransform>();

	public RectOffset padding
	{
		get
		{
			return m_Padding;
		}
		set
		{
			SetProperty(ref m_Padding, value);
		}
	}

	public TextAnchor childAlignment
	{
		get
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return m_ChildAlignment;
		}
		set
		{
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			SetProperty(ref m_ChildAlignment, value);
		}
	}

	protected RectTransform rectTransform
	{
		get
		{
			if (m_Rect == null)
			{
				m_Rect = GetComponent<RectTransform>();
			}
			return m_Rect;
		}
	}

	protected List<RectTransform> rectChildren => m_RectChildren;

	public virtual float minWidth => GetTotalMinSize(0);

	public virtual float preferredWidth => GetTotalPreferredSize(0);

	public virtual float flexibleWidth => GetTotalFlexibleSize(0);

	public virtual float minHeight => GetTotalMinSize(1);

	public virtual float preferredHeight => GetTotalPreferredSize(1);

	public virtual float flexibleHeight => GetTotalFlexibleSize(1);

	public virtual int layoutPriority => 0;

	private bool isRootLayoutGroup
	{
		get
		{
			if (base.transform.parent == null)
			{
				return true;
			}
			return base.transform.parent.GetComponent(typeof(ILayoutGroup)) == null;
		}
	}

	public virtual void CalculateLayoutInputHorizontal()
	{
		m_RectChildren.Clear();
		List<Component> list = CollectionPool<List<Component>, Component>.Get();
		for (int i = 0; i < this.rectTransform.childCount; i++)
		{
			RectTransform rectTransform = this.rectTransform.GetChild(i) as RectTransform;
			if (rectTransform == null || !rectTransform.gameObject.activeInHierarchy)
			{
				continue;
			}
			rectTransform.GetComponents(typeof(ILayoutIgnorer), list);
			if (list.Count == 0)
			{
				m_RectChildren.Add(rectTransform);
				continue;
			}
			for (int j = 0; j < list.Count; j++)
			{
				if (!((ILayoutIgnorer)list[j]).ignoreLayout)
				{
					m_RectChildren.Add(rectTransform);
					break;
				}
			}
		}
		CollectionPool<List<Component>, Component>.Release(list);
		m_Tracker.Clear();
	}

	public abstract void CalculateLayoutInputVertical();

	public abstract void SetLayoutHorizontal();

	public abstract void SetLayoutVertical();

	protected LayoutGroup()
	{
		if (m_Padding == null)
		{
			m_Padding = new RectOffset();
		}
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		SetDirty();
	}

	protected override void OnDisable()
	{
		m_Tracker.Clear();
		LayoutRebuilder.MarkLayoutForRebuild(rectTransform);
		base.OnDisable();
	}

	protected override void OnDidApplyAnimationProperties()
	{
		SetDirty();
	}

	protected float GetTotalMinSize(int axis)
	{
		return m_TotalMinSize[axis];
	}

	protected float GetTotalPreferredSize(int axis)
	{
		return m_TotalPreferredSize[axis];
	}

	protected float GetTotalFlexibleSize(int axis)
	{
		return m_TotalFlexibleSize[axis];
	}

	protected float GetStartOffset(int axis, float requiredSpaceWithoutPadding)
	{
		float num = requiredSpaceWithoutPadding + (float)((axis == 0) ? padding.horizontal : padding.vertical);
		float num2 = rectTransform.rect.size[axis] - num;
		float alignmentOnAxis = GetAlignmentOnAxis(axis);
		return (float)((axis == 0) ? padding.left : padding.top) + num2 * alignmentOnAxis;
	}

	protected float GetAlignmentOnAxis(int axis)
	{
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0004: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		if (axis == 0)
		{
			return (float)(childAlignment % 3) * 0.5f;
		}
		return (float)(childAlignment / 3) * 0.5f;
	}

	protected void SetLayoutInputForAxis(float totalMin, float totalPreferred, float totalFlexible, int axis)
	{
		m_TotalMinSize[axis] = totalMin;
		m_TotalPreferredSize[axis] = totalPreferred;
		m_TotalFlexibleSize[axis] = totalFlexible;
	}

	protected void SetChildAlongAxis(RectTransform rect, int axis, float pos)
	{
		if (!(rect == null))
		{
			SetChildAlongAxisWithScale(rect, axis, pos, 1f);
		}
	}

	protected void SetChildAlongAxisWithScale(RectTransform rect, int axis, float pos, float scaleFactor)
	{
		if (!(rect == null))
		{
			m_Tracker.Add(this, rect, (DrivenTransformProperties)(0xF00 | ((axis == 0) ? 2 : 4)));
			rect.anchorMin = Vector2.up;
			rect.anchorMax = Vector2.up;
			Vector2 anchoredPosition = rect.anchoredPosition;
			anchoredPosition[axis] = ((axis == 0) ? (pos + rect.sizeDelta[axis] * rect.pivot[axis] * scaleFactor) : (0f - pos - rect.sizeDelta[axis] * (1f - rect.pivot[axis]) * scaleFactor));
			rect.anchoredPosition = anchoredPosition;
		}
	}

	protected void SetChildAlongAxis(RectTransform rect, int axis, float pos, float size)
	{
		if (!(rect == null))
		{
			SetChildAlongAxisWithScale(rect, axis, pos, size, 1f);
		}
	}

	protected void SetChildAlongAxisWithScale(RectTransform rect, int axis, float pos, float size, float scaleFactor)
	{
		if (!(rect == null))
		{
			m_Tracker.Add(this, rect, (DrivenTransformProperties)(0xF00 | ((axis == 0) ? 4098 : 8196)));
			rect.anchorMin = Vector2.up;
			rect.anchorMax = Vector2.up;
			Vector2 sizeDelta = rect.sizeDelta;
			sizeDelta[axis] = size;
			rect.sizeDelta = sizeDelta;
			Vector2 anchoredPosition = rect.anchoredPosition;
			anchoredPosition[axis] = ((axis == 0) ? (pos + size * rect.pivot[axis] * scaleFactor) : (0f - pos - size * (1f - rect.pivot[axis]) * scaleFactor));
			rect.anchoredPosition = anchoredPosition;
		}
	}

	protected override void OnRectTransformDimensionsChange()
	{
		base.OnRectTransformDimensionsChange();
		if (isRootLayoutGroup)
		{
			SetDirty();
		}
	}

	protected virtual void OnTransformChildrenChanged()
	{
		SetDirty();
	}

	protected void SetProperty<T>(ref T currentValue, T newValue)
	{
		if ((currentValue != null || newValue != null) && (currentValue == null || !currentValue.Equals(newValue)))
		{
			currentValue = newValue;
			SetDirty();
		}
	}

	protected void SetDirty()
	{
		if (IsActive())
		{
			if (!CanvasUpdateRegistry.IsRebuildingLayout())
			{
				LayoutRebuilder.MarkLayoutForRebuild(rectTransform);
			}
			else
			{
				StartCoroutine(DelayedSetDirty(rectTransform));
			}
		}
	}

	private IEnumerator DelayedSetDirty(RectTransform rectTransform)
	{
		yield return null;
		LayoutRebuilder.MarkLayoutForRebuild(rectTransform);
	}
}
