using System;
using UnityEngine.EventSystems;

namespace UnityEngine.UI;

[AddComponentMenu("Layout/Content Size Fitter", 141)]
[ExecuteAlways]
[RequireComponent(typeof(RectTransform))]
public class ContentSizeFitter : UIBehaviour, ILayoutSelfController, ILayoutController
{
	public enum FitMode
	{
		Unconstrained,
		MinSize,
		PreferredSize
	}

	[SerializeField]
	protected FitMode m_HorizontalFit;

	[SerializeField]
	protected FitMode m_VerticalFit;

	[NonSerialized]
	private RectTransform m_Rect;

	private DrivenRectTransformTracker m_Tracker;

	public FitMode horizontalFit
	{
		get
		{
			return m_HorizontalFit;
		}
		set
		{
			if (SetPropertyUtility.SetStruct(ref m_HorizontalFit, value))
			{
				SetDirty();
			}
		}
	}

	public FitMode verticalFit
	{
		get
		{
			return m_VerticalFit;
		}
		set
		{
			if (SetPropertyUtility.SetStruct(ref m_VerticalFit, value))
			{
				SetDirty();
			}
		}
	}

	private RectTransform rectTransform
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

	protected ContentSizeFitter()
	{
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

	protected override void OnRectTransformDimensionsChange()
	{
		SetDirty();
	}

	private void HandleSelfFittingAlongAxis(int axis)
	{
		FitMode fitMode = ((axis == 0) ? horizontalFit : verticalFit);
		if (fitMode == FitMode.Unconstrained)
		{
			m_Tracker.Add(this, rectTransform, DrivenTransformProperties.None);
			return;
		}
		m_Tracker.Add(this, rectTransform, (axis == 0) ? DrivenTransformProperties.SizeDeltaX : DrivenTransformProperties.SizeDeltaY);
		if (fitMode == FitMode.MinSize)
		{
			rectTransform.SetSizeWithCurrentAnchors((RectTransform.Axis)axis, LayoutUtility.GetMinSize(m_Rect, axis));
		}
		else
		{
			rectTransform.SetSizeWithCurrentAnchors((RectTransform.Axis)axis, LayoutUtility.GetPreferredSize(m_Rect, axis));
		}
	}

	public virtual void SetLayoutHorizontal()
	{
		m_Tracker.Clear();
		HandleSelfFittingAlongAxis(0);
	}

	public virtual void SetLayoutVertical()
	{
		HandleSelfFittingAlongAxis(1);
	}

	protected void SetDirty()
	{
		if (IsActive())
		{
			LayoutRebuilder.MarkLayoutForRebuild(rectTransform);
		}
	}
}
