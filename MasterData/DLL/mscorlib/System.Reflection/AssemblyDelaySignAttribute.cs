using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, Inherited = false)]
public sealed class AssemblyDelaySignAttribute : Attribute
{
	[CompilerGenerated]
	private readonly bool _003CDelaySign_003Ek__BackingField;

	public AssemblyDelaySignAttribute(bool delaySign)
	{
		_003CDelaySign_003Ek__BackingField = delaySign;
	}
}
