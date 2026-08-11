using System;
using System.ComponentModel;
using UnityEngine.Events;
using UnityEngine.Rendering;

namespace UnityEngine.UI;

public abstract class MaskableGraphic : Graphic, IClippable, IMaskable, IMaterialModifier
{
	[Serializable]
	public class CullStateChangedEvent : UnityEvent<bool>
	{
	}

	[NonSerialized]
	protected bool m_ShouldRecalculateStencil = true;

	[NonSerialized]
	protected Material m_MaskMaterial;

	[NonSerialized]
	private RectMask2D m_ParentMask;

	[SerializeField]
	private bool m_Maskable = true;

	private bool m_IsMaskingGraphic;

	[NonSerialized]
	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("Not used anymore.", true)]
	protected bool m_IncludeForMasking;

	[SerializeField]
	private CullStateChangedEvent m_OnCullStateChanged = new CullStateChangedEvent();

	[NonSerialized]
	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("Not used anymore", true)]
	protected bool m_ShouldRecalculate = true;

	[NonSerialized]
	protected int m_StencilValue;

	private readonly Vector3[] m_Corners = new Vector3[4];

	public CullStateChangedEvent onCullStateChanged
	{
		get
		{
			return m_OnCullStateChanged;
		}
		set
		{
			m_OnCullStateChanged = value;
		}
	}

	public bool maskable
	{
		get
		{
			return m_Maskable;
		}
		set
		{
			if (value != m_Maskable)
			{
				m_Maskable = value;
				m_ShouldRecalculateStencil = true;
				SetMaterialDirty();
			}
		}
	}

	public bool isMaskingGraphic
	{
		get
		{
			return m_IsMaskingGraphic;
		}
		set
		{
			if (value != m_IsMaskingGraphic)
			{
				m_IsMaskingGraphic = value;
			}
		}
	}

	private Rect rootCanvasRect
	{
		get
		{
			base.rectTransform.GetWorldCorners(m_Corners);
			if ((bool)(Object)(object)base.canvas)
			{
				Matrix4x4 worldToLocalMatrix = ((Component)(object)base.canvas.rootCanvas).transform.worldToLocalMatrix;
				for (int i = 0; i < 4; i++)
				{
					m_Corners[i] = worldToLocalMatrix.MultiplyPoint(m_Corners[i]);
				}
			}
			Vector2 vector = m_Corners[0];
			Vector2 vector2 = m_Corners[0];
			for (int j = 1; j < 4; j++)
			{
				vector.x = Mathf.Min(m_Corners[j].x, vector.x);
				vector.y = Mathf.Min(m_Corners[j].y, vector.y);
				vector2.x = Mathf.Max(m_Corners[j].x, vector2.x);
				vector2.y = Mathf.Max(m_Corners[j].y, vector2.y);
			}
			return new Rect(vector, vector2 - vector);
		}
	}

	public virtual Material GetModifiedMaterial(Material baseMaterial)
	{
		Material material = baseMaterial;
		if (m_ShouldRecalculateStencil)
		{
			if (maskable)
			{
				Transform stopAfter = MaskUtilities.FindRootSortOverrideCanvas(base.transform);
				m_StencilValue = MaskUtilities.GetStencilDepth(base.transform, stopAfter);
			}
			else
			{
				m_StencilValue = 0;
			}
			m_ShouldRecalculateStencil = false;
		}
		if (m_StencilValue > 0 && !isMaskingGraphic)
		{
			Material maskMaterial = StencilMaterial.Add(material, (1 << m_StencilValue) - 1, StencilOp.Keep, CompareFunction.Equal, ColorWriteMask.All, (1 << m_StencilValue) - 1, 0);
			StencilMaterial.Remove(m_MaskMaterial);
			m_MaskMaterial = maskMaterial;
			material = m_MaskMaterial;
		}
		return material;
	}

	public virtual void Cull(Rect clipRect, bool validRect)
	{
		bool cull = !validRect || !clipRect.Overlaps(rootCanvasRect, allowInverse: true);
		UpdateCull(cull);
	}

	private void UpdateCull(bool cull)
	{
		if (base.canvasRenderer.cull != cull)
		{
			base.canvasRenderer.cull = cull;
			UISystemProfilerApi.AddMarker("MaskableGraphic.cullingChanged", (Object)this);
			m_OnCullStateChanged.Invoke(cull);
			OnCullingChanged();
		}
	}

	public virtual void SetClipRect(Rect clipRect, bool validRect)
	{
		if (validRect)
		{
			base.canvasRenderer.EnableRectClipping(clipRect);
		}
		else
		{
			base.canvasRenderer.DisableRectClipping();
		}
	}

	public virtual void SetClipSoftness(Vector2 clipSoftness)
	{
		base.canvasRenderer.clippingSoftness = clipSoftness;
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		m_ShouldRecalculateStencil = true;
		UpdateClipParent();
		SetMaterialDirty();
		if (isMaskingGraphic)
		{
			MaskUtilities.NotifyStencilStateChanged(this);
		}
	}

	protected override void OnDisable()
	{
		base.OnDisable();
		m_ShouldRecalculateStencil = true;
		SetMaterialDirty();
		UpdateClipParent();
		StencilMaterial.Remove(m_MaskMaterial);
		m_MaskMaterial = null;
		if (isMaskingGraphic)
		{
			MaskUtilities.NotifyStencilStateChanged(this);
		}
	}

	protected override void OnTransformParentChanged()
	{
		base.OnTransformParentChanged();
		if (base.isActiveAndEnabled)
		{
			m_ShouldRecalculateStencil = true;
			UpdateClipParent();
			SetMaterialDirty();
		}
	}

	[Obsolete("Not used anymore.", true)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public virtual void ParentMaskStateChanged()
	{
	}

	protected override void OnCanvasHierarchyChanged()
	{
		base.OnCanvasHierarchyChanged();
		if (base.isActiveAndEnabled)
		{
			m_ShouldRecalculateStencil = true;
			UpdateClipParent();
			SetMaterialDirty();
		}
	}

	private void UpdateClipParent()
	{
		RectMask2D rectMask2D = ((maskable && IsActive()) ? MaskUtilities.GetRectMaskForClippable(this) : null);
		if (m_ParentMask != null && (rectMask2D != m_ParentMask || !rectMask2D.IsActive()))
		{
			m_ParentMask.RemoveClippable(this);
			UpdateCull(cull: false);
		}
		if (rectMask2D != null && rectMask2D.IsActive())
		{
			rectMask2D.AddClippable(this);
		}
		m_ParentMask = rectMask2D;
	}

	public virtual void RecalculateClipping()
	{
		UpdateClipParent();
	}

	public virtual void RecalculateMasking()
	{
		StencilMaterial.Remove(m_MaskMaterial);
		m_MaskMaterial = null;
		m_ShouldRecalculateStencil = true;
		SetMaterialDirty();
	}
}
