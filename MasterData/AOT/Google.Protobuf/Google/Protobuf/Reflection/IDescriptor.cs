namespace Google.Protobuf.Reflection;

public interface IDescriptor
{
	string Name { get; }

	string FullName { get; }

	FileDescriptor File { get; }
}
