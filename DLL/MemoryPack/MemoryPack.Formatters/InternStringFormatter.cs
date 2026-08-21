using System.Runtime.CompilerServices;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class InternStringFormatter : MemoryPackFormatter<string>
{
	public static readonly InternStringFormatter Default = new InternStringFormatter();

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref string? value)
	{
		writer.WriteString(value);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref string? value)
	{
		string text = reader.ReadString();
		if (text == null)
		{
			value = null;
		}
		else
		{
			value = string.Intern(text);
		}
	}
}
