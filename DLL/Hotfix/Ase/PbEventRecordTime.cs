using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(357)]
[MemoryPackable(GenerateType.Object)]
public class PbEventRecordTime : MessageObject, IMemoryPackable<PbEventRecordTime>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbEventRecordTimeFormatter : MemoryPackFormatter<PbEventRecordTime>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbEventRecordTime value)
		{
			PbEventRecordTime.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbEventRecordTime value)
		{
			PbEventRecordTime.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int EventType { get; set; }

	[MemoryPackOrder(1)]
	public long Time { get; set; }

	public static PbEventRecordTime Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbEventRecordTime)) as PbEventRecordTime;
		}
		return new PbEventRecordTime();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			EventType = 0;
			Time = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbEventRecordTime()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbEventRecordTime>())
		{
			MemoryPackFormatterProvider.Register(new PbEventRecordTimeFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbEventRecordTime[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbEventRecordTime>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbEventRecordTime? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, long>(3, value.IsFromPool, value.EventType, value.Time);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbEventRecordTime? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.EventType;
				value4 = value.Time;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				goto IL_00bf;
			}
			reader.ReadUnmanaged<bool, int, long>(out value2, out value3, out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbEventRecordTime), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.EventType;
				value4 = value.Time;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00bf;
			}
		}
		value = new PbEventRecordTime
		{
			IsFromPool = value2,
			EventType = value3,
			Time = value4
		};
		return;
		IL_00bf:
		value.IsFromPool = value2;
		value.EventType = value3;
		value.Time = value4;
	}
}
