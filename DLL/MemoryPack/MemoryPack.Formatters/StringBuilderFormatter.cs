using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class StringBuilderFormatter : MemoryPackFormatter<StringBuilder>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref StringBuilder? value)
	{
		if (value == null)
		{
			writer.WriteNullCollectionHeader();
		}
		else
		{
			writer.WriteUtf16(value.ToString());
		}
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref StringBuilder? value)
	{
		if (!reader.TryReadCollectionHeader(out var length))
		{
			value = null;
			return;
		}
		if (value == null)
		{
			value = new StringBuilder(length);
		}
		else
		{
			value.Clear();
			value.EnsureCapacity(length);
		}
		int num = checked(length * 2);
		Span<char> span = MemoryMarshal.CreateSpan(ref Unsafe.As<byte, char>(ref reader.GetSpanReference(num)), length);
		value.Append(span);
		reader.Advance(num);
	}
}
