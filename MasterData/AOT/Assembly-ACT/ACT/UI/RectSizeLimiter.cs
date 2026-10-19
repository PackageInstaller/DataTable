using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

[ExecuteInEditMode]
public class RectSizeLimiter : UIBehaviour, ILayoutSelfController, ILayoutController
{
	public RectTransform rectTransform;

	[SerializeField]
	protected Vector2 m_maxSize = Vector2.zero;

	[SerializeField]
	protected Vector2 m_minSize = Vector2.zero;

	private DrivenRectTransformTracker m_Tracker;

	public Vector2 maxSize
	{
		get
		{
			return m_maxSize;
		}
		set
		{
			if (m_maxSize != value)
			{
				m_maxSize = value;
				SetDirty();
			}
		}
	}

	public Vector2 minSize
	{
		get
		{
			return m_minSize;
		}
		set
		{
			if (m_minSize != value)
			{
				m_minSize = value;
				SetDirty();
			}
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

	protected void SetDirty()
	{
		if (IsActive())
		{
			LayoutRebuilder.MarkLayoutForRebuild(rectTransform);
		}
	}

	public void SetLayoutHorizontal()
	{
		if (m_maxSize.x > 0f && rectTransform.rect.width > m_maxSize.x)
		{
			rectTransform.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, maxSize.x);
			m_Tracker.Add(this, rectTransform, DrivenTransformProperties.SizeDeltaX);
		}
		if (m_minSize.x > 0f && rectTransform.rect.width < m_minSize.x)
		{
			rectTransform.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, minSize.x);
			m_Tracker.Add(this, rectTransform, DrivenTransformProperties.SizeDeltaX);
		}
	}

	public void SetLayoutVertical()
	{
		if (m_maxSize.y > 0f && rectTransform.rect.height > m_maxSize.y)
		{
			rectTransform.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, maxSize.y);
			m_Tracker.Add(this, rectTransform, DrivenTransformProperties.SizeDeltaY);
		}
		if (m_minSize.y > 0f && rectTransform.rect.height < m_minSize.y)
		{
			rectTransform.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, minSize.y);
			m_Tracker.Add(this, rectTransform, DrivenTransformProperties.SizeDeltaY);
		}
	}
}
