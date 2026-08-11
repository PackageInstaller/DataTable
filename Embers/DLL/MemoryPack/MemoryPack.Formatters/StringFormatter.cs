using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class StringFormatter : MemoryPackFormatter<string>
{
	public static readonly StringFormatter Default = new StringFormatter();

	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref string? value)
	{
		writer.WriteString(value);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref string? value)
	{
		value = reader.ReadString();
	}
}
