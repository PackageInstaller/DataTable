using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class LoopScrollDragPassThrough : MonoBehaviour, IInitializePotentialDragHandler, IEventSystemHandler, IBeginDragHandler, IDragHandler, IEndDragHandler
{
	private LoopScrollRectBase _target;

	private Transform _resolveFrom;

	private LoopScrollRectBase GetTarget()
	{
		Transform parent = transform.parent;
		if (_target != null && _resolveFrom == parent)
		{
			return _target;
		}
		_resolveFrom = parent;
		_target = null;
		while (parent != null)
		{
			LoopScrollRectBase component = parent.GetComponent<LoopScrollRectBase>();
			if (component != null)
			{
				_target = component;
				break;
			}
			parent = parent.parent;
		}
		return _target;
	}

	public void OnInitializePotentialDrag(PointerEventData eventData)
	{
		LoopScrollRectBase target = GetTarget();
		if (target != null)
		{
			target.InitializePotentialDragScrollView(eventData);
		}
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		LoopScrollRectBase target = GetTarget();
		if (target != null)
		{
			target.OnBeginDrag(eventData);
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		LoopScrollRectBase target = GetTarget();
		if (target != null)
		{
			target.OnDrag(eventData);
		}
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		LoopScrollRectBase target = GetTarget();
		if (target != null)
		{
			target.OnEndDrag(eventData);
		}
	}
}
