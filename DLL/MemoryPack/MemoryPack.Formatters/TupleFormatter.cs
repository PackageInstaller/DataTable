using System;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class TupleFormatter<T1> : MemoryPackFormatter<Tuple<T1?>>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref Tuple<T1?>? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteObjectHeader(1);
		writer.WriteValue<T1>(value.Item1);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref Tuple<T1?>? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		if (memberCount != 1)
		{
			MemoryPackSerializationException.ThrowInvalidPropertyCount(1, memberCount);
		}
		value = new Tuple<T1>(reader.ReadValue<T1>());
	}
}
[Preserve]
public sealed class TupleFormatter<T1, T2> : MemoryPackFormatter<Tuple<T1?, T2?>>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref Tuple<T1?, T2?>? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteObjectHeader(2);
		writer.WriteValue<T1>(value.Item1);
		writer.WriteValue<T2>(value.Item2);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref Tuple<T1?, T2?>? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		if (memberCount != 2)
		{
			MemoryPackSerializationException.ThrowInvalidPropertyCount(2, memberCount);
		}
		value = new Tuple<T1, T2>(reader.ReadValue<T1>(), reader.ReadValue<T2>());
	}
}
[Preserve]
public sealed class TupleFormatter<T1, T2, T3> : MemoryPackFormatter<Tuple<T1?, T2?, T3?>>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref Tuple<T1?, T2?, T3?>? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteObjectHeader(3);
		writer.WriteValue<T1>(value.Item1);
		writer.WriteValue<T2>(value.Item2);
		writer.WriteValue<T3>(value.Item3);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref Tuple<T1?, T2?, T3?>? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		if (memberCount != 3)
		{
			MemoryPackSerializationException.ThrowInvalidPropertyCount(3, memberCount);
		}
		value = new Tuple<T1, T2, T3>(reader.ReadValue<T1>(), reader.ReadValue<T2>(), reader.ReadValue<T3>());
	}
}
[Preserve]
public sealed class TupleFormatter<T1, T2, T3, T4> : MemoryPackFormatter<Tuple<T1?, T2?, T3?, T4?>>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref Tuple<T1?, T2?, T3?, T4?>? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteObjectHeader(4);
		writer.WriteValue<T1>(value.Item1);
		writer.WriteValue<T2>(value.Item2);
		writer.WriteValue<T3>(value.Item3);
		writer.WriteValue<T4>(value.Item4);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref Tuple<T1?, T2?, T3?, T4?>? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		if (memberCount != 4)
		{
			MemoryPackSerializationException.ThrowInvalidPropertyCount(4, memberCount);
		}
		value = new Tuple<T1, T2, T3, T4>(reader.ReadValue<T1>(), reader.ReadValue<T2>(), reader.ReadValue<T3>(), reader.ReadValue<T4>());
	}
}
[Preserve]
public sealed class TupleFormatter<T1, T2, T3, T4, T5> : MemoryPackFormatter<Tuple<T1?, T2?, T3?, T4?, T5?>>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref Tuple<T1?, T2?, T3?, T4?, T5?>? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteObjectHeader(5);
		writer.WriteValue<T1>(value.Item1);
		writer.WriteValue<T2>(value.Item2);
		writer.WriteValue<T3>(value.Item3);
		writer.WriteValue<T4>(value.Item4);
		writer.WriteValue<T5>(value.Item5);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref Tuple<T1?, T2?, T3?, T4?, T5?>? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		if (memberCount != 5)
		{
			MemoryPackSerializationException.ThrowInvalidPropertyCount(5, memberCount);
		}
		value = new Tuple<T1, T2, T3, T4, T5>(reader.ReadValue<T1>(), reader.ReadValue<T2>(), reader.ReadValue<T3>(), reader.ReadValue<T4>(), reader.ReadValue<T5>());
	}
}
[Preserve]
public sealed class TupleFormatter<T1, T2, T3, T4, T5, T6> : MemoryPackFormatter<Tuple<T1?, T2?, T3?, T4?, T5?, T6?>>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref Tuple<T1?, T2?, T3?, T4?, T5?, T6?>? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteObjectHeader(6);
		writer.WriteValue<T1>(value.Item1);
		writer.WriteValue<T2>(value.Item2);
		writer.WriteValue<T3>(value.Item3);
		writer.WriteValue<T4>(value.Item4);
		writer.WriteValue<T5>(value.Item5);
		writer.WriteValue<T6>(value.Item6);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref Tuple<T1?, T2?, T3?, T4?, T5?, T6?>? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		if (memberCount != 6)
		{
			MemoryPackSerializationException.ThrowInvalidPropertyCount(6, memberCount);
		}
		value = new Tuple<T1, T2, T3, T4, T5, T6>(reader.ReadValue<T1>(), reader.ReadValue<T2>(), reader.ReadValue<T3>(), reader.ReadValue<T4>(), reader.ReadValue<T5>(), reader.ReadValue<T6>());
	}
}
[Preserve]
public sealed class TupleFormatter<T1, T2, T3, T4, T5, T6, T7> : MemoryPackFormatter<Tuple<T1?, T2?, T3?, T4?, T5?, T6?, T7?>>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref Tuple<T1?, T2?, T3?, T4?, T5?, T6?, T7?>? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteObjectHeader(7);
		writer.WriteValue<T1>(value.Item1);
		writer.WriteValue<T2>(value.Item2);
		writer.WriteValue<T3>(value.Item3);
		writer.WriteValue<T4>(value.Item4);
		writer.WriteValue<T5>(value.Item5);
		writer.WriteValue<T6>(value.Item6);
		writer.WriteValue<T7>(value.Item7);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref Tuple<T1?, T2?, T3?, T4?, T5?, T6?, T7?>? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		if (memberCount != 7)
		{
			MemoryPackSerializationException.ThrowInvalidPropertyCount(7, memberCount);
		}
		value = new Tuple<T1, T2, T3, T4, T5, T6, T7>(reader.ReadValue<T1>(), reader.ReadValue<T2>(), reader.ReadValue<T3>(), reader.ReadValue<T4>(), reader.ReadValue<T5>(), reader.ReadValue<T6>(), reader.ReadValue<T7>());
	}
}
[Preserve]
public sealed class TupleFormatter<T1, T2, T3, T4, T5, T6, T7, TRest> : MemoryPackFormatter<Tuple<T1?, T2?, T3?, T4?, T5?, T6?, T7?, TRest>> where TRest : notnull
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref Tuple<T1?, T2?, T3?, T4?, T5?, T6?, T7?, TRest>? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteObjectHeader(8);
		writer.WriteValue<T1>(value.Item1);
		writer.WriteValue<T2>(value.Item2);
		writer.WriteValue<T3>(value.Item3);
		writer.WriteValue<T4>(value.Item4);
		writer.WriteValue<T5>(value.Item5);
		writer.WriteValue<T6>(value.Item6);
		writer.WriteValue<T7>(value.Item7);
		writer.WriteValue<TRest>(value.Rest);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref Tuple<T1?, T2?, T3?, T4?, T5?, T6?, T7?, TRest>? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		if (memberCount != 8)
		{
			MemoryPackSerializationException.ThrowInvalidPropertyCount(8, memberCount);
		}
		value = new Tuple<T1, T2, T3, T4, T5, T6, T7, TRest>(reader.ReadValue<T1>(), reader.ReadValue<T2>(), reader.ReadValue<T3>(), reader.ReadValue<T4>(), reader.ReadValue<T5>(), reader.ReadValue<T6>(), reader.ReadValue<T7>(), reader.ReadValue<TRest>());
	}
}
