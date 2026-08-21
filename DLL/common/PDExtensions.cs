using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System.Text;
using Google.Protobuf;
using Google.Protobuf.Collections;

public static class PDExtensions
{
	public static List<T> dictKeyTolist<T, TT>(this Dictionary<T, TT> dict)
	{
		List<T> list = new List<T>();
		list.AddRange(dict.Keys);
		return list;
	}

	public static float dist(int ax, int ay, int bx, int by)
	{
		float num = ax - bx;
		float num2 = ay - by;
		return (float)Math.Round(Math.Sqrt(num * num + num2 * num2), 5);
	}

	public static float dist(float ax, float ay, float bx, float by)
	{
		float num = ax - bx;
		float num2 = ay - by;
		return (float)Math.Round(Math.Sqrt(num * num + num2 * num2), 5);
	}

	public static float clamp(this float v, float from, float to)
	{
		v = Math.Min(Math.Max(from, to), v);
		v = Math.Max(Math.Min(from, to), v);
		return v;
	}

	public static float clamp01(this float v)
	{
		return v.clamp(0f, 1f);
	}

	public static List<TT> dictValTolist<T, TT>(this Dictionary<T, TT> dict)
	{
		List<TT> list = new List<TT>();
		list.AddRange(dict.Values);
		return list;
	}

	public static bool any<T>(this List<T> list, Func<T, bool> compair)
	{
		foreach (T item in list)
		{
			if (compair(item))
			{
				return true;
			}
		}
		return false;
	}

	public static List<T> select<T>(this List<T> list, Func<T, bool> compair)
	{
		List<T> list2 = new List<T>();
		foreach (T item in list)
		{
			if (compair(item))
			{
				list2.Add(item);
			}
		}
		return list2;
	}

	public static List<TT> selectElementAttr<T, TT>(this List<T> list, Func<T, TT> compari)
	{
		List<TT> list2 = new List<TT>();
		foreach (T item in list)
		{
			TT val = compari(item);
			if (val != null)
			{
				list2.Add(val);
			}
		}
		return list2;
	}

	public static List<TT> selectElementAttr<T, TT>(this RepeatedField<T> list, Func<T, TT> compari)
	{
		List<TT> list2 = new List<TT>();
		foreach (T item in list)
		{
			TT val = compari(item);
			if (val != null)
			{
				list2.Add(val);
			}
		}
		return list2;
	}

	public static int parseNumber(this string str)
	{
		StringBuilder stringBuilder = new StringBuilder("");
		for (int i = 0; i < str.Length; i++)
		{
			if (str[i] >= '0' && str[i] <= '9')
			{
				stringBuilder.Append(str[i]);
			}
		}
		int result = 0;
		int.TryParse(stringBuilder.ToString(), out result);
		return result;
	}

	public static T max<T>(this List<T> list) where T : struct, IComparable<T>
	{
		T val = list[0];
		foreach (T item in list)
		{
			if (item.CompareTo(val) == 1)
			{
				val = item;
			}
		}
		return val;
	}

	public static T min<T>(this List<T> list) where T : struct, IComparable<T>
	{
		T val = list[0];
		foreach (T item in list)
		{
			if (item.CompareTo(val) == -1)
			{
				val = item;
			}
		}
		return val;
	}

	public static List<T> toList<T>(this Array arry)
	{
		List<T> list = new List<T>();
		foreach (object item in arry)
		{
			list.Add((T)item);
		}
		return list;
	}

	public static T limit<T>(this T v, T min, T max) where T : IComparable
	{
		if (v.CompareTo(min) == -1)
		{
			return min;
		}
		if (v.CompareTo(max) == 1)
		{
			return max;
		}
		return v;
	}

	public static bool inRange(this int v, int min, int max)
	{
		if (v > min)
		{
			return v < max;
		}
		return false;
	}

	public static bool inRange(this float v, float min, float max)
	{
		if (v > min)
		{
			return v < max;
		}
		return false;
	}

	public static bool valEqual(this IMessage obj, IMessage to)
	{
		return obj.ToString().Equals(to.ToString());
	}

	public static object deepClone(this object ori, object ins = null)
	{
		if (ori == null)
		{
			return null;
		}
		Type type = ori.GetType();
		if (type.IsValueType || type == typeof(string))
		{
			return ori;
		}
		if (ins == null)
		{
			if (type.IsArray)
			{
				Array array = (ori as Array).Clone() as Array;
				for (int i = 0; i < array.Length; i++)
				{
					array.SetValue(array.GetValue(i).deepClone(), i);
				}
				return array;
			}
			if (ori is IDictionary dictionary)
			{
				IDictionary dictionary2 = (IDictionary)type.getInstance();
				{
					foreach (object key in dictionary.Keys)
					{
						dictionary2.Add(key, dictionary[key]);
					}
					return dictionary2;
				}
			}
			ins = type.getInstance();
		}
		while (type != null)
		{
			FieldInfo[] fields = type.GetFields(BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.GetProperty);
			foreach (FieldInfo fieldInfo in fields)
			{
				fieldInfo.SetValue(ins, fieldInfo.GetValue(ori).deepClone());
			}
			FieldInfo[] fields2 = type.GetFields(BindingFlags.Instance | BindingFlags.Public | BindingFlags.GetProperty);
			foreach (FieldInfo fieldInfo2 in fields2)
			{
				fieldInfo2.SetValue(ins, fieldInfo2.GetValue(ori).deepClone());
			}
			type = type.BaseType;
		}
		return ins;
	}

