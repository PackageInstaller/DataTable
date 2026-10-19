using System;
using UnityEngine;

namespace Unity.VisualScripting;

public static class ComponentHolderProtocol
{
	public static bool IsComponentHolderType(Type type)
	{
		Ensure.That("type").IsNotNull(type);
		if (!typeof(GameObject).IsAssignableFrom(type))
		{
			return typeof(Component).IsAssignableFrom(type);
		}
		return true;
	}

	public static bool IsComponentHolder(this UnityEngine.Object uo)
	{
		if (!(uo is GameObject))
		{
			return uo is Component;
		}
		return true;
	}

	public static GameObject GameObject(this UnityEngine.Object uo)
	{
		if (uo is GameObject)
		{
			return (GameObject)uo;
		}
		if (uo is Component)
		{
			return ((Component)uo).gameObject;
		}
		return null;
	}

	public static T AddComponent<T>(this UnityEngine.Object uo) where T : Component
	{
		if (uo is GameObject)
		{
			return ((GameObject)uo).AddComponent<T>();
		}
		if (uo is Component)
		{
			return ((Component)uo).gameObject.AddComponent<T>();
		}
		throw new NotSupportedException();
	}

	public static T GetOrAddComponent<T>(this UnityEngine.Object uo) where T : Component
	{
		return uo.GetComponent<T>() ?? uo.AddComponent<T>();
	}

	public static T GetComponent<T>(this UnityEngine.Object uo)
	{
		if (uo is GameObject)
		{
			return ((GameObject)uo).GetComponent<T>();
		}
		if (uo is Component)
		{
			return ((Component)uo).GetComponent<T>();
		}
		throw new NotSupportedException();
	}

	public static T GetComponentInChildren<T>(this UnityEngine.Object uo)
	{
		if (uo is GameObject)
		{
			return ((GameObject)uo).GetComponentInChildren<T>();
		}
		if (uo is Component)
		{
			return ((Component)uo).GetComponentInChildren<T>();
		}
		throw new NotSupportedException();
	}

	public static T GetComponentInParent<T>(this UnityEngine.Object uo)
	{
		if (uo is GameObject)
		{
			return ((GameObject)uo).GetComponentInParent<T>();
		}
		if (uo is Component)
		{
			return ((Component)uo).GetComponentInParent<T>();
		}
		throw new NotSupportedException();
	}

	public static T[] GetComponents<T>(this UnityEngine.Object uo)
	{
		if (uo is GameObject)
		{
			return ((GameObject)uo).GetComponents<T>();
		}
		if (uo is Component)
		{
			return ((Component)uo).GetComponents<T>();
		}
		throw new NotSupportedException();
	}

	public static T[] GetComponentsInChildren<T>(this UnityEngine.Object uo)
	{
		if (uo is GameObject)
		{
			return ((GameObject)uo).GetComponentsInChildren<T>();
		}
		if (uo is Component)
		{
			return ((Component)uo).GetComponentsInChildren<T>();
		}
		throw new NotSupportedException();
	}

	public static T[] GetComponentsInParent<T>(this UnityEngine.Object uo)
	{
		if (uo is GameObject)
		{
			return ((GameObject)uo).GetComponentsInParent<T>();
		}
		if (uo is Component)
		{
			return ((Component)uo).GetComponentsInParent<T>();
		}
		throw new NotSupportedException();
	}

	public static Component GetComponent(this UnityEngine.Object uo, Type type)
	{
		if (uo is GameObject)
		{
			return ((GameObject)uo).GetComponent(type);
		}
		if (uo is Component)
		{
			return ((Component)uo).GetComponent(type);
		}
		throw new NotSupportedException();
	}

	public static Component GetComponentInChildren(this UnityEngine.Object uo, Type type)
	{
		if (uo is GameObject)
		{
			return ((GameObject)uo).GetComponentInChildren(type);
		}
		if (uo is Component)
		{
			return ((Component)uo).GetComponentInChildren(type);
		}
		throw new NotSupportedException();
	}

	public static Component GetComponentInParent(this UnityEngine.Object uo, Type type)
	{
		if (uo is GameObject)
		{
			return ((GameObject)uo).GetComponentInParent(type);
		}
		if (uo is Component)
		{
			return ((Component)uo).GetComponentInParent(type);
		}
		throw new NotSupportedException();
	}

	public static Component[] GetComponents(this UnityEngine.Object uo, Type type)
	{
		if (uo is GameObject)
		{
			return ((GameObject)uo).GetComponents(type);
		}
		if (uo is Component)
		{
			return ((Component)uo).GetComponents(type);
		}
		throw new NotSupportedException();
	}

	public static Component[] GetComponentsInChildren(this UnityEngine.Object uo, Type type)
	{
		if (uo is GameObject)
		{
			return ((GameObject)uo).GetComponentsInChildren(type);
		}
		if (uo is Component)
		{
			return ((Component)uo).GetComponentsInChildren(type);
		}
		throw new NotSupportedException();
	}

	public static Component[] GetComponentsInParent(this UnityEngine.Object uo, Type type)
	{
		if (uo is GameObject)
		{
			return ((GameObject)uo).GetComponentsInParent(type);
		}
		if (uo is Component)
		{
			return ((Component)uo).GetComponentsInParent(type);
		}
		throw new NotSupportedException();
	}
}
