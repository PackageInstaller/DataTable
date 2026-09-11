using System;
using UnityEngine;
using UnityEngine.EventSystems;

[RequireComponent(typeof(EventTriggerListener))]
public class EventTriggerListenerEX
{
	public LuaHelper.ETLCallBack1 onPointerEnter;

	public LuaHelper.ETLCallBack1 onPointerExit;

	public LuaHelper.ETLCallBack1 onPointerDown;

	public LuaHelper.ETLCallBack1 onPointerUp;

	public LuaHelper.ETLCallBack1 onPointerClick;

	public LuaHelper.ETLCallBack1 onInitializePotentialDrag;

	public LuaHelper.ETLCallBack1 onScroll;

	public LuaHelper.ETLCallBack1 onBeginDrag;

	public LuaHelper.ETLCallBack1 onDrag;

	public LuaHelper.ETLCallBack1 onEndDrag;

	public LuaHelper.ETLCallBack1 onDrop;

	public LuaHelper.ETLCallBack2 onSelect;

	public LuaHelper.ETLCallBack2 onUpdateSelect;

	public LuaHelper.ETLCallBack3 onMove;

	public void OnPointerClick(GameObject gameObject, PointerEventData eventData)
	{
		if (onPointerClick != null)
		{
			try
			{
				onPointerClick?.Invoke(gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("EventEx_OnPointerClick:" + ex);
			}
		}
	}

	public void OnPointerEnter(GameObject gameObject, PointerEventData eventData)
	{
		if (onPointerEnter != null)
		{
			try
			{
				onPointerEnter?.Invoke(gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("EventEx_OnPointerEnter:" + ex);
			}
		}
	}

	public void OnPointerExit(GameObject gameObject, PointerEventData eventData)
	{
		if (onPointerExit != null)
		{
			try
			{
				onPointerExit?.Invoke(gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("EventEx_OnPointerExit:" + ex);
			}
		}
	}

	public void OnPointerDown(GameObject gameObject, PointerEventData eventData)
	{
		if (onPointerDown != null)
		{
			try
			{
				onPointerDown?.Invoke(gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("EventEx_OnPointerDown:" + ex);
			}
		}
	}

	public void OnPointerUp(GameObject gameObject, PointerEventData eventData)
	{
		if (onPointerUp != null)
		{
			try
			{
				onPointerUp?.Invoke(gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("EventEx_OnPointerUp:" + ex);
			}
		}
	}

	public void OnInitializePotentialDrag(GameObject gameObject, PointerEventData eventData)
	{
		if (onInitializePotentialDrag != null)
		{
			try
			{
				onInitializePotentialDrag?.Invoke(gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("EventEx_OnInitializePotentialDrag:" + ex);
			}
		}
	}

	public void OnScroll(GameObject gameObject, PointerEventData eventData)
	{
		if (onScroll != null)
		{
			try
			{
				onScroll?.Invoke(gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("EventEx_OnScroll:" + ex);
			}
		}
	}

	public void OnBeginDrag(GameObject gameObject, PointerEventData eventData)
	{
		if (onBeginDrag != null)
		{
			try
			{
				onBeginDrag?.Invoke(gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("EventEx_OnBeginDrag:" + ex);
			}
		}
	}

	public void OnDrag(GameObject gameObject, PointerEventData eventData)
	{
		if (onDrag != null)
		{
			try
			{
				onDrag?.Invoke(gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("EventEx_OnDrag:" + ex);
			}
		}
	}

	public void OnEndDrag(GameObject gameObject, PointerEventData eventData)
	{
		if (onEndDrag != null)
		{
			try
			{
				onEndDrag?.Invoke(gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("EventEx_OnEndDrag:" + ex);
			}
		}
	}

	public void OnDrop(GameObject gameObject, PointerEventData eventData)
	{
		if (onDrop != null)
		{
			try
			{
				onDrop?.Invoke(gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("EventEx_OnDrop:" + ex);
			}
		}
	}

	public void OnMove(GameObject gameObject, AxisEventData eventData)
	{
		if (onMove != null)
		{
			try
			{
				onMove?.Invoke(gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("EventEx_OnMove:" + ex);
			}
		}
	}

	public void OnSelect(GameObject gameObject, BaseEventData eventData)
	{
		if (onSelect != null)
		{
			try
			{
				onSelect?.Invoke(gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("EventEx_OnSelect:" + ex);
			}
		}
	}

	public void OnUpdateSelected(GameObject gameObject, BaseEventData eventData)
	{
		if (onUpdateSelect != null)
		{
			try
			{
				onUpdateSelect?.Invoke(gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("EventEx_OnUpdateSelected:" + ex);
			}
		}
	}
}
