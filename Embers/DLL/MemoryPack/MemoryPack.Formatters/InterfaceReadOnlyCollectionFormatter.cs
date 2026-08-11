using System.Collections.Generic;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class InterfaceReadOnlyCollectionFormatter<T> : MemoryPackFormatter<IReadOnlyCollection<T?>>
{
	static InterfaceReadOnlyCollectionFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<List<T>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<T>());
		}
	}

	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref IReadOnlyCollection<T?>? value)
	{
		InterfaceCollectionFormatterUtils.SerializeReadOnlyCollection<IReadOnlyCollection<T>, T>(ref writer, ref value);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref IReadOnlyCollection<T?>? value)
	{
		value = InterfaceCollectionFormatterUtils.ReadList<T>(ref reader);
	}
}
