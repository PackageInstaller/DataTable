using System;
using System.Collections.Generic;
using System.Reflection;

namespace UnityEngine.InputSystem.Utilities;

public struct NamedValue : IEquatable<NamedValue>
{
	public const string Separator = ",";

	public string name { get; set; }

	public PrimitiveValue value { get; set; }

	public TypeCode type => value.type;

	public NamedValue ConvertTo(TypeCode type)
	{
		return new NamedValue
		{
			name = name,
			value = value.ConvertTo(type)
		};
	}

	public static NamedValue From<TValue>(string name, TValue value) where TValue : struct
	{
		return new NamedValue
		{
			name = name,
			value = PrimitiveValue.From(value)
		};
	}

	public override string ToString()
	{
		return $"{name}={value}";
	}

	public bool Equals(NamedValue other)
	{
		if (string.Equals(name, other.name, StringComparison.InvariantCultureIgnoreCase))
		{
			return value == other.value;
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		if (obj is NamedValue other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return (((name != null) ? name.GetHashCode() : 0) * 397) ^ value.GetHashCode();
	}

	public static bool operator ==(NamedValue left, NamedValue right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(NamedValue left, NamedValue right)
	{
		return !left.Equals(right);
	}

	public static NamedValue[] ParseMultiple(string parameterString)
	{
		if (parameterString == null)
		{
			throw new ArgumentNullException("parameterString");
		}
		parameterString = parameterString.Trim();
		if (string.IsNullOrEmpty(parameterString))
		{
			return null;
		}
		int num = parameterString.CountOccurrences(","[0]) + 1;
		NamedValue[] array = new NamedValue[num];
		int index = 0;
		for (int i = 0; i < num; i++)
		{
			NamedValue namedValue = ParseParameter(parameterString, ref index);
			array[i] = namedValue;
		}
		return array;
	}

	public static NamedValue Parse(string str)
	{
		int index = 0;
		return ParseParameter(str, ref index);
	}

	private static NamedValue ParseParameter(string parameterString, ref int index)
	{
		NamedValue result = default(NamedValue);
		int length = parameterString.Length;
		while (index < length && char.IsWhiteSpace(parameterString[index]))
		{
			index++;
		}
		int num = index;
		while (index < length)
		{
			char c = parameterString[index];
			if (c == '=' || c == ","[0] || char.IsWhiteSpace(c))
			{
				break;
			}
			index++;
		}
		result.name = parameterString.Substring(num, index - num);
		while (index < length && char.IsWhiteSpace(parameterString[index]))
		{
			index++;
		}
		if (index == length || parameterString[index] != '=')
		{
			result.value = true;
		}
		else
		{
			index++;
			while (index < length && char.IsWhiteSpace(parameterString[index]))
			{
				index++;
			}
			int num2 = index;
			while (index < length && parameterString[index] != ","[0] && !char.IsWhiteSpace(parameterString[index]))
			{
				index++;
			}
			string text = parameterString.Substring(num2, index - num2);
			result.value = PrimitiveValue.FromString(text);
		}
		if (index < length && parameterString[index] == ","[0])
		{
			index++;
		}
		return result;
	}

	public void ApplyToObject(object instance)
	{
		if (instance == null)
		{
			throw new ArgumentNullException("instance");
		}
		Type type = instance.GetType();
		FieldInfo field = type.GetField(name, BindingFlags.IgnoreCase | BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
		if (field == null)
		{
			throw new ArgumentException("Cannot find public field '" + name + "' in '" + type.Name + "' (while trying to apply parameter)", "instance");
		}
		TypeCode typeCode = Type.GetTypeCode(field.FieldType);
		field.SetValue(instance, value.ConvertTo(typeCode).ToObject());
	}

	public static void ApplyAllToObject<TParameterList>(object instance, TParameterList parameters) where TParameterList : IEnumerable<NamedValue>
	{
		foreach (NamedValue item in parameters)
		{
			item.ApplyToObject(instance);
		}
	}
}
