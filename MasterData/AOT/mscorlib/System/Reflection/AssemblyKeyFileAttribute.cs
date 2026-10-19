using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, Inherited = false)]
public sealed class AssemblyKeyFileAttribute : Attribute
{
	[CompilerGenerated]
	private readonly string KeyFile__BackingField;

	public AssemblyKeyFileAttribute(string keyFile)
	{
		KeyFile__BackingField = keyFile;
	}
}
