using System;
using System.Collections.Generic;
using UnityEngine.EventSystems;
using UnityEngine.Pool;

namespace UnityEngine.UI;

[RequireComponent(typeof(RectTransform))]
[DisallowMultipleComponent]
[ExecuteAlways]
[AddComponentMenu("UI/Rect Mask 2D", 14)]
public class RectMask2D : UIBehaviour, IClipper, ICanvasRaycastFilter
{
	[NonSerialized]
	private readonly RectangularVertexClipper m_VertexClipper = new RectangularVertexClipper();

	[NonSerialized]
	private RectTransform m_RectTransform;

	[NonSerialized]
	private HashSet<MaskableGraphic> m_MaskableTargets = new HashSet<MaskableGraphic>();

	[NonSerialized]
	private HashSet<IClippable> m_ClipTargets = new HashSet<IClippable>();

	[NonSerialized]
	private bool m_ShouldRecalculateClipRects;

	[NonSerialized]
	private List<RectMask2D> m_Clippers = new List<RectMask2D>();

	[NonSerialized]
	private Rect m_LastClipRectCanvasSpace;

	[NonSerialized]
	private bool m_ForceClip;

	[SerializeField]
	private Vector4 m_Padding;

	[SerializeField]
	private Vector2Int m_Softness;

	[NonSerialized]
	private Canvas m_Canvas;

	private Vector3[] m_Corners = new Vector3[4];

	public Vector4 padding
	{
		get
		{
			return m_Padding;
		}
		set
		{
			m_Padding = value;
			MaskUtilities.Notify2DMaskStateChanged(this);
		}
	}

	public Vector2Int softness
	{
		get
		{
			return m_Softness;
		}
		set
		{
			m_Softness.x = Mathf.Max(0, value.x);
			m_Softness.y = Mathf.Max(0, value.y);
			MaskUtilities.Notify2DMaskStateChanged(this);
		}
	}

	internal Canvas Canvas
	{
		get
		{
			if ((Object)(object)m_Canvas == null)
			{
				List<Canvas> list = CollectionPool<List<Canvas>, Canvas>.Get();
				base.gameObject.GetComponentsInParent(includeInactive: false, list);
				if (list.Count > 0)
				{
					m_Canvas = list[list.Count - 1];
				}
				else
				{
					m_Canvas = null;
				}
				CollectionPool<List<Canvas>, Canvas>.Release(list);
			}
			return m_Canvas;
		}
	}

	public Rect canvasRect => m_VertexClipper.GetCanvasRect(rectTransform, Canvas);

	public RectTransform rectTransform => m_RectTransform ?? (m_RectTransform = GetComponent<RectTransform>());

	private Rect rootCanvasRect
	{
		get
		{
			rectTransform.GetWorldCorners(m_Corners);
			if (Canvas != null)
			{
				Canvas rootCanvas = Canvas.rootCanvas;
				for (int i = 0; i < 4; i++)
				{
					m_Corners[i] = ((Component)(object)rootCanvas).transform.InverseTransformPoint(m_Corners[i]);
				}
			}
			return new Rect(m_Corners[0].x, m_Corners[0].y, m_Corners[2].x - m_Corners[0].x, m_Corners[2].y - m_Corners[0].y);
		}
	}

	protected RectMask2D()
	{
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		m_ShouldRecalculateClipRects = true;
		ClipperRegistry.Register(this);
		MaskUtilities.Notify2DMaskStateChanged(this);
	}

	protected override void OnDisable()
	{
		base.OnDisable();
		m_ClipTargets.Clear();
		m_MaskableTargets.Clear();
		m_Clippers.Clear();
		ClipperRegistry.Disable(this);
		MaskUtilities.Notify2DMaskStateChanged(this);
	}

	protected override void OnDestroy()
	{
		ClipperRegistry.Unregister(this);
		base.OnDestroy();
	}

	public virtual bool IsRaycastLocationValid(Vector2 sp, Camera eventCamera)
	{
		if (!base.isActiveAndEnabled)
		{
			return true;
		}
		return RectTransformUtility.RectangleContainsScreenPoint(rectTransform, sp, eventCamera, m_Padding);
	}

