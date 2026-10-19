using System;

namespace Unity.VisualScripting;

[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, AllowMultiple = false, Inherited = true)]
public sealed class ExpectedTypeAttribute : Attribute
{
	public Type type { get; }

	public ExpectedTypeAttribute(Type type)
	{
		Ensure.That("type").IsNotNull(type);
		this.type = type;
	}
}
