using System;
using System.Runtime.CompilerServices;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class ValueTupleFormatter<T1> : MemoryPackFormatter<ValueTuple<T1?>>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref ValueTuple<T1?> value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<ValueTuple<T1>>())
		{
			writer.DangerousWriteUnmanaged(in value);
		}
		else
		{
			writer.WriteValue(in value.Item1);
		}
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref ValueTuple<T1?> value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<ValueTuple<T1>>())
		{
			reader.DangerousReadUnmanaged<ValueTuple<T1>>(out value);
		}
		else
		{
			value = new ValueTuple<T1>(reader.ReadValue<T1>());
		}
	}
}
[Preserve]
public sealed class ValueTupleFormatter<T1, T2> : MemoryPackFormatter<(T1?, T2?)>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref (T1?, T2?) value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<(T1, T2)>())
		{
			writer.DangerousWriteUnmanaged(in value);
			return;
		}
		writer.WriteValue(in value.Item1);
		writer.WriteValue(in value.Item2);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref (T1?, T2?) value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<(T1, T2)>())
		{
			reader.DangerousReadUnmanaged<(T1, T2)>(out value);
		}
		else
		{
			value = (reader.ReadValue<T1>(), reader.ReadValue<T2>());
		}
	}
}
[Preserve]
public sealed class ValueTupleFormatter<T1, T2, T3> : MemoryPackFormatter<(T1?, T2?, T3?)>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref (T1?, T2?, T3?) value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<(T1, T2, T3)>())
		{
			writer.DangerousWriteUnmanaged(in value);
			return;
		}
		writer.WriteValue(in value.Item1);
		writer.WriteValue(in value.Item2);
		writer.WriteValue(in value.Item3);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref (T1?, T2?, T3?) value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<(T1, T2, T3)>())
		{
			reader.DangerousReadUnmanaged<(T1, T2, T3)>(out value);
		}
		else
		{
			value = (reader.ReadValue<T1>(), reader.ReadValue<T2>(), reader.ReadValue<T3>());
		}
	}
}
[Preserve]
public sealed class ValueTupleFormatter<T1, T2, T3, T4> : MemoryPackFormatter<(T1?, T2?, T3?, T4?)>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref (T1?, T2?, T3?, T4?) value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<(T1, T2, T3, T4)>())
		{
			writer.DangerousWriteUnmanaged(in value);
			return;
		}
		writer.WriteValue(in value.Item1);
		writer.WriteValue(in value.Item2);
		writer.WriteValue(in value.Item3);
		writer.WriteValue(in value.Item4);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref (T1?, T2?, T3?, T4?) value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<(T1, T2, T3, T4)>())
		{
			reader.DangerousReadUnmanaged<(T1, T2, T3, T4)>(out value);
		}
		else
		{
			value = (reader.ReadValue<T1>(), reader.ReadValue<T2>(), reader.ReadValue<T3>(), reader.ReadValue<T4>());
		}
	}
}
[Preserve]
public sealed class ValueTupleFormatter<T1, T2, T3, T4, T5> : MemoryPackFormatter<(T1?, T2?, T3?, T4?, T5?)>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref (T1?, T2?, T3?, T4?, T5?) value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<(T1, T2, T3, T4, T5)>())
		{
			writer.DangerousWriteUnmanaged(in value);
			return;
		}
		writer.WriteValue(in value.Item1);
		writer.WriteValue(in value.Item2);
		writer.WriteValue(in value.Item3);
		writer.WriteValue(in value.Item4);
		writer.WriteValue(in value.Item5);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref (T1?, T2?, T3?, T4?, T5?) value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<(T1, T2, T3, T4, T5)>())
		{
			reader.DangerousReadUnmanaged<(T1, T2, T3, T4, T5)>(out value);
		}
		else
		{
			value = (reader.ReadValue<T1>(), reader.ReadValue<T2>(), reader.ReadValue<T3>(), reader.ReadValue<T4>(), reader.ReadValue<T5>());
		}
	}
}
[Preserve]
public sealed class ValueTupleFormatter<T1, T2, T3, T4, T5, T6> : MemoryPackFormatter<(T1?, T2?, T3?, T4?, T5?, T6?)>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref (T1?, T2?, T3?, T4?, T5?, T6?) value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<(T1, T2, T3, T4, T5, T6)>())
		{
			writer.DangerousWriteUnmanaged(in value);
			return;
		}
		writer.WriteValue(in value.Item1);
		writer.WriteValue(in value.Item2);
		writer.WriteValue(in value.Item3);
		writer.WriteValue(in value.Item4);
		writer.WriteValue(in value.Item5);
		writer.WriteValue(in value.Item6);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref (T1?, T2?, T3?, T4?, T5?, T6?) value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<(T1, T2, T3, T4, T5, T6)>())
		{
			reader.DangerousReadUnmanaged<(T1, T2, T3, T4, T5, T6)>(out value);
		}
		else
		{
			value = (reader.ReadValue<T1>(), reader.ReadValue<T2>(), reader.ReadValue<T3>(), reader.ReadValue<T4>(), reader.ReadValue<T5>(), reader.ReadValue<T6>());
		}
	}
}
[Preserve]
public sealed class ValueTupleFormatter<T1, T2, T3, T4, T5, T6, T7> : MemoryPackFormatter<(T1?, T2?, T3?, T4?, T5?, T6?, T7?)>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref (T1?, T2?, T3?, T4?, T5?, T6?, T7?) value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<(T1, T2, T3, T4, T5, T6, T7)>())
		{
			writer.DangerousWriteUnmanaged(in value);
			return;
		}
		writer.WriteValue(in value.Item1);
		writer.WriteValue(in value.Item2);
		writer.WriteValue(in value.Item3);
		writer.WriteValue(in value.Item4);
		writer.WriteValue(in value.Item5);
		writer.WriteValue(in value.Item6);
		writer.WriteValue(in value.Item7);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref (T1?, T2?, T3?, T4?, T5?, T6?, T7?) value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<(T1, T2, T3, T4, T5, T6, T7)>())
		{
			reader.DangerousReadUnmanaged<(T1, T2, T3, T4, T5, T6, T7)>(out value);
		}
		else
		{
			value = (reader.ReadValue<T1>(), reader.ReadValue<T2>(), reader.ReadValue<T3>(), reader.ReadValue<T4>(), reader.ReadValue<T5>(), reader.ReadValue<T6>(), reader.ReadValue<T7>());
		}
	}
}
[Preserve]
public sealed class ValueTupleFormatter<T1, T2, T3, T4, T5, T6, T7, TRest> : MemoryPackFormatter<ValueTuple<T1?, T2?, T3?, T4?, T5?, T6?, T7?, TRest>> where TRest : struct
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref ValueTuple<T1?, T2?, T3?, T4?, T5?, T6?, T7?, TRest> value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<ValueTuple<T1, T2, T3, T4, T5, T6, T7, TRest>>())
		{
			writer.DangerousWriteUnmanaged(in value);
			return;
		}
		writer.WriteValue(in value.Item1);
		writer.WriteValue(in value.Item2);
		writer.WriteValue(in value.Item3);
		writer.WriteValue(in value.Item4);
		writer.WriteValue(in value.Item5);
		writer.WriteValue(in value.Item6);
		writer.WriteValue(in value.Item7);
		writer.WriteValue(in value.Rest);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref ValueTuple<T1?, T2?, T3?, T4?, T5?, T6?, T7?, TRest> value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<ValueTuple<T1, T2, T3, T4, T5, T6, T7, TRest>>())
		{
			reader.DangerousReadUnmanaged<ValueTuple<T1, T2, T3, T4, T5, T6, T7, TRest>>(out value);
		}
		else
		{
			value = new ValueTuple<T1, T2, T3, T4, T5, T6, T7, TRest>(reader.ReadValue<T1>(), reader.ReadValue<T2>(), reader.ReadValue<T3>(), reader.ReadValue<T4>(), reader.ReadValue<T5>(), reader.ReadValue<T6>(), reader.ReadValue<T7>(), reader.ReadValue<TRest>());
		}
	}
}
