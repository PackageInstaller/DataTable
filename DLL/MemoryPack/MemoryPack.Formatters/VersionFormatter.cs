using System;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class VersionFormatter : MemoryPackFormatter<Version>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref Version? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<int, int, int, int>(4, value.Major, value.Minor, value.Build, value.Revision);
		}
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref Version? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		if (memberCount != 4)
		{
			MemoryPackSerializationException.ThrowInvalidPropertyCount(4, memberCount);
		}
		reader.ReadUnmanaged<int, int, int, int>(out var value2, out var value3, out var value4, out var value5);
		if (value5 == -1)
		{
			if (value4 == -1)
			{
				value = new Version(value2, value3);
			}
			else
			{
				value = new Version(value2, value3, value4);
			}
		}
		else
		{
			value = new Version(value2, value3, value4, value5);
		}
	}
}
