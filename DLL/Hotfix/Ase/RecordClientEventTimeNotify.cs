using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10546)]
[MemoryPackable(GenerateType.Object)]
public class RecordClientEventTimeNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<RecordClientEventTimeNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class RecordClientEventTimeNotifyFormatter : MemoryPackFormatter<RecordClientEventTimeNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref RecordClientEventTimeNotify value)
		{
			RecordClientEventTimeNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref RecordClientEventTimeNotify value)
		{
			RecordClientEventTimeNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(88)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public List<PbEventRecordTime> EventTimes { get; set; } = new List<PbEventRecordTime>();

	public static RecordClientEventTimeNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(RecordClientEventTimeNotify)) as RecordClientEventTimeNotify;
		}
		return new RecordClientEventTimeNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActorId = 0L;
			EventTimes.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static RecordClientEventTimeNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<RecordClientEventTimeNotify>())
		{
			MemoryPackFormatterProvider.Register(new RecordClientEventTimeNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<RecordClientEventTimeNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<RecordClientEventTimeNotify>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbEventRecordTime>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbEventRecordTime>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref RecordClientEventTimeNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(3, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbEventRecordTime>>(value.EventTimes));
		writer.WriteUnmanaged<long>(value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref RecordClientEventTimeNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbEventRecordTime> value3;
		long value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.EventTimes;
				value4 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<long>(out value4);
				goto IL_00ca;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbEventRecordTime>(ref reader);
			reader.ReadUnmanaged<long>(out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(RecordClientEventTimeNotify), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.EventTimes;
				value4 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00ca;
			}
		}
		value = new RecordClientEventTimeNotify
		{
			IsFromPool = value2,
			EventTimes = value3,
			ActorId = value4
		};
		return;
		IL_00ca:
		value.IsFromPool = value2;
		value.EventTimes = value3;
		value.ActorId = value4;
	}
}
