using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, Inherited = false)]
public sealed class AssemblyKeyFileAttribute : Attribute
{
	[CompilerGenerated]
	private readonly string _003CKeyFile_003Ek__BackingField;

	public AssemblyKeyFileAttribute(string keyFile)
	{
		_003CKeyFile_003Ek__BackingField = keyFile;
	}
}
