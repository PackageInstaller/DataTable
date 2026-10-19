using System;
using System.Collections.Generic;
using System.Reflection;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.DefinedEvents.Support.ReflectedInfo")]
internal class ReflectedInfo
{
	private static Dictionary<Type, ReflectedInfo> Reflections = new Dictionary<Type, ReflectedInfo>();

	private Type type;

	public Dictionary<string, FieldInfo> reflectedFields { get; } = new Dictionary<string, FieldInfo>();

	public Dictionary<string, PropertyInfo> reflectedProperties { get; } = new Dictionary<string, PropertyInfo>();

	public static ReflectedInfo For<T>()
	{
		return For(typeof(T));
	}

	public static ReflectedInfo For(Type T)
	{
		lock (Reflections)
		{
			if (Reflections.ContainsKey(T))
			{
				return Reflections[T];
			}
			ReflectedInfo reflectedInfo = new ReflectedInfo(T);
			Reflections.Add(T, reflectedInfo);
			return reflectedInfo;
		}
	}

	public ReflectedInfo(Type t)
	{
		type = t;
		DefineInputsForEventType();
	}

	private void DefineInputsForEventType()
	{
		reflectedFields.Clear();
		reflectedProperties.Clear();
		FieldInfo[] fields = type.GetFields();
		foreach (FieldInfo fieldInfo in fields)
		{
			if (fieldInfo.IsPublic)
			{
				reflectedFields.Add(fieldInfo.Name, fieldInfo);
			}
		}
		PropertyInfo[] properties = type.GetProperties();
		foreach (PropertyInfo propertyInfo in properties)
		{
			MethodInfo setMethod = propertyInfo.GetSetMethod();
			if (setMethod != null && setMethod.IsPublic)
			{
				reflectedProperties.Add(propertyInfo.Name, propertyInfo);
			}
		}
	}
}
