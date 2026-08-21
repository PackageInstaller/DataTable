using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;

public class EventTriggerListener : EventTrigger
{
	[Flags]
	private enum EventPassMask
	{
		None = 0,
		PointerEnter = 1,
		PointerExit = 2,
		PointerDown = 4,
		PointerUp = 8,
		PointerClick = 0x10,
		Drag = 0x20,
		Drop = 0x40,
		Scroll = 0x80,
		InitializePotentialDrag = 0x1000,
		BeginDrag = 0x2000,
		EndDrag = 0x4000,
		All = -1
	}

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

	[SerializeField]
	private EventPassMask passEventMask;

	public bool isPassAll = true;

	public bool isExecuteHierarchy;

	private bool hasPassedEvent;

	[NonSerialized]
	[NoToLua]
	private EventTriggerListenerEX triggerEx;

	private List<RaycastResult> lastRaycastDragObject;

	private List<RaycastResult> lastRaycastPointObject;

	public bool alwaysPassDragToLastDragObject;

	public bool isPassEvent
	{
		get
		{
			return passEventMask != EventPassMask.None;
		}
		set
		{
			passEventMask = (value ? EventPassMask.All : EventPassMask.None);
		}
	}

	[NoToLua]
	public EventTriggerListenerEX GetEventTriggerEX()
	{
		if (triggerEx == null)
		{
			triggerEx = new EventTriggerListenerEX();
		}
		return triggerEx;
	}

	public static EventTriggerListener Get(GameObject go)
	{
		EventTriggerListener eventTriggerListener = go.GetComponent<EventTriggerListener>();
		if (eventTriggerListener == null)
		{
			eventTriggerListener = go.AddComponent<EventTriggerListener>();
		}
		return eventTriggerListener;
	}

	public void RemoveListenerType(EventTriggerType t)
	{
		switch (t)
		{
		case EventTriggerType.PointerClick:
			onPointerClick = null;
			break;
		case EventTriggerType.PointerDown:
			onPointerDown = null;
			break;
		case EventTriggerType.PointerEnter:
			onPointerEnter = null;
			break;
		case EventTriggerType.PointerExit:
			onPointerExit = null;
			break;
		case EventTriggerType.PointerUp:
			onPointerUp = null;
			break;
		case EventTriggerType.InitializePotentialDrag:
			onInitializePotentialDrag = null;
			break;
		case EventTriggerType.Scroll:
			onScroll = null;
			break;
		case EventTriggerType.BeginDrag:
			onBeginDrag = null;
			break;
		case EventTriggerType.Drag:
			onDrag = null;
			break;
		case EventTriggerType.EndDrag:
			onEndDrag = null;
			break;
		case EventTriggerType.Drop:
			onDrop = null;
			break;
		case EventTriggerType.Select:
			onSelect = null;
			break;
		case EventTriggerType.UpdateSelected:
			onUpdateSelect = null;
			break;
		case EventTriggerType.Move:
			onMove = null;
			break;
		case EventTriggerType.Deselect:
			break;
		}
	}

	public void RemoveAllListeners()
	{
		onPointerClick = null;
		onPointerDown = null;
		onPointerEnter = null;
		onPointerExit = null;
		onPointerUp = null;
		onInitializePotentialDrag = null;
		onScroll = null;
		onBeginDrag = null;
		onDrag = null;
		onEndDrag = null;
		onDrop = null;
		onSelect = null;
		onUpdateSelect = null;
		onMove = null;
	}

	public void AddListenerType1(EventTriggerType t, LuaHelper.ETLCallBack1 func)
	{
		switch (t)
		{
		case EventTriggerType.PointerClick:
			onPointerClick = func;
			break;
		case EventTriggerType.PointerDown:
			onPointerDown = func;
			break;
		case EventTriggerType.PointerEnter:
			onPointerEnter = func;
			break;
		case EventTriggerType.PointerExit:
			onPointerExit = func;
			break;
		case EventTriggerType.PointerUp:
			onPointerUp = func;
			break;
		case EventTriggerType.InitializePotentialDrag:
			onInitializePotentialDrag = func;
			break;
		case EventTriggerType.Scroll:
			onScroll = func;
			break;
		case EventTriggerType.BeginDrag:
			onBeginDrag = func;
			break;
		case EventTriggerType.Drag:
			onDrag = func;
			break;
		case EventTriggerType.EndDrag:
			onEndDrag = func;
			break;
		case EventTriggerType.Drop:
			onDrop = func;
			break;
		case EventTriggerType.UpdateSelected:
		case EventTriggerType.Select:
		case EventTriggerType.Deselect:
		case EventTriggerType.Move:
			break;
		}
	}

	public void AddListenerType2(EventTriggerType t, LuaHelper.ETLCallBack2 func)
	{
		switch (t)
		{
		case EventTriggerType.Select:
			onSelect = func;
			break;
		case EventTriggerType.UpdateSelected:
			onUpdateSelect = func;
			break;
		}
	}

	public void AddListenerType3(EventTriggerType t, LuaHelper.ETLCallBack3 func)
	{
		if (t == EventTriggerType.Move)
		{
			onMove = func;
		}
	}

