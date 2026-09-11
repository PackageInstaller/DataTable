using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;

namespace JetBrains.Annotations;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Parameter | AttributeTargets.GenericParameter)]
public sealed class MeansImplicitUseAttribute : Attribute
{
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private readonly ImplicitUseKindFlags _003CUseKindFlags_003Ek__BackingField;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private readonly ImplicitUseTargetFlags _003CTargetFlags_003Ek__BackingField;

	public MeansImplicitUseAttribute()
		: this(ImplicitUseKindFlags.Default, ImplicitUseTargetFlags.Default)
	{
	}

	public MeansImplicitUseAttribute(ImplicitUseKindFlags useKindFlags, ImplicitUseTargetFlags targetFlags)
	{
		_003CUseKindFlags_003Ek__BackingField = useKindFlags;
		_003CTargetFlags_003Ek__BackingField = targetFlags;
	}
}
