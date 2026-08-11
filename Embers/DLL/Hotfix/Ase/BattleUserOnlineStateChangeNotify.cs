using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10618)]
[MemoryPackable(GenerateType.Object)]
public class BattleUserOnlineStateChangeNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<BattleUserOnlineStateChangeNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class BattleUserOnlineStateChangeNotifyFormatter : MemoryPackFormatter<BattleUserOnlineStateChangeNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref BattleUserOnlineStateChangeNotify value)
		{
			BattleUserOnlineStateChangeNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref BattleUserOnlineStateChangeNotify value)
		{
			BattleUserOnlineStateChangeNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public long UserEntityActorId { get; set; }

	[MemoryPackOrder(2)]
	public bool Offline { get; set; }

	public static BattleUserOnlineStateChangeNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(BattleUserOnlineStateChangeNotify)) as BattleUserOnlineStateChangeNotify;
		}
		return new BattleUserOnlineStateChangeNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActorId = 0L;
			UserId = 0L;
			UserEntityActorId = 0L;
			Offline = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static BattleUserOnlineStateChangeNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<BattleUserOnlineStateChangeNotify>())
		{
			MemoryPackFormatterProvider.Register(new BattleUserOnlineStateChangeNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<BattleUserOnlineStateChangeNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<BattleUserOnlineStateChangeNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref BattleUserOnlineStateChangeNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, long, bool, long>(5, value.IsFromPool, value.UserId, value.UserEntityActorId, value.Offline, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref BattleUserOnlineStateChangeNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		bool value5;
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.UserEntityActorId;
				value5 = value.Offline;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<bool>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_011a;
			}
			reader.ReadUnmanaged<bool, long, long, bool, long>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(BattleUserOnlineStateChangeNotify), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = false;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.UserEntityActorId;
				value5 = value.Offline;
				value6 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<bool>(out value5);
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
				goto IL_011a;
			}
		}
		value = new BattleUserOnlineStateChangeNotify
		{
			IsFromPool = value2,
			UserId = value3,
			UserEntityActorId = value4,
			Offline = value5,
			ActorId = value6
		};
		return;
		IL_011a:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.UserEntityActorId = value4;
		value.Offline = value5;
		value.ActorId = value6;
	}
}
