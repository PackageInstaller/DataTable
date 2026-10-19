namespace System.Reflection;

[Flags]
public enum GenericParameterAttributes
{
	None = 0,
	VarianceMask = 3,
	Covariant = 1,
	Contravariant = 2,
	SpecialConstraintMask = 0x1C,
	ReferenceTypeConstraint = 4,
	NotNullableValueTypeConstraint = 8,
	DefaultConstructorConstraint = 0x10
}
