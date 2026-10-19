namespace System.Runtime.CompilerServices;

internal sealed class AsyncMethodBuilderAttribute : Attribute
{
	[CompilerGenerated]
	private readonly Type BuilderType__BackingField;

	public AsyncMethodBuilderAttribute(Type builderType)
	{
		BuilderType__BackingField = builderType;
	}
}
