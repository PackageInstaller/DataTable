using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;

namespace Unity.Jobs.LowLevel.Unsafe;

[AttributeUsage(AttributeTargets.Interface)]
public sealed class JobProducerTypeAttribute : Attribute
{
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private readonly Type _003CProducerType_003Ek__BackingField;

	public JobProducerTypeAttribute(Type producerType)
	{
		_003CProducerType_003Ek__BackingField = producerType;
	}
}
