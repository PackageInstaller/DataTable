using System;
using System.Text.RegularExpressions;
using UnityEngine;

namespace GameFramework.Runtime;

public class VectorTypeEncoder : ITypeEncoder
{
	private static readonly char[] COMMA_SEPARATOR = new char[1] { ',' };

	private static readonly string PATTERN = "(^\\()|(\\)$)";

	private int priority = 996;

	public int Priority
	{
		get
		{
			return priority;
		}
		set
		{
			priority = value;
		}
	}

	public bool IsSupport(Type type)
	{
		if (type.Equals(typeof(Vector2)) || type.Equals(typeof(Vector3)) || type.Equals(typeof(Vector4)))
		{
			return true;
		}
		return false;
	}

	public object Decode(Type type, string value)
	{
		if (string.IsNullOrEmpty(value))
		{
			return null;
		}
		string text = Regex.Replace(value.Trim(), PATTERN, "");
		if (type.Equals(typeof(Vector2)))
		{
			try
			{
				string[] array = text.Split(COMMA_SEPARATOR, StringSplitOptions.RemoveEmptyEntries);
				if (array.Length == 2)
				{
					return new Vector2(float.Parse(array[0]), float.Parse(array[1]));
				}
			}
			catch (Exception innerException)
			{
				throw new FormatException($"The '{value}' is illegal Vector2.", innerException);
			}
			throw new FormatException($"The '{value}' is illegal Vector2.");
		}
		if (type.Equals(typeof(Vector3)))
		{
			try
			{
				string[] array2 = text.Split(COMMA_SEPARATOR, StringSplitOptions.RemoveEmptyEntries);
				if (array2.Length == 3)
				{
					return new Vector3(float.Parse(array2[0]), float.Parse(array2[1]), float.Parse(array2[2]));
				}
			}
			catch (Exception innerException2)
			{
				throw new FormatException($"The '{value}' is illegal Vector3.", innerException2);
			}
			throw new FormatException($"The '{value}' is illegal Vector3.");
		}
		if (type.Equals(typeof(Vector4)))
		{
			try
			{
				string[] array3 = text.Split(COMMA_SEPARATOR, StringSplitOptions.RemoveEmptyEntries);
				if (array3.Length == 4)
				{
					return new Vector4(float.Parse(array3[0]), float.Parse(array3[1]), float.Parse(array3[2]), float.Parse(array3[3]));
				}
			}
			catch (Exception innerException3)
			{
				throw new FormatException($"The '{value}' is illegal Vector4.", innerException3);
			}
			throw new FormatException($"The '{value}' is illegal Vector4.");
		}
		throw new NotSupportedException();
	}

	public string Encode(object value)
	{
		return value.ToString();
	}
}
