using System;
using UnityEngine;

namespace ParadoxNotion.Services;

public class MonoManager : MonoBehaviour
{
	private static MonoManager _current;

	public static bool isQuiting { get; private set; }

	public static MonoManager current
	{
		get
		{
			if (_current == null && !isQuiting)
			{
				_current = UnityEngine.Object.FindObjectOfType<MonoManager>();
				if (_current == null)
				{
					_current = new GameObject("_MonoManager").AddComponent<MonoManager>();
				}
			}
			return _current;
		}
	}

	public event Action onUpdate;

	public event Action onLateUpdate;

	public event Action onFixedUpdate;

	public event Action onGUI;

	public event Action onApplicationQuit;

	public event Action<bool> onApplicationPause;

	public static void Create()
	{
		_current = current;
	}

	public static void Shutdown()
	{
		if (!(_current == null))
		{
			UnityEngine.Object.DestroyImmediate(_current.gameObject);
			_current = null;
		}
	}

	protected void OnApplicationQuit()
	{
		isQuiting = true;
		if (onApplicationQuit != null)
		{
			onApplicationQuit();
		}
	}

	protected void OnApplicationPause(bool isPause)
	{
		if (onApplicationPause != null)
		{
			onApplicationPause(isPause);
		}
	}

	protected void Awake()
	{
		if (_current != null && _current != this)
		{
			UnityEngine.Object.DestroyImmediate(base.gameObject);
			return;
		}
		UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
		_current = this;
	}

	protected void Update()
	{
		if (onUpdate != null)
		{
			onUpdate();
		}
	}

	protected void LateUpdate()
	{
		if (onLateUpdate != null)
		{
			onLateUpdate();
		}
	}

	protected void FixedUpdate()
	{
		if (onFixedUpdate != null)
		{
			onFixedUpdate();
		}
	}
}
