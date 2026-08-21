using System;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Ase;

public class DragItem : MonoBehaviour, IBeginDragHandler, IEventSystemHandler, IEndDragHandler, IDragHandler
{
	private float lastX;

	private float ratio = 1f;

	private Action<Vector3> rotateAction;

	public void SetParam(float ratio, Action<Vector3> rA)
	{
		this.ratio = ratio;
		rotateAction = rA;
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		lastX = eventData.position.x;
	}

	public void OnEndDrag(PointerEventData eventData)
	{
	}

	public void OnDrag(PointerEventData eventData)
	{
		float num = eventData.position.x - lastX;
		Vector3 obj = new Vector3(0f, (0f - num) * ratio, 0f);
		rotateAction(obj);
		lastX = eventData.position.x;
	}
}
