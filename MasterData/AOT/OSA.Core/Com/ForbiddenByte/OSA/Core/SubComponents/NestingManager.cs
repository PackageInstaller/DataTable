using UnityEngine;
using UnityEngine.EventSystems;

namespace Com.ForbiddenByte.OSA.Core.SubComponents;

internal class NestingManager<TParams, TItemViewsHolder> : IInitializePotentialDragHandler, IEventSystemHandler, IBeginDragHandler, IDragHandler, IEndDragHandler, IScrollHandler where TParams : BaseParams where TItemViewsHolder : BaseItemViewsHolder
{
	private OSA<TParams, TItemViewsHolder> _Adapter;

	private InternalState<TItemViewsHolder> _InternalState;

	private IInitializePotentialDragHandler parentInitializePotentialDragHandler;

	private IBeginDragHandler parentBeginDragHandler;

	private IDragHandler parentDragHandler;

	private IEndDragHandler parentEndDragHandler;

	private IScrollHandler parentScrollHandler;

	private bool _SearchedAtLeastOnce;

	private bool _CurrentDragCapturedByParent;

	private bool _CurrentScrollConsumedByParent;

	public bool SearchedParentAtLeastOnce => _SearchedAtLeastOnce;

	public bool CurrentDragCapturedByParent => _CurrentDragCapturedByParent;

	public bool CurrentScrollConsumedByParent => _CurrentScrollConsumedByParent;

	public NestingManager(OSA<TParams, TItemViewsHolder> adapter)
	{
		_Adapter = adapter;
		_InternalState = _Adapter._InternalState;
	}

	public void FindAndStoreNestedParent()
	{
		parentInitializePotentialDragHandler = null;
		parentBeginDragHandler = null;
		parentDragHandler = null;
		parentEndDragHandler = null;
		parentScrollHandler = null;
		Transform transform = _Adapter.transform;
		while ((bool)(transform = transform.parent) && parentInitializePotentialDragHandler == null)
		{
			parentInitializePotentialDragHandler = transform.GetComponent(typeof(IInitializePotentialDragHandler)) as IInitializePotentialDragHandler;
			if (parentInitializePotentialDragHandler == null)
			{
				continue;
			}
			parentBeginDragHandler = parentInitializePotentialDragHandler as IBeginDragHandler;
			if (parentBeginDragHandler == null)
			{
				parentInitializePotentialDragHandler = null;
				continue;
			}
			parentDragHandler = parentInitializePotentialDragHandler as IDragHandler;
			if (parentDragHandler == null)
			{
				parentInitializePotentialDragHandler = null;
				parentBeginDragHandler = null;
				continue;
			}
			parentEndDragHandler = parentInitializePotentialDragHandler as IEndDragHandler;
			if (parentEndDragHandler == null)
			{
				parentInitializePotentialDragHandler = null;
				parentBeginDragHandler = null;
				parentDragHandler = null;
			}
		}
		if (parentInitializePotentialDragHandler == null)
		{
			transform = _Adapter.transform;
			while ((bool)(transform = transform.parent) && parentScrollHandler == null)
			{
				parentScrollHandler = transform.GetComponent(typeof(IScrollHandler)) as IScrollHandler;
			}
		}
		else
		{
			parentScrollHandler = parentInitializePotentialDragHandler as IScrollHandler;
		}
		_SearchedAtLeastOnce = true;
	}

	public void OnInitializePotentialDrag(PointerEventData eventData)
	{
		_CurrentDragCapturedByParent = false;
		if (!_SearchedAtLeastOnce)
		{
			FindAndStoreNestedParent();
		}
		if (parentInitializePotentialDragHandler != null)
		{
			parentInitializePotentialDragHandler.OnInitializePotentialDrag(eventData);
		}
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		if (parentInitializePotentialDragHandler == null)
		{
			return;
		}
		if (_Adapter.Parameters.DragEnabled)
		{
			Vector2 delta = eventData.delta;
			float num = Mathf.Abs(delta.y) - Mathf.Abs(delta.x);
			_CurrentDragCapturedByParent = (float)_InternalState.hor1_vertMinus1 * num >= 0f;
			if (!_CurrentDragCapturedByParent)
			{
				_CurrentDragCapturedByParent = CheckForForwardingToParent(delta);
			}
		}
		else
		{
			_CurrentDragCapturedByParent = true;
		}
		if (_CurrentDragCapturedByParent)
		{
			parentBeginDragHandler.OnBeginDrag(eventData);
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (parentInitializePotentialDragHandler != null)
		{
			parentDragHandler.OnDrag(eventData);
		}
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		if (parentInitializePotentialDragHandler != null)
		{
			parentEndDragHandler.OnEndDrag(eventData);
			_CurrentDragCapturedByParent = false;
		}
	}

	public void OnScroll(PointerEventData eventData)
	{
		_CurrentScrollConsumedByParent = false;
		if (!_SearchedAtLeastOnce)
		{
			FindAndStoreNestedParent();
		}
		if (parentScrollHandler == null)
		{
			return;
		}
		if (_Adapter.Parameters.ScrollEnabled)
		{
			Vector2 scrollDelta = eventData.scrollDelta;
			scrollDelta.y *= -1f;
			Vector2 vec = scrollDelta;
			_Adapter.Parameters.ApplyScrollSensitivityTo(ref vec);
			if (vec[_InternalState.hor0_vert1] != 0f)
			{
				if (!CheckForForwardingToParent(vec))
				{
					return;
				}
			}
			else if (scrollDelta[_InternalState.hor0_vert1] == 0f && vec[1 - _InternalState.hor0_vert1] != 0f)
			{
				return;
			}
		}
		_CurrentScrollConsumedByParent = true;
		parentScrollHandler.OnScroll(eventData);
	}

	private bool CheckForForwardingToParent(Vector2 delta)
	{
		if (_Adapter.Parameters.ForwardDragSameDirectionAtBoundary)
		{
			float num = delta[_InternalState.hor0_vert1] * (float)_InternalState.hor1_vertMinus1;
			float num2 = 3f;
			if (num < 0f)
			{
				return _Adapter.ContentVirtualInsetFromViewportEnd >= (double)(0f - num2);
			}
			return _Adapter.ContentVirtualInsetFromViewportStart >= (double)(0f - num2);
		}
		return false;
	}
}
