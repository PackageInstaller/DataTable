using System;
using UnityEngine.EventSystems;

namespace UnityEngine.UI;

[AddComponentMenu("Layout/Aspect Ratio Fitter", 142)]
[RequireComponent(typeof(RectTransform))]
[DisallowMultipleComponent]
[ExecuteAlways]
public class AspectRatioFitter : UIBehaviour, ILayoutSelfController, ILayoutController
{
	public enum AspectMode
	{
		None,
		WidthControlsHeight,
		HeightControlsWidth,
		FitInParent,
		EnvelopeParent
	}

	[SerializeField]
	private AspectMode m_AspectMode;

	[SerializeField]
	private float m_AspectRatio = 1f;

	[NonSerialized]
	private RectTransform m_Rect;

	private bool m_DelayedSetDirty;

	private bool m_DoesParentExist;

	private DrivenRectTransformTracker m_Tracker;

	public AspectMode aspectMode
	{
		get
		{
			return m_AspectMode;
		}
		set
		{
			if (SetPropertyUtility.SetStruct(ref m_AspectMode, value))
			{
				SetDirty();
			}
		}
	}

	public float aspectRatio
	{
		get
		{
			return m_AspectRatio;
		}
		set
		{
			if (SetPropertyUtility.SetStruct(ref m_AspectRatio, value))
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

	protected AspectRatioFitter()
	{
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		m_DoesParentExist = (rectTransform.parent ? true : false);
		SetDirty();
	}

	protected override void Start()
	{
		base.Start();
		if (!IsComponentValidOnObject() || !IsAspectModeValid())
		{
			base.enabled = false;
		}
	}

	protected override void OnDisable()
	{
		m_Tracker.Clear();
		LayoutRebuilder.MarkLayoutForRebuild(rectTransform);
		base.OnDisable();
	}

	protected override void OnTransformParentChanged()
	{
		base.OnTransformParentChanged();
		m_DoesParentExist = (rectTransform.parent ? true : false);
		SetDirty();
	}

	protected virtual void Update()
	{
		if (m_DelayedSetDirty)
		{
			m_DelayedSetDirty = false;
			SetDirty();
		}
	}

	protected override void OnRectTransformDimensionsChange()
	{
		UpdateRect();
	}

	private void UpdateRect()
	{
		if (!IsActive() || !IsComponentValidOnObject())
		{
			return;
		}
		m_Tracker.Clear();
		switch (m_AspectMode)
		{
		case AspectMode.HeightControlsWidth:
			m_Tracker.Add(this, rectTransform, DrivenTransformProperties.SizeDeltaX);
			rectTransform.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, rectTransform.rect.height * m_AspectRatio);
			break;
		case AspectMode.WidthControlsHeight:
			m_Tracker.Add(this, rectTransform, DrivenTransformProperties.SizeDeltaY);
			rectTransform.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, rectTransform.rect.width / m_AspectRatio);
			break;
		case AspectMode.FitInParent:
		case AspectMode.EnvelopeParent:
			if (DoesParentExists())
			{
				m_Tracker.Add(this, rectTransform, DrivenTransformProperties.Anchors | DrivenTransformProperties.AnchoredPosition | DrivenTransformProperties.SizeDelta);
				rectTransform.anchorMin = Vector2.zero;
				rectTransform.anchorMax = Vector2.one;
				rectTransform.anchoredPosition = Vector2.zero;
				Vector2 zero = Vector2.zero;
				Vector2 parentSize = GetParentSize();
				if ((parentSize.y * aspectRatio < parentSize.x) ^ (m_AspectMode == AspectMode.FitInParent))
				{
					zero.y = GetSizeDeltaToProduceSize(parentSize.x / aspectRatio, 1);
				}
				else
				{
					zero.x = GetSizeDeltaToProduceSize(parentSize.y * aspectRatio, 0);
				}
				rectTransform.sizeDelta = zero;
			}
			break;
		}
	}

	private float GetSizeDeltaToProduceSize(float size, int axis)
	{
		return size - GetParentSize()[axis] * (rectTransform.anchorMax[axis] - rectTransform.anchorMin[axis]);
	}

	private Vector2 GetParentSize()
	{
		RectTransform rectTransform = this.rectTransform.parent as RectTransform;
		if ((bool)rectTransform)
		{
			return rectTransform.rect.size;
		}
		return Vector2.zero;
	}

	public virtual void SetLayoutHorizontal()
	{
	}

	public virtual void SetLayoutVertical()
	{
	}

	protected void SetDirty()
	{
		UpdateRect();
	}

	public bool IsComponentValidOnObject()
	{
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Invalid comparison between Unknown and I4
		Canvas component = base.gameObject.GetComponent<Canvas>();
		if ((bool)(Object)(object)component && component.isRootCanvas && (int)component.renderMode != 2)
		{
			return false;
		}
		return true;
	}

	public bool IsAspectModeValid()
	{
		if (!DoesParentExists() && (aspectMode == AspectMode.EnvelopeParent || aspectMode == AspectMode.FitInParent))
		{
			return false;
		}
		return true;
	}

	private bool DoesParentExists()
	{
		return m_DoesParentExist;
	}
}
