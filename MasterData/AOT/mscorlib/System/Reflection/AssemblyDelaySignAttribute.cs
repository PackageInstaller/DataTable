using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, Inherited = false)]
public sealed class AssemblyDelaySignAttribute : Attribute
{
	[CompilerGenerated]
	private readonly bool DelaySign__BackingField;

	public AssemblyDelaySignAttribute(bool delaySign)
	{
		DelaySign__BackingField = delaySign;
	}
}
