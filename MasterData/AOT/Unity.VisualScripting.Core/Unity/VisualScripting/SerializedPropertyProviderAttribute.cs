using System;

namespace Unity.VisualScripting;

[AttributeUsage(AttributeTargets.Class, AllowMultiple = false, Inherited = false)]
public sealed class SerializedPropertyProviderAttribute : Attribute, IDecoratorAttribute
{
	public Type type { get; private set; }

	public SerializedPropertyProviderAttribute(Type type)
	{
		this.type = type;
	}
}
