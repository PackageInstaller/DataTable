namespace System.Runtime.CompilerServices;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Enum | AttributeTargets.Interface | AttributeTargets.Delegate, Inherited = false, AllowMultiple = false)]
public sealed class AsyncMethodBuilderAttribute : Attribute
{
	[CompilerGenerated]
	private readonly Type BuilderType__BackingField;

	public AsyncMethodBuilderAttribute(Type builderType)
	{
		BuilderType__BackingField = builderType;
	}
}
