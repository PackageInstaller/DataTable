using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ParadoxNotion.Services;

public class MessageRouter : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler, IPointerDownHandler, IPointerUpHandler, IPointerClickHandler, IDragHandler, IScrollHandler, IUpdateSelectedHandler, ISelectHandler, IDeselectHandler, IMoveHandler, ISubmitHandler
{
	public class MessageData
	{
		public GameObject receiver { get; private set; }

		public object sender { get; private set; }

		public MessageData(GameObject receiver, object sender)
		{
			this.receiver = receiver;
			this.sender = sender;
		}
	}

	public class MessageData<T> : MessageData
	{
		public T value { get; private set; }

		public MessageData(T value, GameObject receiver, object sender)
			: base(receiver, sender)
		{
			this.value = value;
		}
	}

	private Dictionary<string, List<object>> listeners = new Dictionary<string, List<object>>(StringComparer.OrdinalIgnoreCase);

	private object _animator;

	private Animator animator
	{
		get
		{
			if (_animator == null)
			{
				_animator = GetComponent<Animator>();
				if (_animator == null)
				{
					_animator = new object();
				}
			}
			return _animator as Animator;
		}
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		Dispatch("OnPointerEnter", eventData);
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		Dispatch("OnPointerExit", eventData);
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		Dispatch("OnPointerDown", eventData);
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		Dispatch("OnPointerUp", eventData);
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		Dispatch("OnPointerClick", eventData);
	}

	public void OnDrag(PointerEventData eventData)
	{
		Dispatch("OnDrag", eventData);
	}

	public void OnDrop(BaseEventData eventData)
	{
		Dispatch("OnDrop", eventData);
	}

	public void OnScroll(PointerEventData eventData)
	{
		Dispatch("OnScroll", eventData);
	}

	public void OnUpdateSelected(BaseEventData eventData)
	{
		Dispatch("OnUpdateSelected", eventData);
	}

	public void OnSelect(BaseEventData eventData)
	{
		Dispatch("OnSelect", eventData);
	}

	public void OnDeselect(BaseEventData eventData)
	{
		Dispatch("OnDeselect", eventData);
	}

	public void OnMove(AxisEventData eventData)
	{
		Dispatch("OnMove", eventData);
	}

	public void OnSubmit(BaseEventData eventData)
	{
		Dispatch("OnSubmit", eventData);
	}

	private void OnAnimatorIK(int layerIndex)
	{
		Dispatch("OnAnimatorIK", layerIndex);
	}

	private void OnAnimatorMove()
	{
		if (!Dispatch("OnAnimatorMove") && animator.applyRootMotion)
		{
			animator.ApplyBuiltinRootMotion();
		}
	}

	private void OnBecameInvisible()
	{
		Dispatch("OnBecameInvisible");
	}

	private void OnBecameVisible()
	{
		Dispatch("OnBecameVisible");
	}

	private void OnCollisionEnter(Collision collisionInfo)
	{
		Dispatch("OnCollisionEnter", collisionInfo);
	}

	private void OnCollisionExit(Collision collisionInfo)
	{
		Dispatch("OnCollisionExit", collisionInfo);
	}

	private void OnCollisionStay(Collision collisionInfo)
	{
		Dispatch("OnCollisionStay", collisionInfo);
	}

	private void OnCollisionEnter2D(Collision2D collisionInfo)
	{
		Dispatch("OnCollisionEnter2D", collisionInfo);
	}

	private void OnCollisionExit2D(Collision2D collisionInfo)
	{
		Dispatch("OnCollisionExit2D", collisionInfo);
	}

	private void OnCollisionStay2D(Collision2D collisionInfo)
	{
		Dispatch("OnCollisionStay2D", collisionInfo);
	}

	private void OnTriggerEnter(Collider other)
	{
		Dispatch("OnTriggerEnter", other);
	}

	private void OnTriggerExit(Collider other)
	{
		Dispatch("OnTriggerExit", other);
	}

	private void OnTriggerStay(Collider other)
	{
		Dispatch("OnTriggerStay", other);
	}

	private void OnTriggerEnter2D(Collider2D other)
	{
		Dispatch("OnTriggerEnter2D", other);
	}

	private void OnTriggerExit2D(Collider2D other)
	{
		Dispatch("OnTriggerExit2D", other);
	}

	private void OnTriggerStay2D(Collider2D other)
	{
		Dispatch("OnTriggerStay2D", other);
	}

	private void OnMouseDown()
	{
		Dispatch("OnMouseDown");
	}

	private void OnMouseDrag()
	{
		Dispatch("OnMouseDrag");
	}

	private void OnMouseEnter()
	{
		Dispatch("OnMouseEnter");
	}

	private void OnMouseExit()
	{
		Dispatch("OnMouseExit");
	}

