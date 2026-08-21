namespace System.Reflection;

[AttributeUsage(AttributeTargets.Assembly, Inherited = false)]
public sealed class AssemblyInformationalVersionAttribute : Attribute
{
	public string InformationalVersion { get; }

	public AssemblyInformationalVersionAttribute(string informationalVersion)
	{
		InformationalVersion = informationalVersion;
	}
}
