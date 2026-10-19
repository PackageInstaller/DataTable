using System;
using UnityEngine;

namespace Fundamental;

[AutoSingleton(true)]
public class MonoSingleton<T> : MonoBehaviour where T : Component
{
	private static T s_instance;

	private static bool s_destroyed;

	public static T instance => GetInstance();

	public static T GetInstance()
	{
		if (s_instance == null && !s_destroyed)
		{
			Type typeFromHandle = typeof(T);
			s_instance = (T)UnityEngine.Object.FindObjectOfType(typeFromHandle);
			if (s_instance == null)
			{
				object[] customAttributes = typeFromHandle.GetCustomAttributes(typeof(AutoSingletonAttribute), inherit: true);
				if (customAttributes.Length != 0 && !((AutoSingletonAttribute)customAttributes[0]).bAutoCreate)
				{
					return null;
				}
				GameObject gameObject = new GameObject(typeof(T).Name);
				s_instance = gameObject.AddComponent<T>();
				GameObject gameObject2 = GameObject.Find("BootObj");
				if (gameObject2 != null)
				{
					gameObject.transform.SetParent(gameObject2.transform);
				}
			}
		}
		return s_instance;
	}

	public static void DestroyInstance()
	{
		if (s_instance != null)
		{
			UnityEngine.Object.Destroy(s_instance.gameObject);
		}
		s_destroyed = true;
		s_instance = null;
	}

	public static void ClearDestroy()
	{
		DestroyInstance();
		s_destroyed = false;
	}

	public static bool IsNull()
	{
		return s_instance == null;
	}

	protected void Awake()
	{
		if (s_instance != null && s_instance.gameObject != gameObject)
		{
			if (Application.isPlaying)
			{
				UnityEngine.Object.Destroy(gameObject);
			}
			else
			{
				UnityEngine.Object.DestroyImmediate(gameObject);
			}
			return;
		}
		if (s_instance == null)
		{
			s_instance = GetComponent<T>();
		}
		UnityEngine.Object.DontDestroyOnLoad(gameObject);
		Init();
	}

	protected void OnDestroy()
	{
		s_destroyed = true;
		UnInit();
		if (s_instance != null && s_instance.gameObject == gameObject)
		{
			s_instance = null;
		}
	}

	public static bool HasInstance()
	{
		return s_instance != null;
	}

	protected virtual void Init()
	{
	}

	protected virtual void UnInit()
	{
	}
}
