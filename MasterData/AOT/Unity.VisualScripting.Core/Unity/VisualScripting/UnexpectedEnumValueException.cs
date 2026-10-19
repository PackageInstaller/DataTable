using System;

namespace Unity.VisualScripting;

public class UnexpectedEnumValueException<T> : Exception
{
	public T Value { get; private set; }

	public UnexpectedEnumValueException(T value)
		: base("Value " + ((T)value)?.ToString() + " of enum " + typeof(T).Name + " is unexpected.")
	{
		Value = value;
	}
}
