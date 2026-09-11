using System;
using System.Runtime.CompilerServices;

namespace MessagePack.Formatters;

public sealed class GenericEnumFormatter<T> : IMessagePackFormatter<T>, IMessagePackFormatter
{
	private delegate void EnumSerialize(ref MessagePackWriter writer, ref T value);

	private delegate T EnumDeserialize(ref MessagePackReader reader);

	private readonly EnumSerialize serializer;

	private readonly EnumDeserialize deserializer;

	public GenericEnumFormatter()
	{
		switch (Type.GetTypeCode(typeof(T).GetEnumUnderlyingType()))
		{
		case TypeCode.Byte:
			serializer = delegate(ref MessagePackWriter writer, ref T value)
			{
				writer.Write(Unsafe.As<T, byte>(ref value));
			};
			deserializer = delegate(ref MessagePackReader reader)
			{
				byte source = reader.ReadByte();
				return Unsafe.As<byte, T>(ref source);
			};
			break;
		case TypeCode.Int16:
			serializer = delegate(ref MessagePackWriter writer, ref T value)
			{
				writer.Write(Unsafe.As<T, short>(ref value));
			};
			deserializer = delegate(ref MessagePackReader reader)
			{
				short source = reader.ReadInt16();
				return Unsafe.As<short, T>(ref source);
			};
			break;
		case TypeCode.Int32:
			serializer = delegate(ref MessagePackWriter writer, ref T value)
			{
				writer.Write(Unsafe.As<T, int>(ref value));
			};
			deserializer = delegate(ref MessagePackReader reader)
			{
				int source = reader.ReadInt32();
				return Unsafe.As<int, T>(ref source);
			};
			break;
		case TypeCode.Int64:
			serializer = delegate(ref MessagePackWriter writer, ref T value)
			{
				writer.Write(Unsafe.As<T, long>(ref value));
			};
			deserializer = delegate(ref MessagePackReader reader)
			{
				long source = reader.ReadInt64();
				return Unsafe.As<long, T>(ref source);
			};
			break;
		case TypeCode.SByte:
			serializer = delegate(ref MessagePackWriter writer, ref T value)
			{
				writer.Write(Unsafe.As<T, sbyte>(ref value));
			};
			deserializer = delegate(ref MessagePackReader reader)
			{
				sbyte source = reader.ReadSByte();
				return Unsafe.As<sbyte, T>(ref source);
			};
			break;
		case TypeCode.UInt16:
			serializer = delegate(ref MessagePackWriter writer, ref T value)
			{
				writer.Write(Unsafe.As<T, ushort>(ref value));
			};
			deserializer = delegate(ref MessagePackReader reader)
			{
				ushort source = reader.ReadUInt16();
				return Unsafe.As<ushort, T>(ref source);
			};
			break;
		case TypeCode.UInt32:
			serializer = delegate(ref MessagePackWriter writer, ref T value)
			{
				writer.Write(Unsafe.As<T, uint>(ref value));
			};
			deserializer = delegate(ref MessagePackReader reader)
			{
				uint source = reader.ReadUInt32();
				return Unsafe.As<uint, T>(ref source);
			};
			break;
		case TypeCode.UInt64:
			serializer = delegate(ref MessagePackWriter writer, ref T value)
			{
				writer.Write(Unsafe.As<T, ulong>(ref value));
			};
			deserializer = delegate(ref MessagePackReader reader)
			{
				ulong source = reader.ReadUInt64();
				return Unsafe.As<ulong, T>(ref source);
			};
			break;
		}
	}

	public void Serialize(ref MessagePackWriter writer, T value, MessagePackSerializerOptions options)
	{
		serializer(ref writer, ref value);
	}

	public T Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return deserializer(ref reader);
	}
}
