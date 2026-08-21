using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10896)]
[MemoryPackable(GenerateType.Object)]
public class HomeComeTaskUpdateNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<HomeComeTaskUpdateNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class HomeComeTaskUpdateNotifyFormatter : MemoryPackFormatter<HomeComeTaskUpdateNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref HomeComeTaskUpdateNotify value)
		{
			HomeComeTaskUpdateNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref HomeComeTaskUpdateNotify value)
		{
			HomeComeTaskUpdateNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public List<PbHomeComeTaskProgress> TaskProgress { get; set; } = new List<PbHomeComeTaskProgress>();

	public static HomeComeTaskUpdateNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(HomeComeTaskUpdateNotify)) as HomeComeTaskUpdateNotify;
		}
		return new HomeComeTaskUpdateNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			TaskProgress.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static HomeComeTaskUpdateNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<HomeComeTaskUpdateNotify>())
		{
			MemoryPackFormatterProvider.Register(new HomeComeTaskUpdateNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<HomeComeTaskUpdateNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<HomeComeTaskUpdateNotify>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbHomeComeTaskProgress>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbHomeComeTaskProgress>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref HomeComeTaskUpdateNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(4, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbHomeComeTaskProgress>>(value.TaskProgress));
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref HomeComeTaskUpdateNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbHomeComeTaskProgress> value3;
		int value4;
		long value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.TaskProgress;
				value4 = value.RpcId;
				value5 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00f5;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbHomeComeTaskProgress>(ref reader);
			reader.ReadUnmanaged<int, long>(out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(HomeComeTaskUpdateNotify), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.TaskProgress;
				value4 = value.RpcId;
				value5 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f5;
			}
		}
		value = new HomeComeTaskUpdateNotify
		{
			IsFromPool = value2,
			TaskProgress = value3,
			RpcId = value4,
			ActorId = value5
		};
		return;
		IL_00f5:
		value.IsFromPool = value2;
		value.TaskProgress = value3;
		value.RpcId = value4;
		value.ActorId = value5;
	}
}
