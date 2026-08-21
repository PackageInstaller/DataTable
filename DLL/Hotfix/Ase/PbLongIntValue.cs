using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(400)]
[MemoryPackable(GenerateType.Object)]
public class PbLongIntValue : MessageObject, IMemoryPackable<PbLongIntValue>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbLongIntValueFormatter : MemoryPackFormatter<PbLongIntValue>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbLongIntValue value)
		{
			PbLongIntValue.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbLongIntValue value)
		{
			PbLongIntValue.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long Id { get; set; }

	[MemoryPackOrder(1)]
	public int Value { get; set; }

	public static PbLongIntValue Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbLongIntValue)) as PbLongIntValue;
		}
		return new PbLongIntValue();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Id = 0L;
			Value = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbLongIntValue()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbLongIntValue>())
		{
			MemoryPackFormatterProvider.Register(new PbLongIntValueFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbLongIntValue[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbLongIntValue>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbLongIntValue? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int>(3, value.IsFromPool, value.Id, value.Value);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbLongIntValue? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Value;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				goto IL_00bf;
			}
			reader.ReadUnmanaged<bool, long, int>(out value2, out value3, out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbLongIntValue), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Value;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00bf;
			}
		}
		value = new PbLongIntValue
		{
			IsFromPool = value2,
			Id = value3,
			Value = value4
		};
		return;
		IL_00bf:
		value.IsFromPool = value2;
		value.Id = value3;
		value.Value = value4;
	}
}
