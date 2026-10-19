using System;

namespace Unity.VisualScripting;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Interface, AllowMultiple = false, Inherited = true)]
public sealed class TypeIconAttribute : Attribute
{
	public Type type { get; }

	public TypeIconAttribute(Type type)
	{
		Ensure.That("type").IsNotNull(type);
		this.type = type;
	}
}
