using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, AllowMultiple = true, Inherited = false)]
public sealed class AssemblyMetadataAttribute : Attribute
{
	[CompilerGenerated]
	private readonly string _003CKey_003Ek__BackingField;

	[CompilerGenerated]
	private readonly string _003CValue_003Ek__BackingField;

	public AssemblyMetadataAttribute(string key, string value)
	{
		_003CKey_003Ek__BackingField = key;
		_003CValue_003Ek__BackingField = value;
	}
}
