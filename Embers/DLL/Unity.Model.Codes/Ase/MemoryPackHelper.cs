using System;
using System.Buffers;
using System.ComponentModel;
using MemoryPack;

namespace Ase;

public static class MemoryPackHelper
{
	public static byte[] Serialize(object message)
	{
		return MemoryPackSerializer.Serialize(message.GetType(), message);
	}

	public static void Serialize(object message, MemoryBuffer stream)
	{
		Type type = message.GetType();
		IBufferWriter<byte> bufferWriter = stream;
		MemoryPackSerializer.Serialize(type, in bufferWriter, message);
	}

	public static object Deserialize(Type type, byte[] bytes, int index, int count)
	{
		object? obj = MemoryPackSerializer.Deserialize(type, bytes.AsSpan(index, count));
		if (obj is ISupportInitialize supportInitialize)
		{
			supportInitialize.EndInit();
		}
		return obj;
	}

	public static object Deserialize(Type type, byte[] bytes, int index, int count, ref object o)
	{
		MemoryPackSerializer.Deserialize(type, bytes.AsSpan(index, count), ref o);
		if (o is ISupportInitialize supportInitialize)
		{
			supportInitialize.EndInit();
		}
		return o;
	}

	public static object Deserialize(Type type, MemoryBuffer stream)
	{
		object? obj = MemoryPackSerializer.Deserialize(type, stream.GetSpan());
		if (obj is ISupportInitialize supportInitialize)
		{
			supportInitialize.EndInit();
		}
		return obj;
	}

	public static object Deserialize(Type type, MemoryBuffer stream, ref object o)
	{
		MemoryPackSerializer.Deserialize(type, stream.GetSpan(), ref o);
		if (o is ISupportInitialize supportInitialize)
		{
			supportInitialize.EndInit();
		}
		return o;
	}
}
