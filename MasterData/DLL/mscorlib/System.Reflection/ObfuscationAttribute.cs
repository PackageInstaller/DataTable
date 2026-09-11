using System.Runtime.CompilerServices;

namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly | AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Enum | AttributeTargets.Method | AttributeTargets.Property | AttributeTargets.Field | AttributeTargets.Event | AttributeTargets.Interface | AttributeTargets.Parameter | AttributeTargets.Delegate, AllowMultiple = true, Inherited = false)]
public sealed class ObfuscationAttribute : Attribute
{
	[CompilerGenerated]
	private bool _003CStripAfterObfuscation_003Ek__BackingField = true;

	[CompilerGenerated]
	private bool _003CExclude_003Ek__BackingField = true;

	[CompilerGenerated]
	private bool _003CApplyToMembers_003Ek__BackingField = true;

	[CompilerGenerated]
	private string _003CFeature_003Ek__BackingField = "all";

	public bool Exclude
	{
		[CompilerGenerated]
		set
		{
			_003CExclude_003Ek__BackingField = value;
		}
	}
}
