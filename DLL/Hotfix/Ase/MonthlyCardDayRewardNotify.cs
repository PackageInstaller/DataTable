using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10729)]
[MemoryPackable(GenerateType.Object)]
public class MonthlyCardDayRewardNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<MonthlyCardDayRewardNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MonthlyCardDayRewardNotifyFormatter : MemoryPackFormatter<MonthlyCardDayRewardNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MonthlyCardDayRewardNotify value)
		{
			MonthlyCardDayRewardNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MonthlyCardDayRewardNotify value)
		{
			MonthlyCardDayRewardNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public PbDropThing Rewards { get; set; }

	public static MonthlyCardDayRewardNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MonthlyCardDayRewardNotify)) as MonthlyCardDayRewardNotify;
		}
		return new MonthlyCardDayRewardNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			Rewards = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MonthlyCardDayRewardNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MonthlyCardDayRewardNotify>())
		{
			MemoryPackFormatterProvider.Register(new MonthlyCardDayRewardNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MonthlyCardDayRewardNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MonthlyCardDayRewardNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MonthlyCardDayRewardNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(4, value.IsFromPool);
		writer.WritePackable<PbDropThing>(value.Rewards);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MonthlyCardDayRewardNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbDropThing value3;
		int value4;
		long value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Rewards;
				value4 = value.RpcId;
				value5 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00f5;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbDropThing>();
			reader.ReadUnmanaged<int, long>(out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MonthlyCardDayRewardNotify), 4, memberCount);
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
				value3 = value.Rewards;
				value4 = value.RpcId;
				value5 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadPackable(ref value3);
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
		value = new MonthlyCardDayRewardNotify
		{
			IsFromPool = value2,
			Rewards = value3,
			RpcId = value4,
			ActorId = value5
		};
		return;
		IL_00f5:
		value.IsFromPool = value2;
		value.Rewards = value3;
		value.RpcId = value4;
		value.ActorId = value5;
	}
}
