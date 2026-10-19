using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;

namespace JetBrains.Annotations;

[AttributeUsage(AttributeTargets.All, Inherited = false)]
public sealed class UsedImplicitlyAttribute : Attribute
{
	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private readonly ImplicitUseKindFlags UseKindFlags__BackingField;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private readonly ImplicitUseTargetFlags TargetFlags__BackingField;

	public UsedImplicitlyAttribute()
		: this(ImplicitUseKindFlags.Default, ImplicitUseTargetFlags.Default)
	{
	}

	public UsedImplicitlyAttribute(ImplicitUseKindFlags useKindFlags, ImplicitUseTargetFlags targetFlags)
	{
		UseKindFlags__BackingField = useKindFlags;
		TargetFlags__BackingField = targetFlags;
	}
}
