using System.Collections.Generic;

namespace Google.Protobuf.Reflection;

public sealed class TypeRegistry
{
	private readonly Dictionary<string, MessageDescriptor> fullNameToMessageMap;

	public static TypeRegistry Empty { get; } = new TypeRegistry(new Dictionary<string, MessageDescriptor>());

	private TypeRegistry(Dictionary<string, MessageDescriptor> fullNameToMessageMap)
	{
		this.fullNameToMessageMap = fullNameToMessageMap;
	}

	public MessageDescriptor Find(string fullName)
	{
		fullNameToMessageMap.TryGetValue(fullName, out var value);
		return value;
	}
}
