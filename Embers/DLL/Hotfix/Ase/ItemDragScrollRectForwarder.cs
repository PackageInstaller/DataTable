using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Ase;

[DisallowMultipleComponent]
public class ItemDragScrollRectForwarder : MonoBehaviour, IInitializePotentialDragHandler, IEventSystemHandler, IBeginDragHandler, IDragHandler, IEndDragHandler
{
	[SerializeField]
	private MonoBehaviour dragTarget;

	[SerializeField]
	private ScrollRect upperScrollRect;

	private IInitializePotentialDragHandler dragInit;

	private IBeginDragHandler dragBegin;

	private IDragHandler dragDrag;

	private IEndDragHandler dragEnd;

	private void Awake()
	{
		CacheInterfaces();
	}

	private void CacheInterfaces()
	{
		dragInit = dragTarget as IInitializePotentialDragHandler;
		dragBegin = dragTarget as IBeginDragHandler;
		dragDrag = dragTarget as IDragHandler;
		dragEnd = dragTarget as IEndDragHandler;
	}

	public void OnInitializePotentialDrag(PointerEventData eventData)
	{
		dragInit?.OnInitializePotentialDrag(eventData);
		upperScrollRect?.OnInitializePotentialDrag(eventData);
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		eventData.eligibleForClick = false;
		dragBegin?.OnBeginDrag(eventData);
		upperScrollRect?.OnBeginDrag(eventData);
	}

	public void OnDrag(PointerEventData eventData)
	{
		dragDrag?.OnDrag(eventData);
		upperScrollRect?.OnDrag(eventData);
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		dragEnd?.OnEndDrag(eventData);
		upperScrollRect?.OnEndDrag(eventData);
	}
}