	public static SortedList<string, FieldInfo> allFields(this Type tp)
	{
		SortedList<string, FieldInfo> sortedList = new SortedList<string, FieldInfo>();
		FieldInfo[] fields = tp.GetFields(BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.GetProperty);
		foreach (FieldInfo fieldInfo in fields)
		{
			if (!sortedList.ContainsKey(fieldInfo.Name))
			{
				sortedList.Add(fieldInfo.Name, fieldInfo);
			}
		}
		FieldInfo[] fields2 = tp.GetFields(BindingFlags.Instance | BindingFlags.Public | BindingFlags.GetProperty);
		foreach (FieldInfo fieldInfo2 in fields2)
		{
			if (!sortedList.ContainsKey(fieldInfo2.Name))
			{
				sortedList.Add(fieldInfo2.Name, fieldInfo2);
			}
		}
		return sortedList;
	}

	public static bool isValOrStringType(this Type tp)
	{
		if (!tp.IsValueType)
		{
			return tp == typeof(string);
		}
		return true;
	}

	public static object getInstance(this Type tp)
	{
		if (tp == typeof(string))
		{
			return "";
		}
		return Activator.CreateInstance(tp);
	}

	public static FieldInfo getField(this Type tp, string fn)
	{
		FieldInfo[] fields = tp.GetFields(BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.GetProperty);
		foreach (FieldInfo fieldInfo in fields)
		{
			if (fieldInfo.Name == fn)
			{
				return fieldInfo;
			}
		}
		FieldInfo[] fields2 = tp.GetFields(BindingFlags.Instance | BindingFlags.Public | BindingFlags.GetProperty);
		foreach (FieldInfo fieldInfo2 in fields2)
		{
			if (fieldInfo2.Name == fn)
			{
				return fieldInfo2;
			}
		}
		return null;
	}

	public static List<FieldInfo> getFields(this Type tp)
	{
		List<FieldInfo> list = new List<FieldInfo>();
		FieldInfo[] fields = tp.GetFields(BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.GetProperty);
		foreach (FieldInfo item in fields)
		{
			if (list.Contains(item))
			{
				list.Add(item);
			}
		}
		FieldInfo[] fields2 = tp.GetFields(BindingFlags.Instance | BindingFlags.Public | BindingFlags.GetProperty);
		foreach (FieldInfo item2 in fields2)
		{
			if (list.Contains(item2))
			{
				list.Add(item2);
			}
		}
		return list;
	}

	public static string toString<T>(this T[] arry)
	{
		string text = "[";
		for (int i = 0; i < arry.Length; i++)
		{
			text += arry[i].ToString();
			if (i != arry.Length - 1)
			{
				text += ",";
			}
		}
		return text + "]";
	}

	public static string toString<T>(this List<T> list)
	{
		string text = "[";
		for (int i = 0; i < list.Count; i++)
		{
			text += list[i].ToString();
			if (i != list.Count - 1)
			{
				text += ",";
			}
		}
		return text + "]";
	}

	public static double toTimeStamp(this DateTime dt)
	{
		return (dt - new DateTime(1970, 1, 1, 0, 0, 0, 0).ToLocalTime()).TotalSeconds;
	}

	public static T getValueByIndex<T>(this List<T> lst, int index)
	{
		index = Math.Min(lst.Count - 1, index);
		index = Math.Max(0, index);
		return lst[index];
	}

	public static T getValueByIndex<T>(this T[] lst, int index)
	{
		index = Math.Min(lst.Length - 1, index);
		index = Math.Max(0, index);
		return lst[index];
	}

	public static bool contains<T>(this T[] lst, T o)
	{
		foreach (T val in lst)
		{
			if (o != null && o.Equals(val))
			{
				return true;
			}
		}
		return false;
	}

	public static bool equal(this float a, float b)
	{
		return Math.Abs(a - b) <= 1E-05f;
	}

	public static int spaceLength(this string str)
	{
		int num = 0;
		foreach (char c in str)
		{
			num += Math.Min(2, Encoding.UTF8.GetBytes(c.ToString()).Length);
		}
		return num;
	}

	public static void walk<T>(this List<T> lst, Action<T> callback)
	{
		for (int i = 0; i < lst.Count; i++)
		{
			callback(lst[i]);
		}
	}

	public static void walk<T>(this RepeatedField<T> lst, Action<T> callback)
	{
		for (int i = 0; i < lst.Count; i++)
		{
			callback(lst.get_Item(i));
		}
	}

	public static void walk<T>(this T[] lst, Action<T> callback)
	{
		for (int i = 0; i < lst.Length; i++)
		{
			callback(lst[i]);
		}
	}
}
