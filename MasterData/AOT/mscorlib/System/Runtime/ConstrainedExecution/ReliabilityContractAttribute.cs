using System.Runtime.CompilerServices;

namespace System.Runtime.ConstrainedExecution;

[AttributeUsage(AttributeTargets.Assembly | AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Constructor | AttributeTargets.Method | AttributeTargets.Interface, Inherited = false)]
public sealed class ReliabilityContractAttribute : Attribute
{
	[CompilerGenerated]
	private readonly Consistency ConsistencyGuarantee__BackingField;

	[CompilerGenerated]
	private readonly Cer Cer__BackingField;

	public ReliabilityContractAttribute(Consistency consistencyGuarantee, Cer cer)
	{
		ConsistencyGuarantee__BackingField = consistencyGuarantee;
		Cer__BackingField = cer;
	}
}
