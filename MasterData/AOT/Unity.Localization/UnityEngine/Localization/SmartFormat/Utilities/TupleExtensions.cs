using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

namespace UnityEngine.Localization.SmartFormat.Utilities;

public static class TupleExtensions
{
	private static readonly HashSet<Type> ValueTupleTypes = new HashSet<Type>(new Type[8]
	{
		typeof(ValueTuple<>),
		typeof(ValueTuple<, >),
		typeof(ValueTuple<, , >),
		typeof(ValueTuple<, , , >),
		typeof(ValueTuple<, , , , >),
		typeof(ValueTuple<, , , , , >),
		typeof(ValueTuple<, , , , , , >),
		typeof(ValueTuple<, , , , , , , >)
	});

	public static bool IsValueTuple(this object obj)
	{
		return obj.GetType().IsValueTupleType();
	}

	public static bool IsValueTupleType(this Type type)
	{
		if (type.GetTypeInfo().IsGenericType)
		{
			return ValueTupleTypes.Contains(type.GetGenericTypeDefinition());
		}
		return false;
	}

	public static IEnumerable<object> GetValueTupleItemObjects(this object tuple)
	{
		return from f in tuple.GetType().GetValueTupleItemFields()
			select f.GetValue(tuple);
	}

	public static IEnumerable<Type> GetValueTupleItemTypes(this Type tupleType)
	{
		return from f in tupleType.GetValueTupleItemFields()
			select f.FieldType;
	}

	public static List<FieldInfo> GetValueTupleItemFields(this Type tupleType)
	{
		List<FieldInfo> list = new List<FieldInfo>();
		int num = 1;
		FieldInfo runtimeField;
		while ((runtimeField = tupleType.GetRuntimeField($"Item{num}")) != null)
		{
			num++;
			list.Add(runtimeField);
		}
		return list;
	}

	public static IEnumerable<object> GetValueTupleItemObjectsFlattened(this object tuple)
	{
		foreach (object valueTupleItemObject in tuple.GetValueTupleItemObjects())
		{
			if (valueTupleItemObject.IsValueTuple())
			{
				foreach (object item in valueTupleItemObject.GetValueTupleItemObjectsFlattened())
				{
					yield return item;
				}
			}
			else
			{
				yield return valueTupleItemObject;
			}
		}
	}
}
