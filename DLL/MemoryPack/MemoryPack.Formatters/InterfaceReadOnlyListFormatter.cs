using System.Collections.Generic;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class InterfaceReadOnlyListFormatter<T> : MemoryPackFormatter<IReadOnlyList<T?>>
{
	static InterfaceReadOnlyListFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<List<T>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<T>());
		}
	}

	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref IReadOnlyList<T?>? value)
	{
		InterfaceCollectionFormatterUtils.SerializeReadOnlyCollection<IReadOnlyList<T>, T>(ref writer, ref value);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref IReadOnlyList<T?>? value)
	{
		value = InterfaceCollectionFormatterUtils.ReadList<T>(ref reader);
	}
}
