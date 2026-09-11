using System;
using System.Buffers;
using System.Runtime.InteropServices;
using MessagePack.Formatters;

namespace MessagePack.Unity.Extension;

public abstract class UnsafeBlitFormatterBase<T> : IMessagePackFormatter<T[]>, IMessagePackFormatter where T : struct
{
	protected abstract sbyte TypeCode { get; }

	protected void CopyDeserializeUnsafe(ReadOnlySpan<byte> src, Span<T> dest)
	{
		src.CopyTo(MemoryMarshal.Cast<T, byte>(dest));
	}

	public void Serialize(ref MessagePackWriter writer, T[] value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		int num = value.Length * Marshal.SizeOf<T>();
		writer.WriteExtensionFormatHeader(new ExtensionHeader(TypeCode, num));
		writer.Write(num);
		writer.Write(BitConverter.IsLittleEndian);
		writer.WriteRaw(MemoryMarshal.Cast<T, byte>((Span<T>)value));
	}

	public T[] Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		if (reader.ReadExtensionFormatHeader().TypeCode != TypeCode)
		{
			throw new InvalidOperationException("Invalid typeCode.");
		}
		int num = reader.ReadInt32();
		bool num2 = reader.ReadBoolean();
		T[] array = new T[num / Marshal.SizeOf<T>()];
		Span<byte> destination = MemoryMarshal.Cast<T, byte>((Span<T>)array);
		reader.ReadRaw(num).CopyTo(destination);
		if (num2 != BitConverter.IsLittleEndian)
		{
			int num3 = 0;
			int num4 = destination.Length - 1;
			while (num3 < num4)
			{
				byte b = destination[num3];
				destination[num3] = destination[num4];
				destination[num4] = b;
				num3++;
				num4--;
			}
		}
		return array;
	}
}
