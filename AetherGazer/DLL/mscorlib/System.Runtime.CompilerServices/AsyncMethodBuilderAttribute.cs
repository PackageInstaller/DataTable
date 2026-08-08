namespace System.Runtime.CompilerServices;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Enum | AttributeTargets.Interface | AttributeTargets.Delegate, Inherited = false, AllowMultiple = false)]
public sealed class AsyncMethodBuilderAttribute : Attribute
{
	[CompilerGenerated]
	private readonly Type _003CBuilderType_003Ek__BackingField;

	public AsyncMethodBuilderAttribute(Type builderType)
	{
		_003CBuilderType_003Ek__BackingField = builderType;
	}
}
