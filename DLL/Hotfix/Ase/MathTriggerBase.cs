#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;
using UnityEngine;

namespace Ase;

public abstract class MathTriggerBase : MonoBehaviour, IMathTrigger
{
	[SerializeField]
	private Vector3 _center = Vector3.zero;

	[SerializeField]
	private bool _dynamic;

	private bool _isInitialized;

	private bool isRegister;

	public GameObject Owner
	{
		get
		{
			if (this == null)
			{
				return null;
			}
			return base.gameObject;
		}
	}

	public bool Dynamic
	{
		get
		{
			return _dynamic;
		}
		set
		{
			_dynamic = value;
		}
	}

	public Vector3 center
	{
		get
		{
			return _center;
		}
		set
		{
			_center = value;
		}
	}

	public Vector3 Position
	{
		get
		{
			return base.transform.position;
		}
		set
		{
			base.transform.position = value;
		}
	}

	public Quaternion Rotation
	{
		get
		{
			return base.transform.rotation;
		}
		set
		{
			base.transform.rotation = value;
		}
	}

	public Vector3 Scale
	{
		get
		{
			return base.transform.localScale;
		}
		set
		{
			base.transform.localScale = value;
		}
	}

	public bool Vaild
	{
		get
		{
			if (this != null && base.gameObject.activeInHierarchy)
			{
				return !Scale.Equals(Vector3.zero);
			}
			return false;
		}
	}

	public abstract bool Contains(Vector3 point);

	public abstract bool Intersects(Bounds bounds);

	public abstract Bounds Bounds();

	protected virtual void OnEnable()
	{
		RegisterToSystem();
	}

	protected virtual void OnDisable()
	{
		UnregisterFromSystem();
	}

	public void RegisterToSystem()
	{
		if (!_isInitialized)
		{
			_isInitialized = true;
			OnInit();
		}
		if (Singleton<MathTriggerSystem>.Instance != null)
		{
			Singleton<MathTriggerSystem>.Instance.RegisterTrigger(this);
			isRegister = true;
		}
		else
		{
			Log.Error("MathTriggerSystem is not initialized. Please ensure it is created before registering triggers.");
		}
	}

	public void UnregisterFromSystem()
	{
		Singleton<MathTriggerSystem>.Instance?.UnregisterTrigger(this);
		isRegister = false;
	}

	protected virtual void OnDrawGizmosSelected()
	{
		Gizmos.color = new Color(0f, 1f, 0f, 0.3f);
		Gizmos.matrix = base.transform.localToWorldMatrix;
	}

	protected abstract void OnInit();
}
