namespace System.Runtime.CompilerServices;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Enum | AttributeTargets.Interface | AttributeTargets.Delegate, Inherited = false, AllowMultiple = false)]
public sealed class TypeForwardedFromAttribute : Attribute
{
	public string AssemblyFullName { get; }

	public TypeForwardedFromAttribute(string assemblyFullName)
	{
		if (string.IsNullOrEmpty(assemblyFullName))
		{
			throw new ArgumentNullException("assemblyFullName");
		}
		AssemblyFullName = assemblyFullName;
	}
}
