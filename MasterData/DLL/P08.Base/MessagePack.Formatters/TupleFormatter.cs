using System;

namespace MessagePack.Formatters;

public sealed class TupleFormatter<T1> : IMessagePackFormatter<Tuple<T1>>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, Tuple<T1> value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		writer.WriteArrayHeader(1);
		options.Resolver.GetFormatterWithVerify<T1>().Serialize(ref writer, value.Item1, options);
	}

	public Tuple<T1> Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		if (reader.ReadArrayHeader() != 1)
		{
			throw new MessagePackSerializationException("Invalid Tuple count");
		}
		IFormatterResolver resolver = options.Resolver;
		options.Security.DepthStep(ref reader);
		try
		{
			return new Tuple<T1>(resolver.GetFormatterWithVerify<T1>().Deserialize(ref reader, options));
		}
		finally
		{
			reader.Depth--;
		}
	}
}
public sealed class TupleFormatter<T1, T2> : IMessagePackFormatter<Tuple<T1, T2>>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, Tuple<T1, T2> value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		writer.WriteArrayHeader(2);
		IFormatterResolver resolver = options.Resolver;
		resolver.GetFormatterWithVerify<T1>().Serialize(ref writer, value.Item1, options);
		resolver.GetFormatterWithVerify<T2>().Serialize(ref writer, value.Item2, options);
	}

	public Tuple<T1, T2> Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		if (reader.ReadArrayHeader() != 2)
		{
			throw new MessagePackSerializationException("Invalid Tuple count");
		}
		IFormatterResolver resolver = options.Resolver;
		options.Security.DepthStep(ref reader);
		try
		{
			T1 item = resolver.GetFormatterWithVerify<T1>().Deserialize(ref reader, options);
			T2 item2 = resolver.GetFormatterWithVerify<T2>().Deserialize(ref reader, options);
			return new Tuple<T1, T2>(item, item2);
		}
		finally
		{
			reader.Depth--;
		}
	}
}
public sealed class TupleFormatter<T1, T2, T3> : IMessagePackFormatter<Tuple<T1, T2, T3>>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, Tuple<T1, T2, T3> value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		writer.WriteArrayHeader(3);
		IFormatterResolver resolver = options.Resolver;
		resolver.GetFormatterWithVerify<T1>().Serialize(ref writer, value.Item1, options);
		resolver.GetFormatterWithVerify<T2>().Serialize(ref writer, value.Item2, options);
		resolver.GetFormatterWithVerify<T3>().Serialize(ref writer, value.Item3, options);
	}

	public Tuple<T1, T2, T3> Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		if (reader.ReadArrayHeader() != 3)
		{
			throw new MessagePackSerializationException("Invalid Tuple count");
		}
		IFormatterResolver resolver = options.Resolver;
		options.Security.DepthStep(ref reader);
		try
		{
			T1 item = resolver.GetFormatterWithVerify<T1>().Deserialize(ref reader, options);
			T2 item2 = resolver.GetFormatterWithVerify<T2>().Deserialize(ref reader, options);
			T3 item3 = resolver.GetFormatterWithVerify<T3>().Deserialize(ref reader, options);
			return new Tuple<T1, T2, T3>(item, item2, item3);
		}
		finally
		{
			reader.Depth--;
		}
	}
}
public sealed class TupleFormatter<T1, T2, T3, T4> : IMessagePackFormatter<Tuple<T1, T2, T3, T4>>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, Tuple<T1, T2, T3, T4> value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		writer.WriteArrayHeader(4);
		IFormatterResolver resolver = options.Resolver;
		resolver.GetFormatterWithVerify<T1>().Serialize(ref writer, value.Item1, options);
		resolver.GetFormatterWithVerify<T2>().Serialize(ref writer, value.Item2, options);
		resolver.GetFormatterWithVerify<T3>().Serialize(ref writer, value.Item3, options);
		resolver.GetFormatterWithVerify<T4>().Serialize(ref writer, value.Item4, options);
	}

	public Tuple<T1, T2, T3, T4> Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		if (reader.ReadArrayHeader() != 4)
		{
			throw new MessagePackSerializationException("Invalid Tuple count");
		}
		IFormatterResolver resolver = options.Resolver;
		options.Security.DepthStep(ref reader);
		try
		{
			T1 item = resolver.GetFormatterWithVerify<T1>().Deserialize(ref reader, options);
			T2 item2 = resolver.GetFormatterWithVerify<T2>().Deserialize(ref reader, options);
			T3 item3 = resolver.GetFormatterWithVerify<T3>().Deserialize(ref reader, options);
			T4 item4 = resolver.GetFormatterWithVerify<T4>().Deserialize(ref reader, options);
			return new Tuple<T1, T2, T3, T4>(item, item2, item3, item4);
		}
		finally
		{
			reader.Depth--;
		}
	}
}
public sealed class TupleFormatter<T1, T2, T3, T4, T5> : IMessagePackFormatter<Tuple<T1, T2, T3, T4, T5>>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, Tuple<T1, T2, T3, T4, T5> value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		writer.WriteArrayHeader(5);
		IFormatterResolver resolver = options.Resolver;
		resolver.GetFormatterWithVerify<T1>().Serialize(ref writer, value.Item1, options);
		resolver.GetFormatterWithVerify<T2>().Serialize(ref writer, value.Item2, options);
		resolver.GetFormatterWithVerify<T3>().Serialize(ref writer, value.Item3, options);
		resolver.GetFormatterWithVerify<T4>().Serialize(ref writer, value.Item4, options);
		resolver.GetFormatterWithVerify<T5>().Serialize(ref writer, value.Item5, options);
	}

	public Tuple<T1, T2, T3, T4, T5> Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		if (reader.ReadArrayHeader() != 5)
		{
			throw new MessagePackSerializationException("Invalid Tuple count");
		}
		IFormatterResolver resolver = options.Resolver;
		options.Security.DepthStep(ref reader);
		try
		{
			T1 item = resolver.GetFormatterWithVerify<T1>().Deserialize(ref reader, options);
			T2 item2 = resolver.GetFormatterWithVerify<T2>().Deserialize(ref reader, options);
			T3 item3 = resolver.GetFormatterWithVerify<T3>().Deserialize(ref reader, options);
			T4 item4 = resolver.GetFormatterWithVerify<T4>().Deserialize(ref reader, options);
			T5 item5 = resolver.GetFormatterWithVerify<T5>().Deserialize(ref reader, options);
			return new Tuple<T1, T2, T3, T4, T5>(item, item2, item3, item4, item5);
		}
		finally
		{
			reader.Depth--;
		}
	}
}
public sealed class TupleFormatter<T1, T2, T3, T4, T5, T6> : IMessagePackFormatter<Tuple<T1, T2, T3, T4, T5, T6>>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, Tuple<T1, T2, T3, T4, T5, T6> value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		writer.WriteArrayHeader(6);
		IFormatterResolver resolver = options.Resolver;
		resolver.GetFormatterWithVerify<T1>().Serialize(ref writer, value.Item1, options);
		resolver.GetFormatterWithVerify<T2>().Serialize(ref writer, value.Item2, options);
		resolver.GetFormatterWithVerify<T3>().Serialize(ref writer, value.Item3, options);
		resolver.GetFormatterWithVerify<T4>().Serialize(ref writer, value.Item4, options);
		resolver.GetFormatterWithVerify<T5>().Serialize(ref writer, value.Item5, options);
		resolver.GetFormatterWithVerify<T6>().Serialize(ref writer, value.Item6, options);
	}

	public Tuple<T1, T2, T3, T4, T5, T6> Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		if (reader.ReadArrayHeader() != 6)
		{
			throw new MessagePackSerializationException("Invalid Tuple count");
		}
		IFormatterResolver resolver = options.Resolver;
		options.Security.DepthStep(ref reader);
		try
		{
			T1 item = resolver.GetFormatterWithVerify<T1>().Deserialize(ref reader, options);
			T2 item2 = resolver.GetFormatterWithVerify<T2>().Deserialize(ref reader, options);
			T3 item3 = resolver.GetFormatterWithVerify<T3>().Deserialize(ref reader, options);
			T4 item4 = resolver.GetFormatterWithVerify<T4>().Deserialize(ref reader, options);
			T5 item5 = resolver.GetFormatterWithVerify<T5>().Deserialize(ref reader, options);
			T6 item6 = resolver.GetFormatterWithVerify<T6>().Deserialize(ref reader, options);
			return new Tuple<T1, T2, T3, T4, T5, T6>(item, item2, item3, item4, item5, item6);
		}
		finally
		{
			reader.Depth--;
		}
	}
}
public sealed class TupleFormatter<T1, T2, T3, T4, T5, T6, T7> : IMessagePackFormatter<Tuple<T1, T2, T3, T4, T5, T6, T7>>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, Tuple<T1, T2, T3, T4, T5, T6, T7> value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		writer.WriteArrayHeader(7);
		IFormatterResolver resolver = options.Resolver;
		resolver.GetFormatterWithVerify<T1>().Serialize(ref writer, value.Item1, options);
		resolver.GetFormatterWithVerify<T2>().Serialize(ref writer, value.Item2, options);
		resolver.GetFormatterWithVerify<T3>().Serialize(ref writer, value.Item3, options);
		resolver.GetFormatterWithVerify<T4>().Serialize(ref writer, value.Item4, options);
		resolver.GetFormatterWithVerify<T5>().Serialize(ref writer, value.Item5, options);
		resolver.GetFormatterWithVerify<T6>().Serialize(ref writer, value.Item6, options);
		resolver.GetFormatterWithVerify<T7>().Serialize(ref writer, value.Item7, options);
	}

	public Tuple<T1, T2, T3, T4, T5, T6, T7> Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		if (reader.ReadArrayHeader() != 7)
		{
			throw new MessagePackSerializationException("Invalid Tuple count");
		}
		IFormatterResolver resolver = options.Resolver;
		options.Security.DepthStep(ref reader);
		try
		{
			T1 item = resolver.GetFormatterWithVerify<T1>().Deserialize(ref reader, options);
			T2 item2 = resolver.GetFormatterWithVerify<T2>().Deserialize(ref reader, options);
			T3 item3 = resolver.GetFormatterWithVerify<T3>().Deserialize(ref reader, options);
			T4 item4 = resolver.GetFormatterWithVerify<T4>().Deserialize(ref reader, options);
			T5 item5 = resolver.GetFormatterWithVerify<T5>().Deserialize(ref reader, options);
			T6 item6 = resolver.GetFormatterWithVerify<T6>().Deserialize(ref reader, options);
			T7 item7 = resolver.GetFormatterWithVerify<T7>().Deserialize(ref reader, options);
			return new Tuple<T1, T2, T3, T4, T5, T6, T7>(item, item2, item3, item4, item5, item6, item7);
		}
		finally
		{
			reader.Depth--;
		}
	}
}
public sealed class TupleFormatter<T1, T2, T3, T4, T5, T6, T7, TRest> : IMessagePackFormatter<Tuple<T1, T2, T3, T4, T5, T6, T7, TRest>>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, Tuple<T1, T2, T3, T4, T5, T6, T7, TRest> value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		writer.WriteArrayHeader(8);
		IFormatterResolver resolver = options.Resolver;
		resolver.GetFormatterWithVerify<T1>().Serialize(ref writer, value.Item1, options);
		resolver.GetFormatterWithVerify<T2>().Serialize(ref writer, value.Item2, options);
		resolver.GetFormatterWithVerify<T3>().Serialize(ref writer, value.Item3, options);
		resolver.GetFormatterWithVerify<T4>().Serialize(ref writer, value.Item4, options);
		resolver.GetFormatterWithVerify<T5>().Serialize(ref writer, value.Item5, options);
		resolver.GetFormatterWithVerify<T6>().Serialize(ref writer, value.Item6, options);
		resolver.GetFormatterWithVerify<T7>().Serialize(ref writer, value.Item7, options);
		resolver.GetFormatterWithVerify<TRest>().Serialize(ref writer, value.Rest, options);
	}

	public Tuple<T1, T2, T3, T4, T5, T6, T7, TRest> Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		if (reader.ReadArrayHeader() != 8)
		{
			throw new MessagePackSerializationException("Invalid Tuple count");
		}
		IFormatterResolver resolver = options.Resolver;
		options.Security.DepthStep(ref reader);
		try
		{
			T1 item = resolver.GetFormatterWithVerify<T1>().Deserialize(ref reader, options);
			T2 item2 = resolver.GetFormatterWithVerify<T2>().Deserialize(ref reader, options);
			T3 item3 = resolver.GetFormatterWithVerify<T3>().Deserialize(ref reader, options);
			T4 item4 = resolver.GetFormatterWithVerify<T4>().Deserialize(ref reader, options);
			T5 item5 = resolver.GetFormatterWithVerify<T5>().Deserialize(ref reader, options);
			T6 item6 = resolver.GetFormatterWithVerify<T6>().Deserialize(ref reader, options);
			T7 item7 = resolver.GetFormatterWithVerify<T7>().Deserialize(ref reader, options);
			TRest rest = resolver.GetFormatterWithVerify<TRest>().Deserialize(ref reader, options);
			return new Tuple<T1, T2, T3, T4, T5, T6, T7, TRest>(item, item2, item3, item4, item5, item6, item7, rest);
		}
		finally
		{
			reader.Depth--;
		}
	}
}
