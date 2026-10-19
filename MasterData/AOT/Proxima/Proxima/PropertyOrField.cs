using System;
using System.Reflection;

namespace Proxima;

internal class PropertyOrField
{
	public string Descriptor { get; set; }

	public object Object { get; set; }

	public PropertyInfo Property { get; set; }

	public FieldInfo Field { get; set; }

	public object Value { get; set; }

	public Type Type
	{
		get
		{
			if (Property != null)
			{
				return Property.PropertyType;
			}
			if (Field != null)
			{
				return Field.FieldType;
			}
			return Value?.GetType();
		}
	}

	public bool CanWrite
	{
		get
		{
			if (Property != null)
			{
				return Property.CanWrite;
			}
			return Field != null;
		}
	}

	public bool CanRead
	{
		get
		{
			if (Property != null)
			{
				return Property.CanRead;
			}
			if (!(Field != null))
			{
				return Value != null;
			}
			return true;
		}
	}

	public PropertyOrField(string descriptor, object obj, PropertyInfo property, FieldInfo field)
	{
		Descriptor = descriptor;
		Object = obj;
		Property = property;
		Field = field;
	}

	public PropertyOrField(string descriptor, object value)
	{
		Descriptor = descriptor;
		Value = value;
	}

	public void SetValue(object value)
	{
		if (Property != null && Property.CanWrite)
		{
			Property.SetValue(Object, value);
		}
		else if (Field != null)
		{
			Field.SetValue(Object, value);
		}
	}

	public object GetValue()
	{
		if (Property != null && Property.CanRead)
		{
			return Property.GetValue(Object);
		}
		if (Field != null)
		{
			return Field.GetValue(Object);
		}
		return Value;
	}
}
