using System;
using System.Collections;
using Nerdbank.Streams;

namespace MessagePack.Formatters;

public sealed class NonGenericInterfaceEnumerableFormatter : IMessagePackFormatter<IEnumerable>, IMessagePackFormatter
{
	public static readonly IMessagePackFormatter<IEnumerable> Instance = new NonGenericInterfaceEnumerableFormatter();

	private NonGenericInterfaceEnumerableFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, IEnumerable value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		IMessagePackFormatter<object> formatterWithVerify = options.Resolver.GetFormatterWithVerify<object>();
		using SequencePool.Rental rental = options.SequencePool.Rent();
		Sequence<byte> value2 = rental.Value;
		MessagePackWriter writer2 = writer.Clone(value2);
		int num = 0;
		IEnumerator enumerator = value.GetEnumerator();
		try
		{
			while (enumerator.MoveNext())
			{
				writer.CancellationToken.ThrowIfCancellationRequested();
				num++;
				formatterWithVerify.Serialize(ref writer2, enumerator.Current, options);
			}
		}
		finally
		{
			IDisposable disposable = enumerator as IDisposable;
			if (disposable != null)
			{
				disposable.Dispose();
			}
		}
		writer2.Flush();
		writer.WriteArrayHeader(num);
		writer.WriteRaw(value2.AsReadOnlySequence);
	}

	public IEnumerable Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
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
