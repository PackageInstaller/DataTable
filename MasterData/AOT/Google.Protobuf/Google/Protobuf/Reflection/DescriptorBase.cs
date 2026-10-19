using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace Google.Protobuf.Reflection;

public abstract class DescriptorBase : IDescriptor
{
	[CompilerGenerated]
	private readonly int Index__BackingField;

	public abstract string Name { get; }

	public string FullName { get; }

	public FileDescriptor File { get; }

	internal DescriptorBase(FileDescriptor file, string fullName, int index)
	{
		File = file;
		FullName = fullName;
		Index__BackingField = index;
	}

	internal virtual IReadOnlyList<DescriptorBase> GetNestedDescriptorListForField(int fieldNumber)
	{
		return null;
	}
}
