using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10695)]
[MemoryPackable(GenerateType.Object)]
public class UnionTaskCompleteNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<UnionTaskCompleteNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class UnionTaskCompleteNotifyFormatter : MemoryPackFormatter<UnionTaskCompleteNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref UnionTaskCompleteNotify value)
		{
			UnionTaskCompleteNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref UnionTaskCompleteNotify value)
		{
			UnionTaskCompleteNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int TaskId { get; set; }

	[MemoryPackOrder(1)]
	public PbDropThing Rewards { get; set; }

	public static UnionTaskCompleteNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(UnionTaskCompleteNotify)) as UnionTaskCompleteNotify;
		}
		return new UnionTaskCompleteNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			TaskId = 0;
			Rewards = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static UnionTaskCompleteNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<UnionTaskCompleteNotify>())
		{
			MemoryPackFormatterProvider.Register(new UnionTaskCompleteNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<UnionTaskCompleteNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<UnionTaskCompleteNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref UnionTaskCompleteNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(5, value.IsFromPool, value.TaskId);
		writer.WritePackable<PbDropThing>(value.Rewards);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref UnionTaskCompleteNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		PbDropThing value4;
		int value5;
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.TaskId;
				value4 = value.Rewards;
				value5 = value.RpcId;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0123;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = reader.ReadPackable<PbDropThing>();
			reader.ReadUnmanaged<int, long>(out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(UnionTaskCompleteNotify), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.TaskId;
				value4 = value.Rewards;
				value5 = value.RpcId;
				value6 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadPackable(ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0123;
			}
		}
		value = new UnionTaskCompleteNotify
		{
			IsFromPool = value2,
			TaskId = value3,
			Rewards = value4,
			RpcId = value5,
			ActorId = value6
		};
		return;
		IL_0123:
		value.IsFromPool = value2;
		value.TaskId = value3;
		value.Rewards = value4;
		value.RpcId = value5;
		value.ActorId = value6;
	}
}
