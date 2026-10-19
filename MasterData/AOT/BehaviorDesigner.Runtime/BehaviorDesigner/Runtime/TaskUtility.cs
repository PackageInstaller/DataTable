using System;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.CompilerServices;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace BehaviorDesigner.Runtime;

public class TaskUtility
{
	public static char[] TrimCharacters = new char[1] { '/' };

	private static Dictionary<string, Type> typeLookup = new Dictionary<string, Type>();

	private static List<Assembly> loadedAssemblies = null;

	private static Dictionary<Type, FieldInfo[]> allFieldsLookup = new Dictionary<Type, FieldInfo[]>();

	private static Dictionary<Type, FieldInfo[]> serializableFieldsLookup = new Dictionary<Type, FieldInfo[]>();

	private static Dictionary<Type, FieldInfo[]> publicFieldsLookup = new Dictionary<Type, FieldInfo[]>();

	private static Dictionary<FieldInfo, Dictionary<Type, bool>> hasFieldLookup = new Dictionary<FieldInfo, Dictionary<Type, bool>>();

	public static object CreateInstance(Type t)
	{
		if (t.IsGenericType && t.GetGenericTypeDefinition() == typeof(Nullable<>))
		{
			t = Nullable.GetUnderlyingType(t);
		}
		return Activator.CreateInstance(t, nonPublic: true);
	}

	public static FieldInfo[] GetAllFields(Type t)
	{
		FieldInfo[] value = null;
		if (!allFieldsLookup.TryGetValue(t, out value))
		{
			List<FieldInfo> fieldList = ObjectPool.Get<List<FieldInfo>>();
			fieldList.Clear();
			BindingFlags flags = BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic;
			GetFields(t, ref fieldList, (int)flags);
			value = fieldList.ToArray();
			ObjectPool.Return(fieldList);
			allFieldsLookup.Add(t, value);
		}
		return value;
	}

	public static FieldInfo[] GetPublicFields(Type t)
	{
		FieldInfo[] value = null;
		if (!publicFieldsLookup.TryGetValue(t, out value))
		{
			List<FieldInfo> fieldList = ObjectPool.Get<List<FieldInfo>>();
			fieldList.Clear();
			BindingFlags flags = BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public;
			GetFields(t, ref fieldList, (int)flags);
			value = fieldList.ToArray();
			ObjectPool.Return(fieldList);
			publicFieldsLookup.Add(t, value);
		}
		return value;
	}

	public static FieldInfo[] GetSerializableFields(Type t)
	{
		FieldInfo[] value = null;
		if (!serializableFieldsLookup.TryGetValue(t, out value))
		{
			List<FieldInfo> list = ObjectPool.Get<List<FieldInfo>>();
			list.Clear();
			BindingFlags flags = BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic;
			GetSerializableFields(t, list, (int)flags);
			value = list.ToArray();
			ObjectPool.Return(list);
			serializableFieldsLookup.Add(t, value);
		}
		return value;
	}

	private static void GetSerializableFields(Type t, IList<FieldInfo> fieldList, int flags)
	{
		if (t == null || t.Equals(typeof(ParentTask)) || t.Equals(typeof(Task)) || t.Equals(typeof(SharedVariable)))
		{
			return;
		}
		FieldInfo[] fields = t.GetFields((BindingFlags)flags);
		for (int i = 0; i < fields.Length; i++)
		{
			if (fields[i].IsPublic || HasAttribute(fields[i], typeof(SerializeField)))
			{
				fieldList.Add(fields[i]);
			}
		}
		GetSerializableFields(t.BaseType, fieldList, flags);
	}

	private static void GetFields(Type t, ref List<FieldInfo> fieldList, int flags)
	{
		if (!(t == null) && !t.Equals(typeof(ParentTask)) && !t.Equals(typeof(Task)) && !t.Equals(typeof(SharedVariable)))
		{
			FieldInfo[] fields = t.GetFields((BindingFlags)flags);
			for (int i = 0; i < fields.Length; i++)
			{
				fieldList.Add(fields[i]);
			}
			GetFields(t.BaseType, ref fieldList, flags);
		}
	}

	public static Type GetTypeWithinAssembly(string typeName)
	{
		if (string.IsNullOrEmpty(typeName))
		{
			return null;
		}
		if (typeLookup.TryGetValue(typeName, out var value))
		{
			return value;
		}
		value = Type.GetType(typeName);
		if (value == null)
		{
			if (loadedAssemblies == null)
			{
				loadedAssemblies = new List<Assembly>();
				Assembly[] assemblies = AppDomain.CurrentDomain.GetAssemblies();
				for (int i = 0; i < assemblies.Length; i++)
				{
					loadedAssemblies.Add(assemblies[i]);
				}
			}
			for (int j = 0; j < loadedAssemblies.Count; j++)
			{
				value = loadedAssemblies[j].GetType(typeName);
				if (value != null)
				{
					break;
				}
			}
		}
		if (value != null)
		{
			typeLookup.Add(typeName, value);
		}
		else if (typeName.Contains("BehaviorDesigner.Runtime.Tasks.Basic"))
		{
			return GetTypeWithinAssembly(typeName.Replace("BehaviorDesigner.Runtime.Tasks.Basic", "BehaviorDesigner.Runtime.Tasks.Unity"));
		}
		return value;
	}

	public static bool CompareType(Type t, string typeName)
	{
		Type typeWithinAssembly = GetTypeWithinAssembly(typeName);
		if (typeWithinAssembly == null)
		{
			return false;
		}
		return t.Equals(typeWithinAssembly);
	}

	[MethodImpl((MethodImplOptions)32)]
	public static bool HasAttribute(FieldInfo field, Type attribute)
	{
		if (field == null)
		{
			return false;
		}
		if (!hasFieldLookup.TryGetValue(field, out var value))
		{
			value = new Dictionary<Type, bool>();
			hasFieldLookup.Add(field, value);
		}
		if (!value.TryGetValue(attribute, out var value2))
		{
			value2 = field.GetCustomAttributes(attribute, inherit: false).Length != 0;
			value.Add(attribute, value2);
		}
		return value2;
	}
}
