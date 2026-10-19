using System;
using System.Collections.Generic;

namespace Proxima;

public struct PropertyOrValue<T>(string pattern) : IPropertyOrValue
{
	private string _pattern = pattern;

	public bool IsSet => !string.IsNullOrEmpty(_pattern);

	public T Get()
	{
		return (T)Get(typeof(T));
	}

	public object Get(Type type)
	{
		List<PropertyOrField> list = ProximaCommandHelpers.FindProperties(_pattern);
		if (list.Count > 1)
		{
			throw new Exception("Multiple properties found that match pattern.");
		}
		if (list.Count == 1)
		{
			PropertyOrField propertyOrField = list[0];
			if (propertyOrField.CanRead && propertyOrField.Type.IsAssignableFrom(type))
			{
				return propertyOrField.GetValue();
			}
		}
		return ProximaSerialization.Deserialize(type, _pattern);
	}

	public T GetOrDefault(T defaultValue = default(T))
	{
		if (!IsSet)
		{
			return defaultValue;
		}
		return Get();
	}
}
