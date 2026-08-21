using System;
using System.Text.RegularExpressions;
using UnityEngine;

namespace GameFramework.Runtime;

public class RectTypeEncoder : ITypeEncoder
{
	private int priority = 995;

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
		if (type.Equals(typeof(Rect)))
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
		try
		{
			string text = Regex.Replace(value.Trim(), "(^\\()|(\\)$)", "");
			string[] array = text.Split(new char[1] { ',' }, StringSplitOptions.RemoveEmptyEntries);
			if (array.Length == 4)
			{
				return new Rect(float.Parse(array[0]), float.Parse(array[1]), float.Parse(array[2]), float.Parse(array[3]));
			}
		}
		catch (Exception innerException)
		{
			throw new FormatException($"The '{value}' is illegal Rect.", innerException);
		}
		throw new FormatException($"The '{value}' is illegal Rect.");
	}

	public string Encode(object value)
	{
		Rect rect = (Rect)value;
		return $"({rect.x:F2}, {rect.y:F2}, {rect.width:F2}, {rect.height:F2})";
	}
}
