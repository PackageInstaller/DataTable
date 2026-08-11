using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10022)]
[MemoryPackable(GenerateType.Object)]
public class M2C_UserReadyMessage : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<M2C_UserReadyMessage>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class M2C_UserReadyMessageFormatter : MemoryPackFormatter<M2C_UserReadyMessage>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref M2C_UserReadyMessage value)
		{
			M2C_UserReadyMessage.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref M2C_UserReadyMessage value)
		{
			M2C_UserReadyMessage.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int SeatId { get; set; }

	[MemoryPackOrder(1)]
	public int ReadyState { get; set; }

	[MemoryPackOrder(3)]
	public long PlayerId { get; set; }

	public static M2C_UserReadyMessage Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(M2C_UserReadyMessage)) as M2C_UserReadyMessage;
		}
		return new M2C_UserReadyMessage();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			SeatId = 0;
			ReadyState = 0;
			PlayerId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static M2C_UserReadyMessage()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<M2C_UserReadyMessage>())
		{
			MemoryPackFormatterProvider.Register(new M2C_UserReadyMessageFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<M2C_UserReadyMessage[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<M2C_UserReadyMessage>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref M2C_UserReadyMessage? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, long, int, long>(6, value.IsFromPool, value.SeatId, value.ReadyState, value.PlayerId, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref M2C_UserReadyMessage? value)
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
		int value6;
		long value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.SeatId;
				value4 = value.ReadyState;
				value5 = value.PlayerId;
				value6 = value.RpcId;
				value7 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0147;
			}
			reader.ReadUnmanaged<bool, int, int, long, int, long>(out value2, out value3, out value4, out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(M2C_UserReadyMessage), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0L;
				value6 = 0;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.SeatId;
				value4 = value.ReadyState;
				value5 = value.PlayerId;
				value6 = value.RpcId;
				value7 = value.ActorId;
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
				goto IL_0147;
			}
		}
		value = new M2C_UserReadyMessage
		{
			IsFromPool = value2,
			SeatId = value3,
			ReadyState = value4,
			PlayerId = value5,
			RpcId = value6,
			ActorId = value7
		};
		return;
		IL_0147:
		value.IsFromPool = value2;
		value.SeatId = value3;
		value.ReadyState = value4;
		value.PlayerId = value5;
		value.RpcId = value6;
		value.ActorId = value7;
	}
}
