using System.Collections.Generic;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class InterfaceListFormatter<T> : MemoryPackFormatter<IList<T?>>
{
	static InterfaceListFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<List<T>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<T>());
		}
	}

	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref IList<T?>? value)
	{
		InterfaceCollectionFormatterUtils.SerializeCollection<IList<T>, T>(ref writer, ref value);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref IList<T?>? value)
	{
		value = InterfaceCollectionFormatterUtils.ReadList<T>(ref reader);
	}
}
