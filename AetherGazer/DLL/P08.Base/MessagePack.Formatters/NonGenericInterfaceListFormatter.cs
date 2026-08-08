using System;
using System.Collections;

namespace MessagePack.Formatters;

public sealed class NonGenericInterfaceListFormatter : IMessagePackFormatter<IList>, IMessagePackFormatter
{
	public static readonly IMessagePackFormatter<IList> Instance = new NonGenericInterfaceListFormatter();

	private NonGenericInterfaceListFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, IList value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		IMessagePackFormatter<object> formatterWithVerify = options.Resolver.GetFormatterWithVerify<object>();
		writer.WriteArrayHeader(value.Count);
		foreach (object item in value)
		{
			writer.CancellationToken.ThrowIfCancellationRequested();
			formatterWithVerify.Serialize(ref writer, item, options);
		}
	}

	public IList Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		int num = reader.ReadArrayHeader();
		if (num == 0)
		{
			return Array.Empty<object>();
		}
		IMessagePackFormatter<object> formatterWithVerify = options.Resolver.GetFormatterWithVerify<object>();
		object[] array = new object[num];
		options.Security.DepthStep(ref reader);
		try
		{
			for (int i = 0; i < num; i++)
			{
				reader.CancellationToken.ThrowIfCancellationRequested();
				array[i] = formatterWithVerify.Deserialize(ref reader, options);
			}
			return array;
		}
		finally
		{
			reader.Depth--;
		}
	}
}
