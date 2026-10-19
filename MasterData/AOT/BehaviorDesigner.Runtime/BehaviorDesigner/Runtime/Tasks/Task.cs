using System;
using System.Collections;
using UnityEngine;

namespace BehaviorDesigner.Runtime.Tasks;

public abstract class Task
{
	protected GameObject gameObject;

	protected Transform transform;

	[SerializeField]
	private NodeData nodeData;

	[SerializeField]
	private Behavior owner;

	[SerializeField]
	private int id = -1;

	[SerializeField]
	private string friendlyName = "";

	[SerializeField]
	private bool instant = true;

	private int referenceID = -1;

	private bool disabled;

	public GameObject GameObject
	{
		set
		{
			gameObject = value;
		}
	}

	public Transform Transform
	{
		set
		{
			transform = value;
		}
	}

	public NodeData NodeData
	{
		get
		{
			return nodeData;
		}
		set
		{
			nodeData = value;
		}
	}

	public Behavior Owner
	{
		get
		{
			return owner;
		}
		set
		{
			owner = value;
		}
	}

	public int ID
	{
		get
		{
			return id;
		}
		set
		{
			id = value;
		}
	}

	public virtual string FriendlyName
	{
		get
		{
			return friendlyName;
		}
		set
		{
			friendlyName = value;
		}
	}

	public bool IsInstant
	{
		get
		{
			return instant;
		}
		set
		{
			instant = value;
		}
	}

	public int ReferenceID
	{
		get
		{
			return referenceID;
		}
		set
		{
			referenceID = value;
		}
	}

	public bool Disabled
	{
		get
		{
			return disabled;
		}
		set
		{
			disabled = value;
		}
	}

	public virtual void OnAwake()
	{
	}

	public virtual void OnStart()
	{
	}

	public virtual TaskStatus OnUpdate()
	{
		return TaskStatus.Success;
	}

	public virtual void OnLateUpdate()
	{
	}

	public virtual void OnFixedUpdate()
	{
	}

	public virtual void OnEnd()
	{
	}

	public virtual void OnPause(bool paused)
	{
	}

	public virtual void OnConditionalAbort()
	{
	}

	public virtual float GetPriority()
	{
		return 0f;
	}

	public virtual float GetUtility()
	{
		return 0f;
	}

	public virtual void OnBehaviorRestart()
	{
	}

	public virtual void OnBehaviorComplete()
	{
	}

	public virtual void OnReset()
	{
	}

	public virtual void OnDrawGizmos()
	{
	}

	public virtual string OnDrawNodeText()
	{
		return string.Empty;
	}

	protected void StartCoroutine(string methodName)
	{
		Owner.StartTaskCoroutine(this, methodName);
	}

	protected Coroutine StartCoroutine(IEnumerator routine)
	{
		return Owner.StartCoroutine(routine);
	}

	protected Coroutine StartCoroutine(string methodName, object value)
	{
		return Owner.StartTaskCoroutine(this, methodName, value);
	}

	protected void StopCoroutine(string methodName)
	{
		Owner.StopTaskCoroutine(methodName);
	}

	protected void StopCoroutine(IEnumerator routine)
	{
		Owner.StopCoroutine(routine);
	}

	protected void StopAllCoroutines()
	{
		Owner.StopAllTaskCoroutines();
	}

	public virtual void OnCollisionEnter(Collision collision)
	{
	}

	public virtual void OnCollisionExit(Collision collision)
	{
	}

	public virtual void OnTriggerEnter(Collider other)
	{
	}

	public virtual void OnTriggerExit(Collider other)
	{
	}

	public virtual void OnCollisionEnter2D(Collision2D collision)
	{
	}

	public virtual void OnCollisionExit2D(Collision2D collision)
	{
	}

	public virtual void OnTriggerEnter2D(Collider2D other)
	{
	}

	public virtual void OnTriggerExit2D(Collider2D other)
	{
	}

	public virtual void OnControllerColliderHit(ControllerColliderHit hit)
	{
	}

	public virtual void OnAnimatorIK()
	{
	}

	protected T GetComponent<T>() where T : Component
	{
		return gameObject.GetComponent<T>();
	}

	protected Component GetComponent(Type type)
	{
		return gameObject.GetComponent(type);
	}

	protected void TryGetComponent<T>(out T component) where T : Component
	{
		gameObject.TryGetComponent<T>(out component);
	}

	protected void TryGetComponent(Type type, out Component component)
	{
		gameObject.TryGetComponent(type, out component);
	}

	protected GameObject GetDefaultGameObject(GameObject go)
	{
		if (go == null)
		{
			return gameObject;
		}
		return go;
	}
}
