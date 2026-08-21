namespace System.Runtime.CompilerServices;

internal sealed class AsyncMethodBuilderAttribute : Attribute
{
	public Type BuilderType { get; }

	public AsyncMethodBuilderAttribute(Type builderType)
	{
		BuilderType = builderType;
	}
}
