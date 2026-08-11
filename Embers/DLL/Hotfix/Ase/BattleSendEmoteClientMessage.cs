using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10747)]
[MemoryPackable(GenerateType.Object)]
public class BattleSendEmoteClientMessage : MessageObject, IActorNotification, INotification, IMessage, IMemoryPackable<BattleSendEmoteClientMessage>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class BattleSendEmoteClientMessageFormatter : MemoryPackFormatter<BattleSendEmoteClientMessage>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref BattleSendEmoteClientMessage value)
		{
			BattleSendEmoteClientMessage.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref BattleSendEmoteClientMessage value)
		{
			BattleSendEmoteClientMessage.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(88)]
	public long ActorId { get; set; }

	[MemoryPackOrder(89)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public long BattleActorId { get; set; }

	[MemoryPackOrder(1)]
	public int Index { get; set; }

	public static BattleSendEmoteClientMessage Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(BattleSendEmoteClientMessage)) as BattleSendEmoteClientMessage;
		}
		return new BattleSendEmoteClientMessage();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			ActorId = 0L;
			UserId = 0L;
			BattleActorId = 0L;
			Index = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static BattleSendEmoteClientMessage()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<BattleSendEmoteClientMessage>())
		{
			MemoryPackFormatterProvider.Register(new BattleSendEmoteClientMessageFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<BattleSendEmoteClientMessage[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<BattleSendEmoteClientMessage>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref BattleSendEmoteClientMessage? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int, int, long, long, long>(7, value.IsFromPool, value.BattleActorId, value.Index, value.LoginServerId, value.LoginSecretKey, value.ActorId, value.UserId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref BattleSendEmoteClientMessage? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		int value5;
		long value6;
		long value7;
		long value8;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.BattleActorId;
				value4 = value.Index;
				value5 = value.LoginServerId;
				value6 = value.LoginSecretKey;
				value7 = value.ActorId;
				value8 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				goto IL_0174;
			}
			reader.ReadUnmanaged<bool, long, int, int, long, long, long>(out value2, out value3, out value4, out value5, out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(BattleSendEmoteClientMessage), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				value6 = 0L;
				value7 = 0L;
				value8 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.BattleActorId;
				value4 = value.Index;
				value5 = value.LoginServerId;
				value6 = value.LoginSecretKey;
				value7 = value.ActorId;
				value8 = value.UserId;
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
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value8);
										_ = 7;
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0174;
			}
		}
		value = new BattleSendEmoteClientMessage
		{
			IsFromPool = value2,
			BattleActorId = value3,
			Index = value4,
			LoginServerId = value5,
			LoginSecretKey = value6,
			ActorId = value7,
			UserId = value8
		};
		return;
		IL_0174:
		value.IsFromPool = value2;
		value.BattleActorId = value3;
		value.Index = value4;
		value.LoginServerId = value5;
		value.LoginSecretKey = value6;
		value.ActorId = value7;
		value.UserId = value8;
	}
}
