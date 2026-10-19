using System;
using System.Collections.Generic;
using System.Reflection;
using System.Text.RegularExpressions;
using UnityEngine;

namespace Proxima;

public static class ProximaCommandHelpers
{
	private static Type[] UnityStatics = new Type[8]
	{
		typeof(Application),
		typeof(Time),
		typeof(Screen),
		typeof(QualitySettings),
		typeof(Input),
		typeof(Physics),
		typeof(AudioSettings),
		typeof(Physics2D)
	};

	public static List<GameObject> FindGameObjects(string name)
	{
		GameObject[] array = UnityEngine.Object.FindObjectsOfType<GameObject>(includeInactive: true);
		List<GameObject> list = new List<GameObject>();
		if (name.StartsWith("[") && name.EndsWith("]") && int.TryParse(name.Substring(1, name.Length - 2), out var result))
		{
			GameObject[] array2 = array;
			foreach (GameObject gameObject in array2)
			{
				if (gameObject.GetInstanceID() == result)
				{
					list.Add(gameObject);
					break;
				}
			}
		}
		else
		{
			Regex regex = new Regex("^" + Regex.Escape(name).Replace("\\*", ".*?") + "$", RegexOptions.IgnoreCase);
			GameObject[] array2 = array;
			foreach (GameObject gameObject2 in array2)
			{
				if (gameObject2.scene.isLoaded && regex.IsMatch(gameObject2.name))
				{
					list.Add(gameObject2);
				}
			}
		}
		list.Sort((GameObject a, GameObject b) => a.name.ToLower().CompareTo(b.name.ToLower()));
		return list;
	}

	internal static List<PropertyOrField> FindProperties(string pattern)
	{
		List<PropertyOrField> list = new List<PropertyOrField>();
		int num = pattern.IndexOf('.');
		if (num == -1)
		{
			return list;
		}
		string text = pattern.Substring(0, num);
		string pattern2 = pattern.Substring(num + 1);
		Type[] unityStatics = UnityStatics;
		foreach (Type type in unityStatics)
		{
			if (type.Name.Equals(text, StringComparison.OrdinalIgnoreCase))
			{
				AddStaticProperty(list, type, pattern2);
				return list;
			}
		}
		foreach (GameObject item in FindGameObjects(text))
		{
			list.AddRange(FindGameObjectProperties(item, pattern2));
		}
		return list;
	}

	public static Type FindFirstComponentType(string className)
	{
		Type type = Type.GetType(className, throwOnError: false, ignoreCase: true);
		if (type != null)
		{
			if (!type.IsSubclassOf(typeof(Component)))
			{
				return null;
			}
			return type;
		}
		Assembly[] assemblies = AppDomain.CurrentDomain.GetAssemblies();
		for (int i = 0; i < assemblies.Length; i++)
		{
			Type[] types = assemblies[i].GetTypes();
			foreach (Type type2 in types)
			{
				if (type2.IsSubclassOf(typeof(Component)) && type2.Name.Equals(className, StringComparison.OrdinalIgnoreCase))
				{
					return type2;
				}
			}
		}
		return null;
	}

	private static bool ComponentMatchesPattern(Component component, string pattern)
	{
		Type type = component.GetType();
		while (type != typeof(Component))
		{
			if (type.Name.Equals(pattern, StringComparison.OrdinalIgnoreCase))
			{
				return true;
			}
			type = type.BaseType;
		}
		return false;
	}

	private static List<PropertyOrField> FindGameObjectProperties(GameObject obj, string pattern)
	{
		string descriptor = obj.name + " [" + obj.GetInstanceID() + "]";
		List<PropertyOrField> list = new List<PropertyOrField>();
		if (TryAddObjectProperty(list, descriptor, obj, pattern))
		{
			return list;
		}
		int num = pattern.IndexOf('.');
		if (num >= 0)
		{
			string pattern2 = pattern.Substring(0, num);
			string pattern3 = pattern.Substring(num + 1);
			Component[] components = obj.GetComponents<Component>();
			foreach (Component component in components)
			{
				if (ComponentMatchesPattern(component, pattern2))
				{
					TryAddObjectProperty(list, descriptor, component, pattern3);
				}
			}
		}
		else
		{
			Component[] components = obj.GetComponents<Component>();
			foreach (Component component2 in components)
			{
				if (ComponentMatchesPattern(component2, pattern))
				{
					list.Add(new PropertyOrField(descriptor, component2));
				}
			}
		}
		return list;
	}

	private static bool TryAddObjectProperty(List<PropertyOrField> list, string descriptor, object obj, string pattern)
	{
		new List<PropertyOrField>();
		PropertyInfo property = obj.GetType().GetProperty(pattern, BindingFlags.IgnoreCase | BindingFlags.Instance | BindingFlags.Public);
		FieldInfo field = obj.GetType().GetField(pattern, BindingFlags.IgnoreCase | BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
		if (property != null || field != null)
		{
			list.Add(new PropertyOrField(descriptor, obj, property, field));
			return true;
		}
		return false;
	}

	private static void AddStaticProperty(List<PropertyOrField> list, Type staticType, string pattern)
	{
		new List<PropertyOrField>();
		PropertyInfo property = staticType.GetProperty(pattern, BindingFlags.IgnoreCase | BindingFlags.Static | BindingFlags.Public);
		FieldInfo field = staticType.GetField(pattern, BindingFlags.IgnoreCase | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
		if (property != null || field != null)
		{
			string text = ((property != null) ? property.Name : field.Name);
			list.Add(new PropertyOrField(staticType.Name + "." + text, null, property, field));
		}
	}
}
