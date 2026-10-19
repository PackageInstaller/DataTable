using System;
using System.Collections.Generic;
using ACT.UI.InputController;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.UI;

namespace ACT.ViewControl;

[ExecuteAlways]
[RequireComponent(typeof(Selectable))]
public class SelectableEx : UIBehaviour, ICustomFindSelectable, ISelectHandler, IEventSystemHandler, IDeselectHandler
{
	[Flags]
	public enum SelectableDirection
	{
		None = 0,
		Left = 1,
		Right = 2,
		Up = 4,
		Down = 8,
		All = Left | Right | Up | Down
	}

	private const float DistanceTieBreakerWeight = 0.001f;

	private const float PerpendicularWeight = 4f;

	private static readonly Vector3[] s_WorldCorners = new Vector3[4];

	private static readonly Dictionary<Selectable, SelectableEx> s_SelectableToSelection = new Dictionary<Selectable, SelectableEx>();

	private ViewControlLayer m_Layer;

	private Selectable m_Selectable;

	public SelectableDirection AllowedDirection = SelectableDirection.All;

	public bool WrapAround;

	public UnityEvent<bool> OnSelectChanged;

	public Selectable Selectable
	{
		get
		{
			if (!m_Selectable)
			{
				RefreshSelectable();
			}
			return m_Selectable;
		}
	}

	public ViewControlLayer Layer
	{
		get
		{
			if (!m_Layer)
			{
				RefreshLayer();
			}
			return m_Layer;
		}
	}

	public bool IsSelected
	{
		get
		{
			if (!EventSystemHelper.Available)
			{
				return false;
			}
			if (EventSystemHelper.CurrentSelected == null)
			{
				return false;
			}
			return EventSystemHelper.CurrentSelected == gameObject;
		}
	}

	protected override void Awake()
	{
		RefreshSelectable();
		RefreshLayer();
	}

	protected override void OnEnable()
	{
		if (!m_Selectable)
		{
			RefreshSelectable();
		}
		if ((bool)m_Selectable)
		{
			s_SelectableToSelection[m_Selectable] = this;
			m_Selectable.CustomFindSelectable = this;
			RefreshLayer();
		}
	}

	protected override void OnDisable()
	{
		if ((bool)m_Selectable)
		{
			s_SelectableToSelection.Remove(m_Selectable);
		}
		if ((bool)m_Selectable && m_Selectable.CustomFindSelectable as SelectableEx == this)
		{
			m_Selectable.CustomFindSelectable = null;
		}
		((IViewControlLayerInternal)m_Layer)?.OnChildUnavailable(this);
		((IViewControlLayerInternal)m_Layer)?.Unregister(this);
		m_Layer = null;
		if ((bool)EventSystemHelper.Shared && EventSystemHelper.RawSelected == gameObject)
		{
			EventSystemHelper.SetSelectedGameObject(null);
		}
	}

	protected override void OnTransformParentChanged()
	{
		RefreshLayer();
	}

	private void RefreshSelectable()
	{
		m_Selectable = GetComponent<Selectable>();
	}

	internal void RefreshLayer()
	{
		ViewControlLayer viewControlLayer = FindValidLayer();
		if (!(viewControlLayer == m_Layer))
		{
			if ((bool)m_Layer)
			{
				((IViewControlLayerInternal)m_Layer)?.OnChildUnavailable(this);
				((IViewControlLayerInternal)m_Layer)?.Unregister(this);
			}
			m_Layer = viewControlLayer;
			((IViewControlLayerInternal)m_Layer)?.Register(this);
		}
	}

	private ViewControlLayer FindValidLayer()
	{
		if (transform.parent == null)
		{
			return null;
		}
		return transform.parent.GetComponentInParent<ViewControlLayer>(includeInactive: true);
	}

	void ISelectHandler.OnSelect(BaseEventData eventData)
	{
		if (!m_Layer)
		{
			RefreshLayer();
		}
		((IViewControlLayerInternal)m_Layer)?.OnChildSelect(this);
		OnSelectChanged?.Invoke(arg0: true);
	}

	void IDeselectHandler.OnDeselect(BaseEventData eventData)
	{
		if (!m_Layer)
		{
			RefreshLayer();
		}
		((IViewControlLayerInternal)m_Layer)?.OnChildDeselect(this);
		OnSelectChanged?.Invoke(arg0: false);
	}

	public bool IsValid()
	{
		if (IsActive() && (bool)Selectable && Selectable.IsActive())
		{
			return Selectable.IsInteractable();
		}
		return false;
	}

	public virtual Selectable FindSelectableOnUp()
	{
		if ((AllowedDirection & SelectableDirection.Up) == 0)
		{
			return null;
		}
		return FindSelectable(transform.rotation * Vector3.up);
	}

	public virtual Selectable FindSelectableOnDown()
	{
		if ((AllowedDirection & SelectableDirection.Down) == 0)
		{
			return null;
		}
		return FindSelectable(transform.rotation * Vector3.down);
	}

	public virtual Selectable FindSelectableOnLeft()
	{
		if ((AllowedDirection & SelectableDirection.Left) == 0)
		{
			return null;
		}
		return FindSelectable(transform.rotation * Vector3.left);
	}

