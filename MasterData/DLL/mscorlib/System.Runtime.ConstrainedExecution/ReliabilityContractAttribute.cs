using System.Runtime.CompilerServices;

namespace System.Runtime.ConstrainedExecution;

[AttributeUsage(AttributeTargets.Assembly | AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Constructor | AttributeTargets.Method | AttributeTargets.Interface, Inherited = false)]
public sealed class ReliabilityContractAttribute : Attribute
{
	[CompilerGenerated]
	private readonly Consistency _003CConsistencyGuarantee_003Ek__BackingField;

	[CompilerGenerated]
	private readonly Cer _003CCer_003Ek__BackingField;

	public ReliabilityContractAttribute(Consistency consistencyGuarantee, Cer cer)
	{
		_003CConsistencyGuarantee_003Ek__BackingField = consistencyGuarantee;
		_003CCer_003Ek__BackingField = cer;
	}
}