	public override void OnPointerClick(PointerEventData eventData)
	{
		base.OnPointerClick(eventData);
		if (onPointerClick != null)
		{
			try
			{
				onPointerClick(base.gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("OnPointerClick:" + ex);
			}
		}
		if (passEventMask.HasFlag(EventPassMask.PointerClick))
		{
			PassEvent(eventData, ExecuteEvents.pointerClickHandler);
		}
		triggerEx?.OnPointerClick(base.gameObject, eventData);
	}

	public override void OnPointerEnter(PointerEventData eventData)
	{
		base.OnPointerEnter(eventData);
		if (onPointerEnter != null)
		{
			try
			{
				onPointerEnter(base.gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("OnPointerEnter:" + ex);
			}
		}
		if (passEventMask.HasFlag(EventPassMask.PointerEnter))
		{
			PassEvent(eventData, ExecuteEvents.pointerEnterHandler);
		}
		triggerEx?.OnPointerEnter(base.gameObject, eventData);
	}

	public override void OnPointerExit(PointerEventData eventData)
	{
		base.OnPointerExit(eventData);
		if (onPointerExit != null)
		{
			try
			{
				onPointerExit(base.gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("OnPointerExit:" + ex);
			}
		}
		if (passEventMask.HasFlag(EventPassMask.PointerExit))
		{
			PassEvent(eventData, ExecuteEvents.pointerExitHandler);
		}
		triggerEx?.OnPointerExit(base.gameObject, eventData);
	}

	public override void OnPointerDown(PointerEventData eventData)
	{
		base.OnPointerDown(eventData);
		if (onPointerDown != null)
		{
			try
			{
				onPointerDown(base.gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("OnPointerDown:" + ex);
			}
		}
		if (passEventMask.HasFlag(EventPassMask.PointerDown))
		{
			PassEvent(eventData, ExecuteEvents.pointerDownHandler, EventTriggerType.PointerDown);
		}
		triggerEx?.OnPointerDown(base.gameObject, eventData);
	}

	public override void OnPointerUp(PointerEventData eventData)
	{
		base.OnPointerUp(eventData);
		if (onPointerUp != null)
		{
			try
			{
				onPointerUp(base.gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("OnPointerUp:" + ex);
			}
		}
		if (passEventMask.HasFlag(EventPassMask.PointerUp))
		{
			PassEvent(eventData, ExecuteEvents.pointerUpHandler, EventTriggerType.PointerUp);
		}
		triggerEx?.OnPointerUp(base.gameObject, eventData);
	}

	public void PassEvent<T>(PointerEventData data, ExecuteEvents.EventFunction<T> function, EventTriggerType eventTriggerType = EventTriggerType.PointerEnter) where T : IEventSystemHandler
	{
		if (hasPassedEvent)
		{
			return;
		}
		hasPassedEvent = true;
		List<RaycastResult> list = new List<RaycastResult>();
		EventSystem.current.RaycastAll(data, list);
		switch (eventTriggerType)
		{
		case EventTriggerType.BeginDrag:
			lastRaycastDragObject = list;
			break;
		case EventTriggerType.PointerDown:
			lastRaycastPointObject = list;
			break;
		}
		List<GameObject> list2 = new List<GameObject>();
		GameObject gameObject = data.pointerCurrentRaycast.gameObject;
		Action<GameObject, BaseEventData, ExecuteEvents.EventFunction<T>> action = (isExecuteHierarchy ? new Action<GameObject, BaseEventData, ExecuteEvents.EventFunction<T>>(ExecuteHierarchy) : new Action<GameObject, BaseEventData, ExecuteEvents.EventFunction<T>>(Execute));
		for (int i = 0; i < list.Count; i++)
		{
			if (gameObject != list[i].gameObject)
			{
				action(list[i].gameObject, data, function);
				list2.Add(list[i].gameObject);
				if (!isPassAll)
				{
					break;
				}
			}
		}
		if (eventTriggerType == EventTriggerType.EndDrag && lastRaycastDragObject != null)
		{
			for (int j = 0; j < lastRaycastDragObject.Count; j++)
			{
				if (gameObject != lastRaycastDragObject[j].gameObject && !list2.Contains(lastRaycastDragObject[j].gameObject))
				{
					action(lastRaycastDragObject[j].gameObject, data, function);
					if (!isPassAll)
					{
						break;
					}
				}
			}
			lastRaycastDragObject.Clear();
		}
		else if (alwaysPassDragToLastDragObject && eventTriggerType == EventTriggerType.Drag && lastRaycastDragObject != null)
		{
			for (int k = 0; k < lastRaycastDragObject.Count; k++)
			{
				if (gameObject != lastRaycastDragObject[k].gameObject && !list2.Contains(lastRaycastDragObject[k].gameObject))
				{
					action(lastRaycastDragObject[k].gameObject, data, function);
					if (!isPassAll)
					{
						break;
					}
				}
			}
		}
		else if (eventTriggerType == EventTriggerType.PointerUp && lastRaycastPointObject != null)
		{
			for (int l = 0; l < lastRaycastPointObject.Count; l++)
			{
				if (gameObject != lastRaycastPointObject[l].gameObject && !list2.Contains(lastRaycastPointObject[l].gameObject))
				{
					action(lastRaycastPointObject[l].gameObject, data, function);
					if (!isPassAll)
					{
						break;
					}
				}
			}
			lastRaycastPointObject.Clear();
		}
		list2.Clear();
		hasPassedEvent = false;
		static void Execute(GameObject obj, BaseEventData eventData, ExecuteEvents.EventFunction<T> func)
		{
			ExecuteEvents.Execute(obj, eventData, func);
		}
		static void ExecuteHierarchy(GameObject obj, BaseEventData eventData, ExecuteEvents.EventFunction<T> func)
		{
			ExecuteEvents.ExecuteHierarchy(obj, eventData, func);
		}
	}

	public override void OnInitializePotentialDrag(PointerEventData eventData)
	{
		base.OnInitializePotentialDrag(eventData);
		if (onInitializePotentialDrag != null)
		{
			try
			{
				onInitializePotentialDrag(base.gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("OnInitializePotentialDrag:" + ex);
			}
		}
		if (passEventMask.HasFlag(EventPassMask.InitializePotentialDrag))
		{
			PassEvent(eventData, ExecuteEvents.initializePotentialDrag, EventTriggerType.InitializePotentialDrag);
		}
		triggerEx?.OnInitializePotentialDrag(base.gameObject, eventData);
	}

	public override void OnScroll(PointerEventData eventData)
	{
		base.OnScroll(eventData);
		if (onScroll != null)
		{
			try
			{
				onScroll(base.gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("OnScroll:" + ex);
			}
		}
		if (passEventMask.HasFlag(EventPassMask.Scroll))
		{
			PassEvent(eventData, ExecuteEvents.scrollHandler, EventTriggerType.Scroll);
		}
		triggerEx?.OnScroll(base.gameObject, eventData);
	}

	public override void OnBeginDrag(PointerEventData eventData)
	{
		if (eventData.button != PointerEventData.InputButton.Left)
		{
			return;
		}
		base.OnBeginDrag(eventData);
		if (onBeginDrag != null)
		{
			try
			{
				onBeginDrag(base.gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("OnBeginDrag:" + ex);
			}
		}
		if (passEventMask.HasFlag(EventPassMask.BeginDrag))
		{
			PassEvent(eventData, ExecuteEvents.beginDragHandler, EventTriggerType.BeginDrag);
		}
		triggerEx?.OnBeginDrag(base.gameObject, eventData);
	}

	public override void OnDrag(PointerEventData eventData)
	{
		if (eventData.button != PointerEventData.InputButton.Left)
		{
			return;
		}
		base.OnDrag(eventData);
		if (onDrag != null)
		{
			try
			{
				onDrag(base.gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("OnDrag:" + ex);
			}
		}
		if (passEventMask.HasFlag(EventPassMask.Drag))
		{
			PassEvent(eventData, ExecuteEvents.dragHandler, EventTriggerType.Drag);
		}
		triggerEx?.OnDrag(base.gameObject, eventData);
	}

	public override void OnEndDrag(PointerEventData eventData)
	{
		if (eventData.button != PointerEventData.InputButton.Left)
		{
			return;
		}
		base.OnEndDrag(eventData);
		if (onEndDrag != null)
		{
			try
			{
				onEndDrag(base.gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("OnEndDrag:" + ex);
			}
		}
		if (passEventMask.HasFlag(EventPassMask.EndDrag))
		{
			base.OnEndDrag(eventData);
			PassEvent(eventData, ExecuteEvents.endDragHandler, EventTriggerType.EndDrag);
		}
		triggerEx?.OnEndDrag(base.gameObject, eventData);
	}

	public override void OnDrop(PointerEventData eventData)
	{
		base.OnDrop(eventData);
		if (onDrop != null)
		{
			try
			{
				onDrop(base.gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("OnDrop:" + ex);
			}
		}
		if (passEventMask.HasFlag(EventPassMask.Drop))
		{
			PassEvent(eventData, ExecuteEvents.dropHandler, EventTriggerType.Drop);
		}
		triggerEx?.OnDrop(base.gameObject, eventData);
	}

	public override void OnMove(AxisEventData eventData)
	{
		base.OnMove(eventData);
		if (onMove != null)
		{
			try
			{
				onMove(base.gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("OnMove:" + ex);
			}
		}
		triggerEx?.OnMove(base.gameObject, eventData);
	}

	public override void OnSelect(BaseEventData eventData)
	{
		base.OnSelect(eventData);
		if (onSelect != null)
		{
			try
			{
				onSelect(base.gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("OnSelect:" + ex);
			}
		}
		triggerEx?.OnSelect(base.gameObject, eventData);
	}

	public override void OnUpdateSelected(BaseEventData eventData)
	{
		base.OnUpdateSelected(eventData);
		if (onUpdateSelect != null)
		{
			try
			{
				onUpdateSelect(base.gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("OnUpdateSelected:" + ex);
			}
		}
		triggerEx?.OnUpdateSelected(base.gameObject, eventData);
	}
}
