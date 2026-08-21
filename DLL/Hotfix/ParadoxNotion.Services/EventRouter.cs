using System;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ParadoxNotion.Services;

public class EventRouter : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler, IPointerDownHandler, IPointerUpHandler, IPointerClickHandler, IDragHandler, IScrollHandler, IUpdateSelectedHandler, ISelectHandler, IDeselectHandler, IMoveHandler, ISubmitHandler, IDropHandler
{
	public delegate void EventDelegate(EventData msg);

	public delegate void EventDelegate<T>(EventData<T> msg);

	public delegate void CustomEventDelegate(string name, IEventData data);

	private EventRouterAnimatorMove _routerAnimatorMove;

	public event EventDelegate<PointerEventData> onPointerEnter;

	public event EventDelegate<PointerEventData> onPointerExit;

	public event EventDelegate<PointerEventData> onPointerDown;

	public event EventDelegate<PointerEventData> onPointerUp;

	public event EventDelegate<PointerEventData> onPointerClick;

	public event EventDelegate<PointerEventData> onDrag;

	public event EventDelegate<PointerEventData> onDrop;

	public event EventDelegate<PointerEventData> onScroll;

	public event EventDelegate<BaseEventData> onUpdateSelected;

	public event EventDelegate<BaseEventData> onSelect;

	public event EventDelegate<BaseEventData> onDeselect;

	public event EventDelegate<AxisEventData> onMove;

	public event EventDelegate<BaseEventData> onSubmit;

	public event EventDelegate onMouseDown;

	public event EventDelegate onMouseDrag;

	public event EventDelegate onMouseEnter;

	public event EventDelegate onMouseExit;

	public event EventDelegate onMouseOver;

	public event EventDelegate onMouseUp;

	public event EventDelegate onEnable;

	public event EventDelegate onDisable;

	public event EventDelegate onDestroy;

	public event EventDelegate onTransformChildrenChanged;

	public event EventDelegate onTransformParentChanged;

	public event EventDelegate<int> onAnimatorIK;

	public event EventDelegate onAnimatorMove
	{
		add
		{
			if (_routerAnimatorMove == null)
			{
				_routerAnimatorMove = base.gameObject.GetAddComponent<EventRouterAnimatorMove>();
			}
			_routerAnimatorMove.onAnimatorMove += value;
		}
		remove
		{
			if (_routerAnimatorMove != null)
			{
				_routerAnimatorMove.onAnimatorMove -= value;
			}
		}
	}

	public event EventDelegate onBecameInvisible;

	public event EventDelegate onBecameVisible;

	public event EventDelegate<ControllerColliderHit> onControllerColliderHit;

	public event EventDelegate<GameObject> onParticleCollision;

	public event EventDelegate<Collision> onCollisionEnter;

	public event EventDelegate<Collision> onCollisionExit;

	public event EventDelegate<Collision> onCollisionStay;

	public event EventDelegate<Collision2D> onCollisionEnter2D;

	public event EventDelegate<Collision2D> onCollisionExit2D;

	public event EventDelegate<Collision2D> onCollisionStay2D;

	public event EventDelegate<Collider> onTriggerEnter;

	public event EventDelegate<Collider> onTriggerExit;

	public event EventDelegate<Collider> onTriggerStay;

	public event EventDelegate<Collider2D> onTriggerEnter2D;

	public event EventDelegate<Collider2D> onTriggerExit2D;

	public event EventDelegate<Collider2D> onTriggerStay2D;

	public event Action<RenderTexture, RenderTexture> onRenderImage;

	public event EventDelegate onDrawGizmos;

	public event CustomEventDelegate onCustomEvent;

	void IPointerEnterHandler.OnPointerEnter(PointerEventData eventData)
	{
		if (onPointerEnter != null)
		{
			onPointerEnter(new EventData<PointerEventData>(eventData, base.gameObject, this));
		}
	}

	void IPointerExitHandler.OnPointerExit(PointerEventData eventData)
	{
		if (onPointerExit != null)
		{
			onPointerExit(new EventData<PointerEventData>(eventData, base.gameObject, this));
		}
	}

