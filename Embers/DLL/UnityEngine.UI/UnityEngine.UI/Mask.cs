using System;
using UnityEngine.EventSystems;
using UnityEngine.Rendering;

namespace UnityEngine.UI;

[DisallowMultipleComponent]
[RequireComponent(typeof(RectTransform))]
[ExecuteAlways]
[AddComponentMenu("UI/Mask", 13)]
public class Mask : UIBehaviour, ICanvasRaycastFilter, IMaterialModifier
{
	[NonSerialized]
	private RectTransform m_RectTransform;

	[SerializeField]
	private bool m_ShowMaskGraphic = true;

	[NonSerialized]
	private Graphic m_Graphic;

	[NonSerialized]
	private Material m_MaskMaterial;

	[NonSerialized]
	private Material m_UnmaskMaterial;

	public RectTransform rectTransform => m_RectTransform ?? (m_RectTransform = GetComponent<RectTransform>());

	public bool showMaskGraphic
	{
		get
		{
			return m_ShowMaskGraphic;
		}
		set
		{
			if (m_ShowMaskGraphic != value)
			{
				m_ShowMaskGraphic = value;
				if (graphic != null)
				{
					graphic.SetMaterialDirty();
				}
			}
		}
	}

	public Graphic graphic => m_Graphic ?? (m_Graphic = GetComponent<Graphic>());

	protected Mask()
	{
	}

	public virtual bool MaskEnabled()
	{
		if (IsActive())
		{
			return graphic != null;
		}
		return false;
	}

	[Obsolete("Not used anymore.")]
	public virtual void OnSiblingGraphicEnabledDisabled()
	{
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (graphic != null)
		{
			graphic.canvasRenderer.hasPopInstruction = true;
			graphic.SetMaterialDirty();
			if (graphic is MaskableGraphic)
			{
				(graphic as MaskableGraphic).isMaskingGraphic = true;
			}
		}
		MaskUtilities.NotifyStencilStateChanged(this);
	}

	protected override void OnDisable()
	{
		base.OnDisable();
		if (graphic != null)
		{
			graphic.SetMaterialDirty();
			graphic.canvasRenderer.hasPopInstruction = false;
			graphic.canvasRenderer.popMaterialCount = 0;
			if (graphic is MaskableGraphic)
			{
				(graphic as MaskableGraphic).isMaskingGraphic = false;
			}
		}
		StencilMaterial.Remove(m_MaskMaterial);
		m_MaskMaterial = null;
		StencilMaterial.Remove(m_UnmaskMaterial);
		m_UnmaskMaterial = null;
		MaskUtilities.NotifyStencilStateChanged(this);
	}

	public virtual bool IsRaycastLocationValid(Vector2 sp, Camera eventCamera)
	{
		if (!base.isActiveAndEnabled)
		{
			return true;
		}
		return RectTransformUtility.RectangleContainsScreenPoint(rectTransform, sp, eventCamera);
	}

	public virtual Material GetModifiedMaterial(Material baseMaterial)
	{
		if (!MaskEnabled())
		{
			return baseMaterial;
		}
		Transform stopAfter = MaskUtilities.FindRootSortOverrideCanvas(base.transform);
		int stencilDepth = MaskUtilities.GetStencilDepth(base.transform, stopAfter);
		if (stencilDepth >= 8)
		{
			Debug.LogWarning("Attempting to use a stencil mask with depth > 8", base.gameObject);
			return baseMaterial;
		}
		int num = 1 << stencilDepth;
		if (num == 1)
		{
			Material maskMaterial = StencilMaterial.Add(baseMaterial, 1, StencilOp.Replace, CompareFunction.Always, m_ShowMaskGraphic ? ColorWriteMask.All : ((ColorWriteMask)0));
			StencilMaterial.Remove(m_MaskMaterial);
			m_MaskMaterial = maskMaterial;
			Material unmaskMaterial = StencilMaterial.Add(baseMaterial, 1, StencilOp.Zero, CompareFunction.Always, (ColorWriteMask)0);
			StencilMaterial.Remove(m_UnmaskMaterial);
			m_UnmaskMaterial = unmaskMaterial;
			graphic.canvasRenderer.popMaterialCount = 1;
			graphic.canvasRenderer.SetPopMaterial(m_UnmaskMaterial, 0);
			return m_MaskMaterial;
		}
		Material maskMaterial2 = StencilMaterial.Add(baseMaterial, num | (num - 1), StencilOp.Replace, CompareFunction.Equal, m_ShowMaskGraphic ? ColorWriteMask.All : ((ColorWriteMask)0), num - 1, num | (num - 1));
		StencilMaterial.Remove(m_MaskMaterial);
		m_MaskMaterial = maskMaterial2;
		graphic.canvasRenderer.hasPopInstruction = true;
		Material unmaskMaterial2 = StencilMaterial.Add(baseMaterial, num - 1, StencilOp.Replace, CompareFunction.Equal, (ColorWriteMask)0, num - 1, num | (num - 1));
		StencilMaterial.Remove(m_UnmaskMaterial);
		m_UnmaskMaterial = unmaskMaterial2;
		graphic.canvasRenderer.popMaterialCount = 1;
		graphic.canvasRenderer.SetPopMaterial(m_UnmaskMaterial, 0);
		return m_MaskMaterial;
	}
}
