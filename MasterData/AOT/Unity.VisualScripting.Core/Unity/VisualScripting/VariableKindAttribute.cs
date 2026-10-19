using System;

namespace Unity.VisualScripting;

[Obsolete("Set VariableKind via VariableDeclarations.Kind")]
[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, AllowMultiple = false, Inherited = true)]
public sealed class VariableKindAttribute : Attribute
{
	public VariableKind kind { get; }

	public VariableKindAttribute(VariableKind kind)
	{
		this.kind = kind;
	}
}