	void IPointerDownHandler.OnPointerDown(PointerEventData eventData)
	{
		if (onPointerDown != null)
		{
			onPointerDown(new EventData<PointerEventData>(eventData, base.gameObject, this));
		}
	}

	void IPointerUpHandler.OnPointerUp(PointerEventData eventData)
	{
		if (onPointerUp != null)
		{
			onPointerUp(new EventData<PointerEventData>(eventData, base.gameObject, this));
		}
	}

	void IPointerClickHandler.OnPointerClick(PointerEventData eventData)
	{
		if (onPointerClick != null)
		{
			onPointerClick(new EventData<PointerEventData>(eventData, base.gameObject, this));
		}
	}

	void IDragHandler.OnDrag(PointerEventData eventData)
	{
		if (onDrag != null)
		{
			onDrag(new EventData<PointerEventData>(eventData, base.gameObject, this));
		}
	}

	void IDropHandler.OnDrop(PointerEventData eventData)
	{
		if (onDrop != null)
		{
			onDrop(new EventData<PointerEventData>(eventData, base.gameObject, this));
		}
	}

	void IScrollHandler.OnScroll(PointerEventData eventData)
	{
		if (onScroll != null)
		{
			onScroll(new EventData<PointerEventData>(eventData, base.gameObject, this));
		}
	}

	void IUpdateSelectedHandler.OnUpdateSelected(BaseEventData eventData)
	{
		if (onUpdateSelected != null)
		{
			onUpdateSelected(new EventData<BaseEventData>(eventData, base.gameObject, this));
		}
	}

	void ISelectHandler.OnSelect(BaseEventData eventData)
	{
		if (onSelect != null)
		{
			onSelect(new EventData<BaseEventData>(eventData, base.gameObject, this));
		}
	}

	void IDeselectHandler.OnDeselect(BaseEventData eventData)
	{
		if (onDeselect != null)
		{
			onDeselect(new EventData<BaseEventData>(eventData, base.gameObject, this));
		}
	}

	void IMoveHandler.OnMove(AxisEventData eventData)
	{
		if (onMove != null)
		{
			onMove(new EventData<AxisEventData>(eventData, base.gameObject, this));
		}
	}

	void ISubmitHandler.OnSubmit(BaseEventData eventData)
	{
		if (onSubmit != null)
		{
			onSubmit(new EventData<BaseEventData>(eventData, base.gameObject, this));
		}
	}

	private void OnMouseDown()
	{
		if (onMouseDown != null)
		{
			onMouseDown(new EventData(base.gameObject, this));
		}
	}

	private void OnMouseDrag()
	{
		if (onMouseDrag != null)
		{
			onMouseDrag(new EventData(base.gameObject, this));
		}
	}

	private void OnMouseEnter()
	{
		if (onMouseEnter != null)
		{
			onMouseEnter(new EventData(base.gameObject, this));
		}
	}

	private void OnMouseExit()
	{
		if (onMouseExit != null)
		{
			onMouseExit(new EventData(base.gameObject, this));
		}
	}

	private void OnMouseOver()
	{
		if (onMouseOver != null)
		{
			onMouseOver(new EventData(base.gameObject, this));
		}
	}

	private void OnMouseUp()
	{
		if (onMouseUp != null)
		{
			onMouseUp(new EventData(base.gameObject, this));
		}
	}

	private void OnEnable()
	{
		if (onEnable != null)
		{
			onEnable(new EventData(base.gameObject, this));
		}
	}

	private void OnDisable()
	{
		if (onDisable != null)
		{
			onDisable(new EventData(base.gameObject, this));
		}
	}

	private void OnDestroy()
	{
		if (onDestroy != null)
		{
			onDestroy(new EventData(base.gameObject, this));
		}
	}

	private void OnTransformChildrenChanged()
	{
		if (onTransformChildrenChanged != null)
		{
			onTransformChildrenChanged(new EventData(base.gameObject, this));
		}
	}

	private void OnTransformParentChanged()
	{
		if (onTransformParentChanged != null)
		{
			onTransformParentChanged(new EventData(base.gameObject, this));
		}
	}

	private void OnAnimatorIK(int layerIndex)
	{
		if (onAnimatorIK != null)
		{
			onAnimatorIK(new EventData<int>(layerIndex, base.gameObject, this));
		}
	}

