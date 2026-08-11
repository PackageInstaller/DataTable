using System.Runtime.CompilerServices;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class Utf8StringFormatter : MemoryPackFormatter<string>
{
	public static readonly Utf8StringFormatter Default = new Utf8StringFormatter();

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref string? value)
	{
		writer.WriteUtf8(value);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref string? value)
	{
		value = reader.ReadString();
	}
}
