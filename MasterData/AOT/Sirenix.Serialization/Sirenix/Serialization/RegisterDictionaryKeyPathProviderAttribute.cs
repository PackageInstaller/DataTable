using System;

namespace Sirenix.Serialization;

[AttributeUsage(AttributeTargets.Assembly, AllowMultiple = true)]
public sealed class RegisterDictionaryKeyPathProviderAttribute : Attribute
{
	public readonly Type ProviderType;

	public RegisterDictionaryKeyPathProviderAttribute(Type providerType)
	{
		ProviderType = providerType;
	}
}
