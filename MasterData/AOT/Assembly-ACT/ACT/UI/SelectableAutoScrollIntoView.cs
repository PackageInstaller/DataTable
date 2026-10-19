using System;
using System.Collections.Generic;
using ACT.UI.InputController;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace ACT.UI;

[DisallowMultipleComponent]
public class SelectableAutoScrollIntoView : MonoBehaviour
{
	[SerializeField]
	[Min(0f)]
	private float edgePadding;

	private readonly HashSet<GameObject> _selectables = new HashSet<GameObject>();

	private readonly Vector3[] _corners = new Vector3[4];

	private RectTransform _containerRect;

	private GameObject _lastSelected;

	private void Awake()
	{
		_containerRect = transform as RectTransform;
	}

	private void OnEnable()
	{
		CollectSelectables();
		_lastSelected = null;
		EventSystemHelper.OnSelectedGameObjectChanged = (UnityAction)Delegate.Combine(EventSystemHelper.OnSelectedGameObjectChanged, new UnityAction(CheckBounds));
	}

	private void OnDisable()
	{
		EventSystemHelper.OnSelectedGameObjectChanged = (UnityAction)Delegate.Remove(EventSystemHelper.OnSelectedGameObjectChanged, new UnityAction(CheckBounds));
	}

	private void CheckBounds()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == _lastSelected))
		{
			_lastSelected = currentSelected;
			if (!(currentSelected == null) && IsCollectedSelectable(currentSelected))
			{
				RevealSelected(currentSelected);
			}
		}
	}

	public void CollectSelectables()
	{
		_selectables.Clear();
		Selectable[] componentsInChildren = GetComponentsInChildren<Selectable>(includeInactive: true);
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			if (componentsInChildren[i] != null)
			{
				_selectables.Add(componentsInChildren[i].gameObject);
			}
		}
	}

	private bool IsCollectedSelectable(GameObject target)
	{
		if (_selectables.Contains(target))
		{
			return true;
		}
		if (target.GetComponent<Selectable>() != null && target.transform.IsChildOf(transform))
		{
			_selectables.Add(target);
			return true;
		}
		return false;
	}

	private void RevealSelected(GameObject selected)
	{
		if (_containerRect == null)
		{
			return;
		}
		RectTransform rectTransform = selected.transform as RectTransform;
		if (rectTransform == null || !rectTransform.gameObject.activeInHierarchy || !TryGetBoundsInContainer(rectTransform, out var bounds))
		{
			return;
		}
		Vector2 vector = CalculateRevealOffset(bounds);
		if (vector.sqrMagnitude <= 0.0001f)
		{
			return;
		}
		if (TryFindParentScrollView(rectTransform.parent, out var loopScrollRect, out var scrollRect))
		{
			if (loopScrollRect != null)
			{
				RectTransform content = loopScrollRect.content;
				if (content != null)
				{
					loopScrollRect.StopMovement();
					content.anchoredPosition -= ToParentLocalOffset(MaskOffsetByAxis(vector, loopScrollRect.horizontal, loopScrollRect.vertical), content.parent as RectTransform);
					loopScrollRect.UpdateBounds(updateItems: true);
				}
			}
			else if (scrollRect != null)
			{
				RectTransform content2 = scrollRect.content;
				if (content2 != null)
				{
					scrollRect.StopMovement();
					content2.anchoredPosition -= ToParentLocalOffset(MaskOffsetByAxis(vector, scrollRect.horizontal, scrollRect.vertical), content2.parent as RectTransform);
				}
			}
		}
		else
		{
			rectTransform.anchoredPosition -= ToParentLocalOffset(vector, rectTransform.parent as RectTransform);
		}
	}

	private static bool TryFindParentScrollView(Transform start, out LoopScrollRectBase loopScrollRect, out ScrollRect scrollRect)
	{
		loopScrollRect = null;
		scrollRect = null;
		Transform transform = start;
		while (transform != null)
		{
			LoopScrollRectBase component = transform.GetComponent<LoopScrollRectBase>();
			if (component != null)
			{
				loopScrollRect = component;
				return true;
			}
			ScrollRect component2 = transform.GetComponent<ScrollRect>();
			if (component2 != null)
			{
				scrollRect = component2;
				return true;
			}
			transform = transform.parent;
		}
		return false;
	}

	private static Vector2 MaskOffsetByAxis(Vector2 offset, bool horizontal, bool vertical)
	{
		return new Vector2(horizontal ? offset.x : 0f, vertical ? offset.y : 0f);
	}

	private bool TryGetBoundsInContainer(RectTransform target, out Bounds bounds)
	{
		bounds = default;
		if (_containerRect == null)
		{
			return false;
		}
		target.GetWorldCorners(_corners);
		Vector3 center = _containerRect.InverseTransformPoint(_corners[0]);
		bounds = new Bounds(center, Vector3.zero);
		for (int i = 1; i < _corners.Length; i++)
		{
			bounds.Encapsulate(_containerRect.InverseTransformPoint(_corners[i]));
		}
		return true;
	}

	private Vector2 CalculateRevealOffset(Bounds targetBounds)
	{
		Rect rect = _containerRect.rect;
		float num = rect.xMin + edgePadding;
		float num2 = rect.xMax - edgePadding;
		float num3 = rect.yMin + edgePadding;
		float num4 = rect.yMax - edgePadding;
		Vector2 zero = Vector2.zero;
		if (targetBounds.min.x < num)
		{
			zero.x = targetBounds.min.x - num;
		}
		else if (targetBounds.max.x > num2)
		{
			zero.x = targetBounds.max.x - num2;
		}
		if (targetBounds.min.y < num3)
		{
			zero.y = targetBounds.min.y - num3;
		}
		else if (targetBounds.max.y > num4)
		{
			zero.y = targetBounds.max.y - num4;
		}
		return zero;
	}

	private Vector2 ToParentLocalOffset(Vector2 containerLocalOffset, RectTransform targetParent)
	{
		if (targetParent == null)
		{
			return containerLocalOffset;
		}
		Vector3 vector = _containerRect.TransformVector(containerLocalOffset.x, containerLocalOffset.y, 0f);
		Vector3 vector2 = targetParent.InverseTransformVector(vector);
		return new Vector2(vector2.x, vector2.y);
	}
}
