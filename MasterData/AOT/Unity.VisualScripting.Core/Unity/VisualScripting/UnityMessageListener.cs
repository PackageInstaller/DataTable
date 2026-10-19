using System;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
[Obsolete("UnityMessageListener is deprecated and has been replaced by separate message listeners for each event, eg. UnityOnCollisionEnterMessageListener or UnityOnButtonClickMessageListener.")]
public sealed class UnityMessageListener : MessageListener, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler, IPointerDownHandler, IPointerUpHandler, IPointerClickHandler, IBeginDragHandler, IDragHandler, IEndDragHandler, IDropHandler, IScrollHandler, ISelectHandler, IDeselectHandler, ISubmitHandler, ICancelHandler, IMoveHandler
{
	private void Start()
	{
		AddGUIListeners();
	}

	public void AddGUIListeners()
	{
		GetComponent<Button>()?.onClick?.AddListener(() =>
		{
			EventBus.Trigger("OnButtonClick", gameObject);
		});
		GetComponent<Toggle>()?.onValueChanged?.AddListener((bool value) =>
		{
			EventBus.Trigger("OnToggleValueChanged", gameObject, value);
		});
		GetComponent<Slider>()?.onValueChanged?.AddListener((float value) =>
		{
			EventBus.Trigger("OnSliderValueChanged", gameObject, value);
		});
		GetComponent<Scrollbar>()?.onValueChanged?.AddListener((float value) =>
		{
			EventBus.Trigger("OnScrollbarValueChanged", gameObject, value);
		});
		GetComponent<Dropdown>()?.onValueChanged?.AddListener((int value) =>
		{
			EventBus.Trigger("OnDropdownValueChanged", gameObject, value);
		});
		GetComponent<InputField>()?.onValueChanged?.AddListener((string value) =>
		{
			EventBus.Trigger("OnInputFieldValueChanged", gameObject, value);
		});
		GetComponent<InputField>()?.onEndEdit?.AddListener((string value) =>
		{
			EventBus.Trigger("OnInputFieldEndEdit", gameObject, value);
		});
		GetComponent<ScrollRect>()?.onValueChanged?.AddListener((Vector2 value) =>
		{
			EventBus.Trigger("OnScrollRectValueChanged", gameObject, value);
		});
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		EventBus.Trigger("OnPointerEnter", gameObject, eventData);
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		EventBus.Trigger("OnPointerExit", gameObject, eventData);
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		EventBus.Trigger("OnPointerDown", gameObject, eventData);
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		EventBus.Trigger("OnPointerUp", gameObject, eventData);
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		EventBus.Trigger("OnPointerClick", gameObject, eventData);
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		EventBus.Trigger("OnBeginDrag", gameObject, eventData);
	}

	public void OnDrag(PointerEventData eventData)
	{
		EventBus.Trigger("OnDrag", gameObject, eventData);
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		EventBus.Trigger("OnEndDrag", gameObject, eventData);
	}

	public void OnDrop(PointerEventData eventData)
	{
		EventBus.Trigger("OnDrop", gameObject, eventData);
	}

	public void OnScroll(PointerEventData eventData)
	{
		EventBus.Trigger("OnScroll", gameObject, eventData);
	}

	public void OnSelect(BaseEventData eventData)
	{
		EventBus.Trigger("OnSelect", gameObject, eventData);
	}

	public void OnDeselect(BaseEventData eventData)
	{
		EventBus.Trigger("OnDeselect", gameObject, eventData);
	}

	public void OnSubmit(BaseEventData eventData)
	{
		EventBus.Trigger("OnSubmit", gameObject, eventData);
	}

	public void OnCancel(BaseEventData eventData)
	{
		EventBus.Trigger("OnCancel", gameObject, eventData);
	}

	public void OnMove(AxisEventData eventData)
	{
		EventBus.Trigger("OnMove", gameObject, eventData);
	}

	private void OnBecameInvisible()
	{
		EventBus.Trigger("OnBecameInvisible", gameObject);
	}

	private void OnBecameVisible()
	{
		EventBus.Trigger("OnBecameVisible", gameObject);
	}

	private void OnCollisionEnter(Collision collision)
	{
		EventBus.Trigger("OnCollisionEnter", gameObject, collision);
	}

	private void OnCollisionExit(Collision collision)
	{
		EventBus.Trigger("OnCollisionExit", gameObject, collision);
	}

	private void OnCollisionStay(Collision collision)
	{
		EventBus.Trigger("OnCollisionStay", gameObject, collision);
	}

	private void OnCollisionEnter2D(Collision2D collision)
	{
		EventBus.Trigger("OnCollisionEnter2D", gameObject, collision);
	}

	private void OnCollisionExit2D(Collision2D collision)
	{
		EventBus.Trigger("OnCollisionExit2D", gameObject, collision);
	}

	private void OnCollisionStay2D(Collision2D collision)
	{
		EventBus.Trigger("OnCollisionStay2D", gameObject, collision);
	}

	private void OnControllerColliderHit(ControllerColliderHit hit)
	{
		EventBus.Trigger("OnControllerColliderHit", gameObject, hit);
	}

	private void OnJointBreak(float breakForce)
	{
		EventBus.Trigger("OnJointBreak", gameObject, breakForce);
	}

	private void OnJointBreak2D(Joint2D brokenJoint)
	{
		EventBus.Trigger("OnJointBreak2D", gameObject, brokenJoint);
	}

	private void OnMouseDown()
	{
		EventBus.Trigger("OnMouseDown", gameObject);
	}

	private void OnMouseDrag()
	{
		EventBus.Trigger("OnMouseDrag", gameObject);
	}

	private void OnMouseEnter()
	{
		EventBus.Trigger("OnMouseEnter", gameObject);
	}

	private void OnMouseExit()
	{
		EventBus.Trigger("OnMouseExit", gameObject);
	}

	private void OnMouseOver()
	{
		EventBus.Trigger("OnMouseOver", gameObject);
	}

	private void OnMouseUp()
	{
		EventBus.Trigger("OnMouseUp", gameObject);
	}

	private void OnMouseUpAsButton()
	{
		EventBus.Trigger("OnMouseUpAsButton", gameObject);
	}

	private void OnParticleCollision(GameObject other)
	{
		EventBus.Trigger("OnParticleCollision", gameObject, other);
	}

	private void OnTransformChildrenChanged()
	{
		EventBus.Trigger("OnTransformChildrenChanged", gameObject);
	}

	private void OnTransformParentChanged()
	{
		EventBus.Trigger("OnTransformParentChanged", gameObject);
	}

	private void OnTriggerEnter(Collider other)
	{
		EventBus.Trigger("OnTriggerEnter", gameObject, other);
	}

	private void OnTriggerExit(Collider other)
	{
		EventBus.Trigger("OnTriggerExit", gameObject, other);
	}

	private void OnTriggerStay(Collider other)
	{
		EventBus.Trigger("OnTriggerStay", gameObject, other);
	}

	private void OnTriggerEnter2D(Collider2D other)
	{
		EventBus.Trigger("OnTriggerEnter2D", gameObject, other);
	}

	private void OnTriggerExit2D(Collider2D other)
	{
		EventBus.Trigger("OnTriggerExit2D", gameObject, other);
	}

	private void OnTriggerStay2D(Collider2D other)
	{
		EventBus.Trigger("OnTriggerStay2D", gameObject, other);
	}
}
