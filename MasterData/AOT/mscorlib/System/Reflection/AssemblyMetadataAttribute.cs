using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, AllowMultiple = true, Inherited = false)]
public sealed class AssemblyMetadataAttribute : Attribute
{
	[CompilerGenerated]
	private readonly string Key__BackingField;

	[CompilerGenerated]
	private readonly string Value__BackingField;

	public AssemblyMetadataAttribute(string key, string value)
	{
		Key__BackingField = key;
		Value__BackingField = value;
	}
}
