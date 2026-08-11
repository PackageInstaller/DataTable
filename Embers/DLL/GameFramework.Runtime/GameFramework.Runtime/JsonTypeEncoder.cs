using System;
using System.Collections;
using UnityEngine;

namespace GameFramework.Runtime;

public class JsonTypeEncoder : ITypeEncoder
{
	private int priority = -1000;

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
		if (typeof(IList).IsAssignableFrom(type) || typeof(IDictionary).IsAssignableFrom(type) || typeof(Rect).Equals(type))
		{
			return false;
		}
		if (type.IsPrimitive)
		{
			return false;
		}
		return true;
	}

	public string Encode(object value)
	{
		try
		{
			return JsonUtility.ToJson(value);
		}
		catch (Exception innerException)
		{
			throw new NotSupportedException("", innerException);
		}
	}

	public object Decode(Type type, string value)
	{
		try
		{
			return JsonUtility.FromJson(value, type);
		}
		catch (Exception innerException)
		{
			throw new NotSupportedException("", innerException);
		}
	}
}
