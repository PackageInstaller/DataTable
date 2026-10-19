using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting;

public static class Singleton<T> where T : MonoBehaviour, ISingleton
{
	private static readonly SingletonAttribute attribute;

	private static readonly object _lock;

	private static readonly HashSet<T> awoken;

	private static T _instance;

	private static bool persistent => attribute.Persistent;

	private static bool automatic => attribute.Automatic;

	private static string name => attribute.Name;

	private static HideFlags hideFlags => attribute.HideFlags;

	public static bool instantiated
	{
		get
		{
			lock (_lock)
			{
				if (Application.isPlaying)
				{
					return _instance != null;
				}
				return FindInstances().Length == 1;
			}
		}
	}

	public static T instance
	{
		get
		{
			lock (_lock)
			{
				if (Application.isPlaying)
				{
					if (_instance == null)
					{
						Instantiate();
					}
					return _instance;
				}
				return Instantiate();
			}
		}
	}

	static Singleton()
	{
		_lock = new object();
		awoken = new HashSet<T>();
		attribute = typeof(T).GetAttribute<SingletonAttribute>();
		if (attribute == null)
		{
			throw new InvalidImplementationException($"Missing singleton attribute for '{typeof(T)}'.");
		}
	}

	private static T[] FindObjectsOfType()
	{
		return Object.FindObjectsOfType<T>();
	}

	private static T[] FindInstances()
	{
		return FindObjectsOfType();
	}

	public static T Instantiate()
	{
		lock (_lock)
		{
			T[] array = FindInstances();
			if (array.Length == 1)
			{
				_instance = array[0];
			}
			else if (array.Length == 0)
			{
				if (!automatic)
				{
					throw new UnityException($"Missing '{typeof(T)}' singleton in the scene.");
				}
				GameObject gameObject = new GameObject(name ?? typeof(T).Name);
				gameObject.hideFlags = hideFlags;
				T val = gameObject.AddComponent<T>();
				val.hideFlags = hideFlags;
				Awake(val);
				if (persistent && Application.isPlaying)
				{
					Object.DontDestroyOnLoad(gameObject);
				}
			}
			else if (array.Length > 1)
			{
				throw new UnityException($"More than one '{typeof(T)}' singleton in the scene.");
			}
			return _instance;
		}
	}

	public static void Awake(T instance)
	{
		Ensure.That("instance").IsNotNull(instance);
		if (!awoken.Contains(instance))
		{
			if (_instance != null)
			{
				throw new UnityException($"More than one '{typeof(T)}' singleton in the scene.");
			}
			_instance = instance;
			awoken.Add(instance);
		}
	}

	public static void OnDestroy(T instance)
	{
		Ensure.That("instance").IsNotNull(instance);
		if (_instance == instance)
		{
			_instance = null;
			return;
		}
		throw new UnityException($"Trying to destroy invalid instance of '{typeof(T)}' singleton.");
	}
}
