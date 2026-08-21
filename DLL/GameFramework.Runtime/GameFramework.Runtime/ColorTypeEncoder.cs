using System;
using UnityEngine;

namespace GameFramework.Runtime;

public class ColorTypeEncoder : ITypeEncoder
{
	private int priority = 997;

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
		if (type.Equals(typeof(Color)))
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
		if (ColorUtility.TryParseHtmlString(value, out var color))
		{
			return color;
		}
		throw new FormatException($"The '{value}' is illegal Color.");
	}

	public string Encode(object value)
	{
		return $"#{ColorUtility.ToHtmlStringRGBA((Color)value)}";
	}
}
