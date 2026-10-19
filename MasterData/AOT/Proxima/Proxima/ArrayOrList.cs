using System;
using System.Collections;
using UnityEngine;

namespace Proxima;

internal class ArrayOrList
{
	public static bool IsArrayOrList(Type arrayOrList)
	{
		if (!IsArray(arrayOrList))
		{
			return IsList(arrayOrList);
		}
		return true;
	}

	public static bool IsList(Type arrayOrList)
	{
		if (typeof(IList).IsAssignableFrom(arrayOrList))
		{
			return arrayOrList.IsGenericType;
		}
		return false;
	}

	public static bool IsArray(Type arrayOrList)
	{
		return arrayOrList.IsArray;
	}

	public static bool IsArrayOrList(object arrayOrList)
	{
		if (!IsArray(arrayOrList))
		{
			return IsList(arrayOrList);
		}
		return true;
	}

	public static bool IsList(object arrayOrList)
	{
		return IsList(arrayOrList.GetType());
	}

	public static bool IsArray(object arrayOrList)
	{
		return IsArray(arrayOrList.GetType());
	}

	public static int Count(object arrayOrList)
	{
		if (IsArray(arrayOrList))
		{
			return ((Array)arrayOrList).Length;
		}
		if (IsList(arrayOrList))
		{
			return ((IList)arrayOrList).Count;
		}
		throw new ArgumentException("Type is not an array or list");
	}

	public static object Get(object arrayOrList, int index)
	{
		if (IsArray(arrayOrList))
		{
			return ((Array)arrayOrList).GetValue(index);
		}
		if (IsList(arrayOrList))
		{
			return ((IList)arrayOrList)[index];
		}
		throw new ArgumentException("Type is not an array or list");
	}

	public static void Set(object arrayOrList, int index, object value)
	{
		if (IsArray(arrayOrList))
		{
			((Array)arrayOrList).SetValue(value, index);
			return;
		}
		if (IsList(arrayOrList))
		{
			((IList)arrayOrList)[index] = value;
			return;
		}
		throw new ArgumentException("Type is not an array or list");
	}

	public static Type GetElementType(Type arrayOrList)
	{
		if (IsArray(arrayOrList))
		{
			return arrayOrList.GetElementType();
		}
		if (IsList(arrayOrList))
		{
			return arrayOrList.GetGenericArguments()[0];
		}
		throw new ArgumentException("Type is not an array or list");
	}

	private static object CreateDefault(Type type)
	{
		if (type.IsPrimitive)
		{
			return Activator.CreateInstance(type);
		}
		if (type == typeof(string))
		{
			return "";
		}
		if (type.GetConstructor(Type.EmptyTypes) != null)
		{
			return Activator.CreateInstance(type);
		}
		return null;
	}

	private static object Duplicate(object value)
	{
		if (value == null)
		{
			return null;
		}
		Type type = value.GetType();
		if (type.IsValueType || type == typeof(string))
		{
			return value;
		}
		if (IsArray(type))
		{
			Array array = (Array)value;
			Array array2 = Array.CreateInstance(type.GetElementType(), array.Length);
			for (int i = 0; i < array.Length; i++)
			{
				array2.SetValue(Duplicate(array.GetValue(i)), i);
			}
		}
		if (IsList(type))
		{
			IList list = (IList)value;
			IList list2 = (IList)Activator.CreateInstance(type);
			{
				foreach (object item in list)
				{
					list2.Add(Duplicate(item));
				}
				return list2;
			}
		}
		if (type.IsSubclassOf(typeof(UnityEngine.Object)))
		{
			return value;
		}
		return null;
	}

	public static object Resize(object arrayOrList, int size)
	{
		int num = Count(arrayOrList);
		if (num == size)
		{
			return arrayOrList;
		}
		Type type = arrayOrList.GetType();
		Type elementType = GetElementType(type);
		if (IsArray(type))
		{
			Array array = Array.CreateInstance(elementType, size);
			Array.Copy((Array)arrayOrList, array, Math.Min(num, size));
			for (int i = num; i < size; i++)
			{
				array.SetValue(CreateDefault(elementType), i);
			}
			arrayOrList = array;
		}
		else
		{
			if (!IsList(type))
			{
				throw new ArgumentException("Type is not an array or list");
			}
			IList list = (IList)arrayOrList;
			while (list.Count > size)
			{
				list.RemoveAt(list.Count - 1);
			}
			while (list.Count < size)
			{
				list.Add(CreateDefault(elementType));
			}
			arrayOrList = list;
		}
		if (size > num && num > 0)
		{
			object value = Get(arrayOrList, num - 1);
			for (int j = num; j < size; j++)
			{
				Set(arrayOrList, j, Duplicate(value));
			}
		}
		return arrayOrList;
	}

	public static void MoveElement(object arrayOrList, int from, int to)
	{
		object value = Get(arrayOrList, from);
		if (from < to)
		{
			for (int i = from; i < to; i++)
			{
				Set(arrayOrList, i, Get(arrayOrList, i + 1));
			}
		}
		else
		{
			for (int num = from; num > to; num--)
			{
				Set(arrayOrList, num, Get(arrayOrList, num - 1));
			}
		}
		Set(arrayOrList, to, value);
	}

	public static object RemoveElement(object arrayOrList, int index)
	{
		int num = Count(arrayOrList);
		for (int i = index; i < num - 1; i++)
		{
			Set(arrayOrList, i, Get(arrayOrList, i + 1));
		}
		return Resize(arrayOrList, num - 1);
	}
}