	private void OnMouseOver()
	{
		Dispatch("OnMouseOver");
	}

	private void OnMouseUp()
	{
		Dispatch("OnMouseUp");
	}

	private void OnControllerColliderHit(ControllerColliderHit hit)
	{
		Dispatch("OnControllerColliderHit", hit);
	}

	private void OnParticleCollision(GameObject other)
	{
		Dispatch("OnParticleCollision", other);
	}

	private void OnEnable()
	{
		Dispatch("OnEnable");
	}

	private void OnDisable()
	{
		Dispatch("OnDisable");
	}

	private void OnDestroy()
	{
		Dispatch("OnDestroy");
	}

	private void OnTransformChildrenChanged()
	{
		Dispatch("OnTransformChildrenChanged");
	}

	private void OnTransformParentChanged()
	{
		Dispatch("OnTransformParentChanged");
	}

	public void Register(object target, params string[] messages)
	{
		if (target == null)
		{
			return;
		}
		for (int i = 0; i < messages.Length; i++)
		{
			if (target.GetType().GetMethod(messages[i], BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic) == null)
			{
				Debug.LogError($"Type '{target.GetType().FriendlyName()}' does not implement a method named '{messages[i]}', for the registered event to use.");
				continue;
			}
			List<object> value = null;
			if (!listeners.TryGetValue(messages[i], out value))
			{
				value = new List<object>();
				listeners[messages[i]] = value;
			}
			if (!value.Contains(target))
			{
				value.Add(target);
			}
		}
	}

	public void RegisterCallback(string message, Action callback)
	{
		Internal_RegisterCallback(message, callback);
	}

	public void RegisterCallback<T>(string message, Action<T> callback)
	{
		Internal_RegisterCallback(message, callback);
	}

	private void Internal_RegisterCallback(string message, Delegate callback)
	{
		List<object> value = null;
		if (!listeners.TryGetValue(message, out value))
		{
			value = new List<object>();
			listeners[message] = value;
		}
		if (!value.Contains(callback))
		{
			value.Add(callback);
		}
	}

	public void UnRegister(object target)
	{
		if (target == null)
		{
			return;
		}
		foreach (string key in listeners.Keys)
		{
			object[] array = listeners[key].ToArray();
			foreach (object obj in array)
			{
				if (obj == target)
				{
					listeners[key].Remove(target);
				}
				else if (obj is Delegate && (obj as Delegate).Target == target)
				{
					listeners[key].Remove(obj);
				}
			}
		}
	}

	public void UnRegister(object target, params string[] messages)
	{
		if (target == null)
		{
			return;
		}
		foreach (string key in messages)
		{
			if (!listeners.ContainsKey(key))
			{
				continue;
			}
			object[] array = listeners[key].ToArray();
			foreach (object obj in array)
			{
				if (obj == target)
				{
					listeners[key].Remove(target);
				}
				else if (obj is Delegate && (obj as Delegate).Target == target)
				{
					listeners[key].Remove(obj);
				}
			}
		}
	}

	public bool Dispatch(string message, object sender = null)
	{
		return Dispatch<object>(message, null, sender);
	}

	public bool Dispatch<T>(string message, T arg, object sender = null)
	{
		if (sender == null)
		{
			sender = this;
		}
		if (!listeners.TryGetValue(message, out var value))
		{
			return false;
		}
		for (int i = 0; i < value.Count; i++)
		{
			object obj = value[i];
			if (obj == null)
			{
				continue;
			}
			MethodInfo methodInfo = null;
			methodInfo = ((!(obj is Delegate)) ? obj.GetType().GetMethod(message, BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic) : (obj as Delegate).RTGetDelegateMethodInfo());
			if (methodInfo == null)
			{
				Debug.LogError($"Can't resolve method {obj.GetType().Name}.{message}.");
				continue;
			}
			ParameterInfo[] parameters = methodInfo.GetParameters();
			if (parameters.Length > 1)
			{
				Debug.LogError($"Parameters on method {obj.GetType().Name}.{message}, are more than 1.");
				continue;
			}
			object[] array = null;
			if (parameters.Length == 1)
			{
				object obj2 = ((!typeof(MessageData).RTIsAssignableFrom(parameters[0].ParameterType)) ? ((object)arg) : new MessageData<T>(arg, base.gameObject, sender));
				array = new object[1] { obj2 };
			}
			if (obj is Delegate)
			{
				(obj as Delegate).DynamicInvoke(array);
			}
			else if (methodInfo.ReturnType == typeof(IEnumerator))
			{
				MonoManager.current.StartCoroutine((IEnumerator)methodInfo.Invoke(obj, array));
			}
			else
			{
				methodInfo.Invoke(obj, array);
			}
		}
		return true;
	}
}
