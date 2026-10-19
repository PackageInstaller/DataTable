using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Globalization;

namespace System.Reflection;

public struct CustomAttributeTypedArgument
{
	public Type ArgumentType { get; }

	public object Value { get; }

	public CustomAttributeTypedArgument(object value)
	{
		if (value == null)
		{
			throw new ArgumentNullException("value");
		}
		Value = CanonicalizeValue(value);
		ArgumentType = value.GetType();
	}

	public CustomAttributeTypedArgument(Type argumentType, object value)
	{
		if (argumentType == null)
		{
			throw new ArgumentNullException("argumentType");
		}
		Value = ((value == null) ? null : CanonicalizeValue(value));
		ArgumentType = argumentType;
		if (value is Array array)
		{
			Type elementType = array.GetType().GetElementType();
			CustomAttributeTypedArgument[] array2 = new CustomAttributeTypedArgument[array.GetLength(0)];
			for (int i = 0; i < array2.Length; i++)
			{
				object value2 = array.GetValue(i);
				Type argumentType2 = ((elementType == typeof(object) && value2 != null) ? value2.GetType() : elementType);
				array2[i] = new CustomAttributeTypedArgument(argumentType2, value2);
			}
			Value = new ReadOnlyCollection<CustomAttributeTypedArgument>(array2);
		}
	}

	public override bool Equals(object obj)
	{
		return obj == (object)this;
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}

	public static bool operator ==(CustomAttributeTypedArgument left, CustomAttributeTypedArgument right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(CustomAttributeTypedArgument left, CustomAttributeTypedArgument right)
	{
		return !left.Equals(right);
	}

	public override string ToString()
	{
		return ToString(typed: false);
	}

	internal string ToString(bool typed)
	{
		if (ArgumentType == null)
		{
			return base.ToString();
		}
		try
		{
			if (ArgumentType.IsEnum)
			{
				return string.Format(CultureInfo.CurrentCulture, typed ? "{0}" : "({1}){0}", Value, ArgumentType.FullNameOrDefault);
			}
			if (Value == null)
			{
				return string.Format(CultureInfo.CurrentCulture, typed ? "null" : "({0})null", ArgumentType.NameOrDefault);
			}
			if (ArgumentType == typeof(string))
			{
				return string.Format(CultureInfo.CurrentCulture, "\"{0}\"", Value);
			}
			if (ArgumentType == typeof(char))
			{
				return string.Format(CultureInfo.CurrentCulture, "'{0}'", Value);
			}
			if (ArgumentType == typeof(Type))
			{
				return string.Format(CultureInfo.CurrentCulture, "typeof({0})", ((Type)Value).FullNameOrDefault);
			}
			if (ArgumentType.IsArray)
			{
				string text = null;
				IList<CustomAttributeTypedArgument> list = Value as IList<CustomAttributeTypedArgument>;
				Type elementType = ArgumentType.GetElementType();
				text = string.Format(CultureInfo.CurrentCulture, "new {0}[{1}] {{ ", elementType.IsEnum ? elementType.FullNameOrDefault : elementType.NameOrDefault, list.Count);
				for (int i = 0; i < list.Count; i++)
				{
					text += string.Format(CultureInfo.CurrentCulture, (i == 0) ? "{0}" : ", {0}", list[i].ToString(elementType != typeof(object)));
				}
				return text += " }";
			}
			return string.Format(CultureInfo.CurrentCulture, typed ? "{0}" : "({1}){0}", Value, ArgumentType.NameOrDefault);
		}
		catch (MissingMetadataException)
		{
			return base.ToString();
		}
	}

	private static object CanonicalizeValue(object value)
	{
		if (value.GetType().IsEnum)
		{
			return ((Enum)value).GetValue();
		}
		return value;
	}
}
