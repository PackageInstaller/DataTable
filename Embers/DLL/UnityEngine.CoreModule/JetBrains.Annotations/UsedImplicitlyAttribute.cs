using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;

namespace JetBrains.Annotations;

[AttributeUsage(AttributeTargets.All, Inherited = false)]
public sealed class UsedImplicitlyAttribute : Attribute
{
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private readonly ImplicitUseKindFlags _003CUseKindFlags_003Ek__BackingField;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private readonly ImplicitUseTargetFlags _003CTargetFlags_003Ek__BackingField;

	public UsedImplicitlyAttribute()
		: this(ImplicitUseKindFlags.Default, ImplicitUseTargetFlags.Default)
	{
	}

	public UsedImplicitlyAttribute(ImplicitUseKindFlags useKindFlags, ImplicitUseTargetFlags targetFlags)
	{
		_003CUseKindFlags_003Ek__BackingField = useKindFlags;
		_003CTargetFlags_003Ek__BackingField = targetFlags;
	}
}
