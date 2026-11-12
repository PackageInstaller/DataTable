using System;
using UnityEngine;
using UnityEngine.EventSystems;

public class TowerDefensePointerEvent : MonoBehaviour, IDragHandler, IEventSystemHandler, IPointerDownHandler, IPointerUpHandler, IPointerClickHandler, IPointerEnterHandler, IPointerExitHandler
{
	public struct TowerDefensePointerEventData
	{
		public Vector3 screenPosition;

		public int index;

		public Vector3 worldPosition;
	}

	public Action<TowerDefensePointerEventData> onDrag;

	public Action<TowerDefensePointerEventData> onDown;

	public Action<TowerDefensePointerEventData> onUp;

	public Action<TowerDefensePointerEventData> onClick;

	public Action<TowerDefensePointerEventData> onEnter;

	public Action<TowerDefensePointerEventData> onExit;

	private TowerDefensePointerEventData data;

	public int index => data.index;

	public void Init(int index)
	{
		data = default;
		data.index = index;
	}

	public void OnDrag(PointerEventData eventData)
	{
		data.screenPosition = eventData.position;
		onDrag?.Invoke(data);
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		data.screenPosition = eventData.position;
		onDown?.Invoke(data);
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		data.screenPosition = eventData.position;
		onUp?.Invoke(data);
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		data.screenPosition = eventData.position;
		onClick?.Invoke(data);
	}

	public void Clear()
	{
		onDrag = null;
		onDown = null;
		onUp = null;
		onClick = null;
		onEnter = null;
		onExit = null;
		data.index = -1;
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		onEnter?.Invoke(data);
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		onExit?.Invoke(data);
	}
}