	public virtual Selectable FindSelectableOnRight()
	{
		if ((AllowedDirection & SelectableDirection.Right) == 0)
		{
			return null;
		}
		return FindSelectable(transform.rotation * Vector3.right);
	}

	public virtual Selectable FindSelectable(Vector3 dir)
	{
		if (!m_Layer)
		{
			RefreshLayer();
		}
		dir = dir.normalized;
		Vector3 vector = Quaternion.Inverse(transform.rotation) * dir;
		Vector3 vector2 = transform.TransformPoint(GetPointOnRectEdge(transform as RectTransform, vector));
		float num = float.NegativeInfinity;
		float num2 = float.NegativeInfinity;
		SelectableEx selectableEx = null;
		SelectableEx selectableEx2 = null;
		bool wrapAround = WrapAround;
		IEnumerable<SelectableEx> enumerable = m_Layer?.Selectables;
		if (enumerable == null)
		{
			return null;
		}
		foreach (SelectableEx item in enumerable)
		{
			if (!item.m_Selectable || !item.IsValid() || item == this)
			{
				continue;
			}
			RectTransform rectTransform = item.transform as RectTransform;
			Vector3 vector3;
			Vector3 vector4;
			if (rectTransform != null)
			{
				vector3 = item.transform.TransformPoint(rectTransform.rect.center) - vector2;
				Vector2 point = rectTransform.InverseTransformPoint(vector2);
				vector4 = (rectTransform.rect.Contains(point) ? vector3 : (GetClosestPointOnRect(rectTransform, vector2) - vector2));
			}
			else
			{
				vector4 = item.transform.position - vector2;
				vector3 = vector4;
			}
			float num3 = Vector3.Dot(dir, vector4);
			float b = Vector3.Dot(dir, vector3);
			float num4 = ((num3 > 0f) ? num3 : Mathf.Max(num3, b));
			if (wrapAround && num4 < 0f)
			{
				float num5 = 0f - num4;
				float num6 = 0f - GetPerpendicularSqrDistance(transform as RectTransform, rectTransform, dir, vector4, num3) + num5 * 0.001f;
				if (num6 > num2)
				{
					num2 = num6;
					selectableEx2 = item;
				}
			}
			else if (!(num4 <= 0f))
			{
				float perpendicularSqrDistance = GetPerpendicularSqrDistance(transform as RectTransform, rectTransform, dir, vector4, num3);
				float num6 = 0f - (num4 + Mathf.Sqrt(perpendicularSqrDistance) * 4f);
				if (num6 > num)
				{
					num = num6;
					selectableEx = item;
				}
			}
		}
		if (wrapAround && null == selectableEx)
		{
			return selectableEx2?.Selectable;
		}
		return selectableEx?.Selectable;
	}

	private static Vector3 GetPointOnRectEdge(RectTransform rect, Vector2 dir)
	{
		if (rect == null)
		{
			return Vector3.zero;
		}
		if (dir != Vector2.zero)
		{
			dir /= Mathf.Max(Mathf.Abs(dir.x), Mathf.Abs(dir.y));
		}
		dir = rect.rect.center + Vector2.Scale(rect.rect.size, dir * 0.5f);
		return dir;
	}

	private static Vector3 GetClosestPointOnRect(RectTransform rect, Vector3 worldPoint)
	{
		Vector3 position = rect.InverseTransformPoint(worldPoint);
		Rect rect2 = rect.rect;
		position.x = Mathf.Clamp(position.x, rect2.xMin, rect2.xMax);
		position.y = Mathf.Clamp(position.y, rect2.yMin, rect2.yMax);
		position.z = 0f;
		return rect.TransformPoint(position);
	}

	private static float GetPerpendicularSqrDistance(RectTransform fromRect, RectTransform toRect, Vector3 dir, Vector3 toVector, float dot)
	{
		if (fromRect == null || toRect == null)
		{
			return Mathf.Max(0f, toVector.sqrMagnitude - dot * dot);
		}
		Vector3 axis = Vector3.Cross(fromRect.rotation * Vector3.forward, dir);
		if (axis.sqrMagnitude <= Mathf.Epsilon)
		{
			return Mathf.Max(0f, toVector.sqrMagnitude - dot * dot);
		}
		axis.Normalize();
		GetRectProjection(fromRect, axis, out var min, out var max);
		GetRectProjection(toRect, axis, out var min2, out var max2);
		float num = 0f;
		if (max < min2)
		{
			num = min2 - max;
		}
		else if (max2 < min)
		{
			num = min - max2;
		}
		return num * num;
	}

	private static void GetRectProjection(RectTransform rect, Vector3 axis, out float min, out float max)
	{
		rect.GetWorldCorners(s_WorldCorners);
		min = (max = Vector3.Dot(axis, s_WorldCorners[0]));
		for (int i = 1; i < s_WorldCorners.Length; i++)
		{
			float b = Vector3.Dot(axis, s_WorldCorners[i]);
			min = Mathf.Min(min, b);
			max = Mathf.Max(max, b);
		}
	}
}
