namespace System.Runtime.CompilerServices;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Interface, AllowMultiple = true, Inherited = false)]
internal sealed class TypeDependencyAttribute : Attribute
{
	private string typeName;

	public TypeDependencyAttribute(string typeName)
	{
		if (typeName == null)
		{
			throw new ArgumentNullException("typeName");
		}
		this.typeName = typeName;
	}
}
