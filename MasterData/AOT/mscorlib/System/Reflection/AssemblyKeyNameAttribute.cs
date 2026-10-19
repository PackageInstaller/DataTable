using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, Inherited = false)]
public sealed class AssemblyKeyNameAttribute : Attribute
{
	[CompilerGenerated]
	private readonly string KeyName__BackingField;

	public AssemblyKeyNameAttribute(string keyName)
	{
		KeyName__BackingField = keyName;
	}
}
