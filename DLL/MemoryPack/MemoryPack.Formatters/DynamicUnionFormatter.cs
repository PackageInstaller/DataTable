using System;
using System.Collections.Generic;
using System.Linq;

namespace MemoryPack.Formatters;

public sealed class DynamicUnionFormatter<T> : MemoryPackFormatter<T> where T : class
{
	private readonly Dictionary<Type, ushort> typeToTag;

	private readonly Dictionary<ushort, Type> tagToType;

	public DynamicUnionFormatter(params (ushort Tag, Type Type)[] memoryPackUnions)
	{
		typeToTag = memoryPackUnions.ToDictionary(((ushort Tag, Type Type) x) => x.Type, ((ushort Tag, Type Type) x) => x.Tag);
		tagToType = memoryPackUnions.ToDictionary(((ushort Tag, Type Type) x) => x.Tag, ((ushort Tag, Type Type) x) => x.Type);
	}

	public override void Serialize(ref MemoryPackWriter writer, ref T? value)
	{
		if (value == null)
		{
			writer.WriteNullUnionHeader();
			return;
		}
		Type type = value.GetType();
		if (typeToTag.TryGetValue(type, out var value2))
		{
			writer.WriteUnionHeader(value2);
			writer.WriteValue(type, value);
		}
		else
		{
			MemoryPackSerializationException.ThrowNotFoundInUnionType(type, typeof(T));
		}
	}

	public override void Deserialize(ref MemoryPackReader reader, ref T? value)
	{
		Type value2;
		if (!reader.TryReadUnionHeader(out var tag))
		{
			value = null;
		}
		else if (tagToType.TryGetValue(tag, out value2))
		{
			object value3 = value;
			reader.ReadValue(value2, ref value3);
			value = (T)value3;
		}
		else
		{
			MemoryPackSerializationException.ThrowInvalidTag(tag, typeof(T));
		}
	}
}
