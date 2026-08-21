using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10127)]
[MemoryPackable(GenerateType.Object)]
public class TaskChangeNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<TaskChangeNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class TaskChangeNotifyFormatter : MemoryPackFormatter<TaskChangeNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref TaskChangeNotify value)
		{
			TaskChangeNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref TaskChangeNotify value)
		{
			TaskChangeNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public List<PbTaskData> NewTask { get; set; } = new List<PbTaskData>();

	[MemoryPackOrder(1)]
	public List<PbTaskData> OldTask { get; set; } = new List<PbTaskData>();

	[MemoryPackOrder(2)]
	public int NewMaxCopyIdx { get; set; }

	public static TaskChangeNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(TaskChangeNotify)) as TaskChangeNotify;
		}
		return new TaskChangeNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			NewTask.Clear();
			OldTask.Clear();
			NewMaxCopyIdx = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static TaskChangeNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<TaskChangeNotify>())
		{
			MemoryPackFormatterProvider.Register(new TaskChangeNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<TaskChangeNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<TaskChangeNotify>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbTaskData>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbTaskData>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref TaskChangeNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		List<PbTaskData> source = value.NewTask;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source));
		source = value.OldTask;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source));
		writer.WriteUnmanaged<int, int, long>(value.NewMaxCopyIdx, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref TaskChangeNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbTaskData> value3;
		List<PbTaskData> value4;
		int value5;
		int value6;
		long value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.NewTask;
				value4 = value.OldTask;
				value5 = value.NewMaxCopyIdx;
				value6 = value.RpcId;
				value7 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0156;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbTaskData>(ref reader);
			value4 = ListFormatter.DeserializePackable<PbTaskData>(ref reader);
			reader.ReadUnmanaged<int, int, long>(out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(TaskChangeNotify), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = 0;
				value6 = 0;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.NewTask;
				value4 = value.OldTask;
				value5 = value.NewMaxCopyIdx;
				value6 = value.RpcId;
				value7 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
					if (memberCount != 2)
					{
						ListFormatter.DeserializePackable(ref reader, ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0156;
			}
		}
		value = new TaskChangeNotify
		{
			IsFromPool = value2,
			NewTask = value3,
			OldTask = value4,
			NewMaxCopyIdx = value5,
			RpcId = value6,
			ActorId = value7
		};
		return;
		IL_0156:
		value.IsFromPool = value2;
		value.NewTask = value3;
		value.OldTask = value4;
		value.NewMaxCopyIdx = value5;
		value.RpcId = value6;
		value.ActorId = value7;
	}
}
