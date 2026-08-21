using System;

namespace GameFramework.Runtime;

public class EnumTypeEncoder : ITypeEncoder
{
	private int priority = 998;

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
		if (type.IsEnum)
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
		return Enum.Parse(type, value);
	}

	public string Encode(object value)
	{
		return Enum.GetName(value.GetType(), value);
	}
}
