using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10067)]
[MemoryPackable(GenerateType.Object)]
public class UserLeaveBattleFieldNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<UserLeaveBattleFieldNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class UserLeaveBattleFieldNotifyFormatter : MemoryPackFormatter<UserLeaveBattleFieldNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref UserLeaveBattleFieldNotify value)
		{
			UserLeaveBattleFieldNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref UserLeaveBattleFieldNotify value)
		{
			UserLeaveBattleFieldNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int SeatId { get; set; }

	public static UserLeaveBattleFieldNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(UserLeaveBattleFieldNotify)) as UserLeaveBattleFieldNotify;
		}
		return new UserLeaveBattleFieldNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			SeatId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static UserLeaveBattleFieldNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<UserLeaveBattleFieldNotify>())
		{
			MemoryPackFormatterProvider.Register(new UserLeaveBattleFieldNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<UserLeaveBattleFieldNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<UserLeaveBattleFieldNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref UserLeaveBattleFieldNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, long>(4, value.IsFromPool, value.SeatId, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref UserLeaveBattleFieldNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		long value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.SeatId;
				value4 = value.RpcId;
				value5 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00ea;
			}
			reader.ReadUnmanaged<bool, int, int, long>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(UserLeaveBattleFieldNotify), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.SeatId;
				value4 = value.RpcId;
				value5 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
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
				goto IL_00ea;
			}
		}
		value = new UserLeaveBattleFieldNotify
		{
			IsFromPool = value2,
			SeatId = value3,
			RpcId = value4,
			ActorId = value5
		};
		return;
		IL_00ea:
		value.IsFromPool = value2;
		value.SeatId = value3;
		value.RpcId = value4;
		value.ActorId = value5;
	}
}
