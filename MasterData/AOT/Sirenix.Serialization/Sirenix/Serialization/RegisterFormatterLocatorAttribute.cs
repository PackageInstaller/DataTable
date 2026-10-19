using System;

namespace Sirenix.Serialization;

[AttributeUsage(AttributeTargets.Assembly, AllowMultiple = true)]
public class RegisterFormatterLocatorAttribute : Attribute
{
	public Type FormatterLocatorType { get; private set; }

	public int Priority { get; private set; }

	public RegisterFormatterLocatorAttribute(Type formatterLocatorType, int priority = 0)
	{
		FormatterLocatorType = formatterLocatorType;
		Priority = priority;
	}
}
