using System.Collections.Generic;
using UnityEngine;

[AddComponentMenu("CRIWARE/CRI Atom Listener")]
public class CriAtomListener : CriMonoBehaviour
{
	[SerializeField]
	private CriAtomRegion regionOnStart;

	public bool activateListenerOnEnable;

	private static List<CriAtomListener> listenersList = new List<CriAtomListener>();

	private static CriAtomListener exclusiveListener = null;

	private static CriAtomEx3dListener dummyNativeListener;

	private Vector3 lastPosition;

	private CriAtomRegion currentRegion;

	private bool _isActive = true;

	public CriAtomEx3dListener nativeListener { get; protected set; }

	public bool isActive
	{
		get
		{
			return _isActive;
		}
		set
		{
			if (_isActive != value)
			{
				_isActive = value;
				if (value)
				{
					UpdatePosition();
					return;
				}
				nativeListener.SetPosition(float.MaxValue, float.MaxValue, float.MaxValue);
				nativeListener.Update();
			}
		}
	}

	public CriAtomRegion region3d
	{
		get
		{
			return currentRegion;
		}
		set
		{
			if (currentRegion == value)
			{
				return;
			}
			if (currentRegion != null)
			{
				currentRegion.referringListeners.Remove(this);
			}
			CriAtomEx3dRegion criAtomEx3dRegion = ((value == null) ? null : value.region3dHn);
			if (nativeListener != null)
			{
				nativeListener.Set3dRegion(criAtomEx3dRegion);
				nativeListener.Update();
				currentRegion = value;
				if (currentRegion != null)
				{
					currentRegion.referringListeners.Add(this);
				}
			}
			else
			{
				Debug.LogError("[CRIWARE] Internal: CriAtomListener is not initialized correctly.");
				currentRegion = null;
			}
		}
	}

	internal static CriAtomEx3dListener DummyNativeListener => dummyNativeListener;

	public static void CreateDummyNativeListener()
	{
		if (dummyNativeListener == null)
		{
			dummyNativeListener = new CriAtomEx3dListener();
		}
	}

	public static void DestroyDummyNativeListener()
	{
		if (dummyNativeListener != null)
		{
			dummyNativeListener.Dispose();
			dummyNativeListener = null;
		}
	}

	private void Awake()
	{
		if (!listenersList.Contains(this))
		{
			listenersList.Add(this);
		}
		DestroyDummyNativeListener();
		nativeListener = new CriAtomEx3dListener();
		isActive = base.enabled;
	}

	private void Start()
	{
		if (regionOnStart != null)
		{
			region3d = regionOnStart;
		}
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		ActivateListener(activateListenerOnEnable);
	}

	protected override void OnDisable()
	{
		base.OnDisable();
		isActive = false;
		if (exclusiveListener == this)
		{
			exclusiveListener = null;
		}
	}

	private void OnDestroy()
	{
		if (listenersList.Contains(this))
		{
			listenersList.Remove(this);
		}
		region3d = null;
		nativeListener.Dispose();
		nativeListener = null;
	}

	public override void CriInternalUpdate()
	{
	}

	public override void CriInternalLateUpdate()
	{
		if (isActive)
		{
			UpdatePosition();
		}
	}

	private void UpdatePosition()
	{
		Vector3 position = base.transform.position;
		Vector3 vector = (position - lastPosition) / Time.deltaTime;
		Vector3 forward = base.transform.forward;
		Vector3 up = base.transform.up;
		lastPosition = position;
		if (nativeListener != null)
		{
			nativeListener.SetPosition(position.x, position.y, position.z);
			nativeListener.SetVelocity(vector.x, vector.y, vector.z);
			nativeListener.SetOrientation(forward.x, forward.y, forward.z, up.x, up.y, up.z);
			nativeListener.Update();
		}
	}

	public void ActivateListener(bool exclusive = true)
	{
		if (exclusive)
		{
			exclusiveListener = this;
			foreach (CriAtomListener listeners in listenersList)
			{
				if (!(listeners == this))
				{
					listeners.isActive = false;
				}
			}
		}
		isActive = exclusiveListener == null || exclusiveListener == this;
	}
}
