using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10783)]
[MemoryPackable(GenerateType.Object)]
public class ServerToClientMessage : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<ServerToClientMessage>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class ServerToClientMessageFormatter : MemoryPackFormatter<ServerToClientMessage>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref ServerToClientMessage value)
		{
			ServerToClientMessage.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref ServerToClientMessage value)
		{
			ServerToClientMessage.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int MessageId { get; set; }

	[MemoryPackOrder(1)]
	public string Message { get; set; }

	public static ServerToClientMessage Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(ServerToClientMessage)) as ServerToClientMessage;
		}
		return new ServerToClientMessage();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			MessageId = 0;
			Message = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static ServerToClientMessage()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<ServerToClientMessage>())
		{
			MemoryPackFormatterProvider.Register(new ServerToClientMessageFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<ServerToClientMessage[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<ServerToClientMessage>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref ServerToClientMessage? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(5, value.IsFromPool, value.MessageId);
		writer.WriteString(value.Message);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref ServerToClientMessage? value)
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
		string message;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.MessageId;
				message = value.Message;
				value4 = value.RpcId;
				value5 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				message = reader.ReadString();
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_0121;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			message = reader.ReadString();
			reader.ReadUnmanaged<int, long>(out value4, out value5);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(ServerToClientMessage), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				message = null;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.MessageId;
				message = value.Message;
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
						message = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value5);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0121;
			}
		}
		value = new ServerToClientMessage
		{
			IsFromPool = value2,
			MessageId = value3,
			Message = message,
			RpcId = value4,
			ActorId = value5
		};
		return;
		IL_0121:
		value.IsFromPool = value2;
		value.MessageId = value3;
		value.Message = message;
		value.RpcId = value4;
		value.ActorId = value5;
	}
}
