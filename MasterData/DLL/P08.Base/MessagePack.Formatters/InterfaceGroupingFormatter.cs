using System.Collections.Generic;
using System.Linq;

namespace MessagePack.Formatters;

public sealed class InterfaceGroupingFormatter<TKey, TElement> : IMessagePackFormatter<IGrouping<TKey, TElement>>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, IGrouping<TKey, TElement> value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		writer.WriteArrayHeader(2);
		options.Resolver.GetFormatterWithVerify<TKey>().Serialize(ref writer, value.Key, options);
		options.Resolver.GetFormatterWithVerify<IEnumerable<TElement>>().Serialize(ref writer, value, options);
	}

	public IGrouping<TKey, TElement> Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		if (reader.ReadArrayHeader() != 2)
		{
			throw new MessagePackSerializationException("Invalid Grouping format.");
		}
		options.Security.DepthStep(ref reader);
		try
		{
			TKey key = options.Resolver.GetFormatterWithVerify<TKey>().Deserialize(ref reader, options);
			IEnumerable<TElement> elements = options.Resolver.GetFormatterWithVerify<IEnumerable<TElement>>().Deserialize(ref reader, options);
			return new Grouping<TKey, TElement>(key, elements);
		}
		finally
		{
			reader.Depth--;
		}
	}
}
