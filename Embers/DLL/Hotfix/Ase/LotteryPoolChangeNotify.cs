using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10753)]
[MemoryPackable(GenerateType.Object)]
public class LotteryPoolChangeNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<LotteryPoolChangeNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class LotteryPoolChangeNotifyFormatter : MemoryPackFormatter<LotteryPoolChangeNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref LotteryPoolChangeNotify value)
		{
			LotteryPoolChangeNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref LotteryPoolChangeNotify value)
		{
			LotteryPoolChangeNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int PoolId { get; set; }

	[MemoryPackOrder(1)]
	public bool Delete { get; set; }

	public static LotteryPoolChangeNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(LotteryPoolChangeNotify)) as LotteryPoolChangeNotify;
		}
		return new LotteryPoolChangeNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			PoolId = 0;
			Delete = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static LotteryPoolChangeNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<LotteryPoolChangeNotify>())
		{
			MemoryPackFormatterProvider.Register(new LotteryPoolChangeNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<LotteryPoolChangeNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<LotteryPoolChangeNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref LotteryPoolChangeNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, bool, int, long>(5, value.IsFromPool, value.PoolId, value.Delete, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref LotteryPoolChangeNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		bool value4;
		int value5;
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.PoolId;
				value4 = value.Delete;
				value5 = value.RpcId;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<bool>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0118;
			}
			reader.ReadUnmanaged<bool, int, bool, int, long>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(LotteryPoolChangeNotify), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = false;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.PoolId;
				value4 = value.Delete;
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
						reader.ReadUnmanaged<bool>(out value4);
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
				goto IL_0118;
			}
		}
		value = new LotteryPoolChangeNotify
		{
			IsFromPool = value2,
			PoolId = value3,
			Delete = value4,
			RpcId = value5,
			ActorId = value6
		};
		return;
		IL_0118:
		value.IsFromPool = value2;
		value.PoolId = value3;
		value.Delete = value4;
		value.RpcId = value5;
		value.ActorId = value6;
	}
}
