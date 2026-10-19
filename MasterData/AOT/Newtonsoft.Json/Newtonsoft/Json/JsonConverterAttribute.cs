using System;

namespace Newtonsoft.Json;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Enum | AttributeTargets.Property | AttributeTargets.Field | AttributeTargets.Interface | AttributeTargets.Parameter, AllowMultiple = false)]
public sealed class JsonConverterAttribute : Attribute
{
	private readonly Type _converterType;

	public Type ConverterType => _converterType;

	public object[]? ConverterParameters { get; }
}
