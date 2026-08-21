using System.Collections.Generic;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class InterfaceCollectionFormatter<T> : MemoryPackFormatter<ICollection<T?>>
{
	static InterfaceCollectionFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<List<T>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<T>());
		}
	}

	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref ICollection<T?>? value)
	{
		InterfaceCollectionFormatterUtils.SerializeCollection<ICollection<T>, T>(ref writer, ref value);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref ICollection<T?>? value)
	{
		value = InterfaceCollectionFormatterUtils.ReadList<T>(ref reader);
	}
}