	private void OnBecameInvisible()
	{
		if (onBecameInvisible != null)
		{
			onBecameInvisible(new EventData(base.gameObject, this));
		}
	}

	private void OnBecameVisible()
	{
		if (onBecameVisible != null)
		{
			onBecameVisible(new EventData(base.gameObject, this));
		}
	}

	private void OnControllerColliderHit(ControllerColliderHit hit)
	{
		if (onControllerColliderHit != null)
		{
			onControllerColliderHit(new EventData<ControllerColliderHit>(hit, base.gameObject, this));
		}
	}

	private void OnParticleCollision(GameObject other)
	{
		if (onParticleCollision != null)
		{
			onParticleCollision(new EventData<GameObject>(other, base.gameObject, this));
		}
	}

	private void OnCollisionEnter(Collision collisionInfo)
	{
		if (onCollisionEnter != null)
		{
			onCollisionEnter(new EventData<Collision>(collisionInfo, base.gameObject, this));
		}
	}

	private void OnCollisionExit(Collision collisionInfo)
	{
		if (onCollisionExit != null)
		{
			onCollisionExit(new EventData<Collision>(collisionInfo, base.gameObject, this));
		}
	}

	private void OnCollisionStay(Collision collisionInfo)
	{
		if (onCollisionStay != null)
		{
			onCollisionStay(new EventData<Collision>(collisionInfo, base.gameObject, this));
		}
	}

	private void OnCollisionEnter2D(Collision2D collisionInfo)
	{
		if (onCollisionEnter2D != null)
		{
			onCollisionEnter2D(new EventData<Collision2D>(collisionInfo, base.gameObject, this));
		}
	}

	private void OnCollisionExit2D(Collision2D collisionInfo)
	{
		if (onCollisionExit2D != null)
		{
			onCollisionExit2D(new EventData<Collision2D>(collisionInfo, base.gameObject, this));
		}
	}

	private void OnCollisionStay2D(Collision2D collisionInfo)
	{
		if (onCollisionStay2D != null)
		{
			onCollisionStay2D(new EventData<Collision2D>(collisionInfo, base.gameObject, this));
		}
	}

	private void OnTriggerEnter(Collider other)
	{
		if (onTriggerEnter != null)
		{
			onTriggerEnter(new EventData<Collider>(other, base.gameObject, this));
		}
	}

	private void OnTriggerExit(Collider other)
	{
		if (onTriggerExit != null)
		{
			onTriggerExit(new EventData<Collider>(other, base.gameObject, this));
		}
	}

	private void OnTriggerStay(Collider other)
	{
		if (onTriggerStay != null)
		{
			onTriggerStay(new EventData<Collider>(other, base.gameObject, this));
		}
	}

	private void OnTriggerEnter2D(Collider2D other)
	{
		if (onTriggerEnter2D != null)
		{
			onTriggerEnter2D(new EventData<Collider2D>(other, base.gameObject, this));
		}
	}

	private void OnTriggerExit2D(Collider2D other)
	{
		if (onTriggerExit2D != null)
		{
			onTriggerExit2D(new EventData<Collider2D>(other, base.gameObject, this));
		}
	}

	private void OnTriggerStay2D(Collider2D other)
	{
		if (onTriggerStay2D != null)
		{
			onTriggerStay2D(new EventData<Collider2D>(other, base.gameObject, this));
		}
	}

	private void OnRenderImage(RenderTexture source, RenderTexture destination)
	{
		if (onRenderImage != null)
		{
			onRenderImage(source, destination);
		}
	}

	private void OnDrawGizmos()
	{
		if (onDrawGizmos != null)
		{
			onDrawGizmos(new EventData(base.gameObject, this));
		}
	}

	public void InvokeCustomEvent(string name, object value, object sender)
	{
		if (onCustomEvent != null)
		{
			onCustomEvent(name, new EventData(value, base.gameObject, sender));
		}
	}

	public void InvokeCustomEvent<T>(string name, T value, object sender)
	{
		if (onCustomEvent != null)
		{
			onCustomEvent(name, new EventData<T>(value, base.gameObject, sender));
		}
	}
}
