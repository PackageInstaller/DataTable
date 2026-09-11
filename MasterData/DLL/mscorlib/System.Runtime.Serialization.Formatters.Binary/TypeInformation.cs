namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class TypeInformation
{
	private string fullTypeName;

	private string assemblyString;

	private bool hasTypeForwardedFrom;

	internal string FullTypeName => fullTypeName;

	internal string AssemblyString => assemblyString;

	internal bool HasTypeForwardedFrom => hasTypeForwardedFrom;

	internal TypeInformation(string fullTypeName, string assemblyString, bool hasTypeForwardedFrom)
	{
		this.fullTypeName = fullTypeName;
		this.assemblyString = assemblyString;
		this.hasTypeForwardedFrom = hasTypeForwardedFrom;
	}
}
