namespace System.CodeDom.Compiler;

[AttributeUsage(AttributeTargets.All, Inherited = false, AllowMultiple = false)]
public sealed class GeneratedCodeAttribute : Attribute
{
	private readonly string tool;

	private readonly string version;

	public string Tool => tool;

	public string Version => version;

	public GeneratedCodeAttribute(string tool, string version)
	{
		this.tool = tool;
		this.version = version;
	}
}
