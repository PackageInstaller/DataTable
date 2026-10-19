using System;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;

namespace ACT.UI.InputController;

internal static class EventSystemHelper
{
	public static UnityAction OnSelectedGameObjectChanged;

	public static EventSystem Shared => EventSystem.current;

	public static bool Available => EventSystem.current != null;

	public static GameObject RawSelected
	{
		get
		{
			if (!(EventSystem.current != null))
			{
				return null;
			}
			return EventSystem.current.currentSelectedGameObject;
		}
	}

	public static GameObject CurrentSelected
	{
		get
		{
			GameObject rawSelected = RawSelected;
			if (!rawSelected)
			{
				return null;
			}
			ViewControlLayer componentInParent = rawSelected.GetComponentInParent<ViewControlLayer>(includeInactive: true);
			if ((bool)componentInParent && !componentInParent.CanInteract())
			{
				return null;
			}
			return rawSelected;
		}
	}

	public static bool HasSelection => CurrentSelected != null;

	public static bool CanInteract(GameObject go)
	{
		if (!go)
		{
			return true;
		}
		ViewControlRoot componentInParent = go.GetComponentInParent<ViewControlRoot>(includeInactive: true);
		if ((bool)componentInParent)
		{
			return componentInParent.CanInteract();
		}
		return true;
	}

	public static bool CanInteract(Component component)
	{
		if (!(component == null))
		{
			return CanInteract(component.gameObject);
		}
		return true;
	}

	public static bool SetSelectedGameObject(GameObject go)
	{
		EventSystem current = EventSystem.current;
		if (current == null)
		{
			return false;
		}
		if ((bool)go && !CanInteract(go))
		{
			return false;
		}
		if (current.currentSelectedGameObject == go)
		{
			return false;
		}
		if (current.alreadySelecting)
		{
			return false;
		}
		try
		{
			current.SetSelectedGameObject(go);
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
			return false;
		}
		try
		{
			OnSelectedGameObjectChanged?.Invoke();
		}
		catch (Exception exception2)
		{
			Debug.LogException(exception2);
		}
		return true;
	}

	public static bool Click(GameObject go)
	{
		if (!go)
		{
			return false;
		}
		if (!CanInteract(go))
		{
			return false;
		}
		EventSystem current = EventSystem.current;
		if (current == null)
		{
			return false;
		}
		try
		{
			ExecuteEvents.Execute(go, new BaseEventData(current), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler?.OnSubmit(data);
			});
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
			return false;
		}
		return true;
	}

	public static bool Click(Component component)
	{
		if (component != null)
		{
			return Click(component.gameObject);
		}
		return false;
	}

	public static bool ClickPointer(Component component)
	{
		if (component != null)
		{
			return ClickPointer(component.gameObject);
		}
		return false;
	}

	public static bool ClickPointer(GameObject go)
	{
		if (!go)
		{
			return false;
		}
		if (!CanInteract(go))
		{
			return false;
		}
		EventSystem current = EventSystem.current;
		if (current == null)
		{
			return false;
		}
		PointerEventData eventData = new PointerEventData(current)
		{
			position = GetScreenPoint(go)
		};
		try
		{
			ExecuteEvents.Execute(go, eventData, (IPointerClickHandler handler, BaseEventData data) =>
			{
				handler?.OnPointerClick(data as PointerEventData);
			});
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
			return false;
		}
		return true;
	}

	public static bool ClickCurrent()
	{
		GameObject currentSelected = CurrentSelected;
		if (!currentSelected)
		{
			return false;
		}
		return Click(currentSelected);
	}

	private static Vector2 GetScreenPoint(GameObject go)
	{
		if (!(go.transform is RectTransform rectTransform))
		{
			return Vector2.zero;
		}
		Canvas componentInParent = go.GetComponentInParent<Canvas>();
		return RectTransformUtility.WorldToScreenPoint((componentInParent != null && componentInParent.renderMode != RenderMode.ScreenSpaceOverlay) ? componentInParent.worldCamera : null, rectTransform.TransformPoint(rectTransform.rect.center));
	}
}
