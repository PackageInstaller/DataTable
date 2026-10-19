namespace Google.Protobuf.Reflection;

internal sealed class PackageDescriptor : IDescriptor
{
	private readonly string name;

	private readonly string fullName;

	private readonly FileDescriptor file;

	public string Name => name;

	public string FullName => fullName;

	public FileDescriptor File => file;

	internal PackageDescriptor(string name, string fullName, FileDescriptor file)
	{
		this.file = file;
		this.fullName = fullName;
		this.name = name;
	}
}
