using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

[DisallowMultipleComponent]
[AddComponentMenu("")]
internal sealed class LoopScrollBillboardDragHook : MonoBehaviour, IBeginDragHandler, IEventSystemHandler, IEndDragHandler
{
	private LoopScrollBillboard _owner;

	public void Bind(LoopScrollBillboard owner)
	{
		_owner = owner;
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		_owner?.NotifyBeginDrag();
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		_owner?.NotifyEndDrag();
	}
}
