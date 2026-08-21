using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10607)]
[MemoryPackable(GenerateType.Object)]
public class SendOpenHuoWenHuiLuClientMessage : MessageObject, IActorNotification, INotification, IMessage, IMemoryPackable<SendOpenHuoWenHuiLuClientMessage>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class SendOpenHuoWenHuiLuClientMessageFormatter : MemoryPackFormatter<SendOpenHuoWenHuiLuClientMessage>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref SendOpenHuoWenHuiLuClientMessage value)
		{
			SendOpenHuoWenHuiLuClientMessage.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref SendOpenHuoWenHuiLuClientMessage value)
		{
			SendOpenHuoWenHuiLuClientMessage.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	public static SendOpenHuoWenHuiLuClientMessage Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(SendOpenHuoWenHuiLuClientMessage)) as SendOpenHuoWenHuiLuClientMessage;
		}
		return new SendOpenHuoWenHuiLuClientMessage();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			ActorId = 0L;
			UserId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static SendOpenHuoWenHuiLuClientMessage()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<SendOpenHuoWenHuiLuClientMessage>())
		{
			MemoryPackFormatterProvider.Register(new SendOpenHuoWenHuiLuClientMessageFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<SendOpenHuoWenHuiLuClientMessage[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<SendOpenHuoWenHuiLuClientMessage>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref SendOpenHuoWenHuiLuClientMessage? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int, long, long>(5, value.IsFromPool, value.UserId, value.LoginServerId, value.LoginSecretKey, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref SendOpenHuoWenHuiLuClientMessage? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		long value5;
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_011a;
			}
			reader.ReadUnmanaged<bool, long, int, long, long>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(SendOpenHuoWenHuiLuClientMessage), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0L;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
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
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
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
		value = new SendOpenHuoWenHuiLuClientMessage
		{
			IsFromPool = value2,
			UserId = value3,
			LoginServerId = value4,
			LoginSecretKey = value5,
			ActorId = value6
		};
		return;
		IL_011a:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.LoginServerId = value4;
		value.LoginSecretKey = value5;
		value.ActorId = value6;
	}
}
