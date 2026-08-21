using System;
using System.Reflection;

namespace LuaInterface;

[NoToLua]
public static class LuaMisc
{
	public static string GetArrayRank(Type t)
	{
		int arrayRank = t.GetArrayRank();
		if (arrayRank == 1)
		{
			return "[]";
		}
		using (CString.Block())
		{
			CString cString = CString.Alloc(64);
			cString.Append('[');
			for (int i = 1; i < arrayRank; i++)
			{
				cString.Append(',');
			}
			cString.Append(']');
			return cString.ToString();
		}
	}

	public static string GetTypeName(Type t)
	{
		if (t.IsArray)
		{
			return GetTypeName(t.GetElementType()) + GetArrayRank(t);
		}
		if (t.IsByRef)
		{
			t = t.GetElementType();
			return GetTypeName(t);
		}
		if (t.IsGenericType)
		{
			return GetGenericName(t);
		}
		if (t == typeof(void))
		{
			return "void";
		}
		return GetPrimitiveStr(t).Replace('+', '.');
	}

	public static string[] GetGenericName(Type[] types, int offset, int count)
	{
		string[] array = new string[count];
		for (int i = 0; i < count; i++)
		{
			int num = i + offset;
			if (types[num].IsGenericType)
			{
				array[i] = GetGenericName(types[num]);
			}
			else
			{
				array[i] = GetTypeName(types[num]);
			}
		}
		return array;
	}

	private static string CombineTypeStr(string space, string name)
	{
		if (string.IsNullOrEmpty(space))
		{
			return name;
		}
		return space + "." + name;
	}

	private static string GetGenericName(Type t)
	{
		Type[] genericArguments = t.GetGenericArguments();
		string text = t.FullName ?? t.Name;
		int num = genericArguments.Length;
		int num2 = text.IndexOf("[");
		if (num2 > 0)
		{
			text = text.Substring(0, num2);
		}
		string text2 = null;
		string space = null;
		int num3 = 0;
		for (num2 = text.IndexOf("+"); num2 > 0; num2 = text.IndexOf("+"))
		{
			text2 = text.Substring(0, num2);
			text = text.Substring(num2 + 1);
			num2 = text2.IndexOf('`');
			if (num2 > 0)
			{
				num = text2[num2 + 1] - 48;
				text2 = text2.Substring(0, num2);
				text2 = text2 + "<" + string.Join(",", GetGenericName(genericArguments, num3, num)) + ">";
				num3 += num;
			}
			space = CombineTypeStr(space, text2);
		}
		text2 = text;
		if (num3 < genericArguments.Length)
		{
			num2 = text2.IndexOf('`');
			num = text2[num2 + 1] - 48;
			text2 = text2.Substring(0, num2);
			text2 = text2 + "<" + string.Join(",", GetGenericName(genericArguments, num3, num)) + ">";
		}
		return CombineTypeStr(space, text2);
	}

	public static Delegate GetEventHandler(object obj, Type t, string eventName)
	{
		return (Delegate)t.GetField(eventName, BindingFlags.Instance | BindingFlags.Static | BindingFlags.NonPublic | BindingFlags.GetField).GetValue(obj);
	}

	public static string GetPrimitiveStr(Type t)
	{
		if (t == typeof(float))
		{
			return "float";
		}
		if (t == typeof(string))
		{
			return "string";
		}
		if (t == typeof(int))
		{
			return "int";
		}
		if (t == typeof(double))
		{
			return "double";
		}
		if (t == typeof(bool))
		{
			return "bool";
		}
		if (t == typeof(uint))
		{
			return "uint";
		}
		if (t == typeof(sbyte))
		{
			return "sbyte";
		}
		if (t == typeof(byte))
		{
			return "byte";
		}
		if (t == typeof(short))
		{
			return "short";
		}
		if (t == typeof(ushort))
		{
			return "ushort";
		}
		if (t == typeof(char))
		{
			return "char";
		}
		if (t == typeof(long))
		{
			return "long";
		}
		if (t == typeof(ulong))
		{
			return "ulong";
		}
		if (t == typeof(decimal))
		{
			return "decimal";
		}
		if (t == typeof(object))
		{
			return "object";
		}
		return t.ToString();
	}

	public static double ToDouble(object obj)
	{
		Type type = obj.GetType();
		if (type == typeof(double) || type == typeof(float))
		{
			return Convert.ToDouble(obj);
		}
		if (type == typeof(int))
		{
			return Convert.ToInt32(obj);
		}
		if (type == typeof(uint))
		{
			return Convert.ToUInt32(obj);
		}
		if (type == typeof(long))
		{
			return Convert.ToInt64(obj);
		}
		if (type == typeof(ulong))
		{
			return Convert.ToUInt64(obj);
		}
		if (type == typeof(byte))
		{
			return (int)Convert.ToByte(obj);
		}
		if (type == typeof(sbyte))
		{
			return Convert.ToSByte(obj);
		}
		if (type == typeof(char))
		{
			return (int)Convert.ToChar(obj);
		}
		if (type == typeof(short))
		{
			return Convert.ToInt16(obj);
		}
		if (type == typeof(ushort))
		{
			return (int)Convert.ToUInt16(obj);
		}
		return 0.0;
	}

	public static Type GetExportBaseType(Type t)
	{
		Type baseType = t.BaseType;
		if (baseType == typeof(ValueType))
		{
			return null;
		}
		if (t.IsAbstract && t.IsSealed)
		{
			if (!(baseType == typeof(object)))
			{
				return baseType;
			}
			return null;
		}
		return baseType;
	}
}