	public virtual void PerformClipping()
	{
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0044: Unknown result type (might be due to invalid IL or missing references)
		//IL_0045: Unknown result type (might be due to invalid IL or missing references)
		//IL_0047: Invalid comparison between Unknown and I4
		//IL_0049: Unknown result type (might be due to invalid IL or missing references)
		if (Canvas == null)
		{
			return;
		}
		if (m_ShouldRecalculateClipRects)
		{
			MaskUtilities.GetRectMasksForClip(this, m_Clippers);
			m_ShouldRecalculateClipRects = false;
		}
		bool validRect = true;
		Rect rect = Clipping.FindCullAndClipWorldRect(m_Clippers, out validRect);
		RenderMode renderMode = Canvas.rootCanvas.renderMode;
		if (((int)renderMode == 1 || (int)renderMode == 0) && !rect.Overlaps(rootCanvasRect, allowInverse: true))
		{
			rect = Rect.zero;
			validRect = false;
		}
		if (rect != m_LastClipRectCanvasSpace)
		{
			foreach (IClippable clipTarget in m_ClipTargets)
			{
				clipTarget.SetClipRect(rect, validRect);
			}
			foreach (MaskableGraphic maskableTarget in m_MaskableTargets)
			{
				maskableTarget.SetClipRect(rect, validRect);
				maskableTarget.Cull(rect, validRect);
			}
		}
		else if (m_ForceClip)
		{
			foreach (IClippable clipTarget2 in m_ClipTargets)
			{
				clipTarget2.SetClipRect(rect, validRect);
			}
			foreach (MaskableGraphic maskableTarget2 in m_MaskableTargets)
			{
				maskableTarget2.SetClipRect(rect, validRect);
				if (maskableTarget2.canvasRenderer.hasMoved)
				{
					maskableTarget2.Cull(rect, validRect);
				}
			}
		}
		else
		{
			foreach (MaskableGraphic maskableTarget3 in m_MaskableTargets)
			{
				maskableTarget3.Cull(rect, validRect);
			}
		}
		m_LastClipRectCanvasSpace = rect;
		m_ForceClip = false;
		UpdateClipSoftness();
	}

	public virtual void UpdateClipSoftness()
	{
		if (Canvas == null)
		{
			return;
		}
		foreach (IClippable clipTarget in m_ClipTargets)
		{
			clipTarget.SetClipSoftness(m_Softness);
		}
		foreach (MaskableGraphic maskableTarget in m_MaskableTargets)
		{
			maskableTarget.SetClipSoftness(m_Softness);
		}
	}

	public void AddClippable(IClippable clippable)
	{
		if (clippable != null)
		{
			m_ShouldRecalculateClipRects = true;
			MaskableGraphic maskableGraphic = clippable as MaskableGraphic;
			if (maskableGraphic == null)
			{
				m_ClipTargets.Add(clippable);
			}
			else
			{
				m_MaskableTargets.Add(maskableGraphic);
			}
			m_ForceClip = true;
		}
	}

	public void RemoveClippable(IClippable clippable)
	{
		if (clippable != null)
		{
			m_ShouldRecalculateClipRects = true;
			clippable.SetClipRect(default(Rect), validRect: false);
			MaskableGraphic maskableGraphic = clippable as MaskableGraphic;
			if (maskableGraphic == null)
			{
				m_ClipTargets.Remove(clippable);
			}
			else
			{
				m_MaskableTargets.Remove(maskableGraphic);
			}
			m_ForceClip = true;
		}
	}

	protected override void OnTransformParentChanged()
	{
		m_Canvas = null;
		base.OnTransformParentChanged();
		m_ShouldRecalculateClipRects = true;
	}

	protected override void OnCanvasHierarchyChanged()
	{
		m_Canvas = null;
		base.OnCanvasHierarchyChanged();
		m_ShouldRecalculateClipRects = true;
	}
}
