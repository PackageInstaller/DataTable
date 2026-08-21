using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1053)]
[MemoryPackable(GenerateType.Object)]
public class ServerUserNotifyMessage : MessageObject, IRequest, IMessage, IMemoryPackable<ServerUserNotifyMessage>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class ServerUserNotifyMessageFormatter : MemoryPackFormatter<ServerUserNotifyMessage>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref ServerUserNotifyMessage value)
		{
			ServerUserNotifyMessage.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref ServerUserNotifyMessage value)
		{
			ServerUserNotifyMessage.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public int MessageOpcode { get; set; }

	[MemoryPackOrder(2)]
	public byte[] MessageBytes { get; set; }

	public static ServerUserNotifyMessage Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(ServerUserNotifyMessage)) as ServerUserNotifyMessage;
		}
		return new ServerUserNotifyMessage();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			MessageOpcode = 0;
			MessageBytes = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static ServerUserNotifyMessage()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<ServerUserNotifyMessage>())
		{
			MemoryPackFormatterProvider.Register(new ServerUserNotifyMessageFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<ServerUserNotifyMessage[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<ServerUserNotifyMessage>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<byte[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<byte>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref ServerUserNotifyMessage? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, int>(6, value.IsFromPool, value.UserId, value.MessageOpcode);
		writer.WriteUnmanagedArray(value.MessageBytes);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref ServerUserNotifyMessage? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		byte[] value5;
		int value6;
		long value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.MessageOpcode;
				value5 = value.MessageBytes;
				value6 = value.RpcId;
				value7 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanagedArray(ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0153;
			}
			reader.ReadUnmanaged<bool, long, int>(out value2, out value3, out value4);
			value5 = reader.ReadUnmanagedArray<byte>();
			reader.ReadUnmanaged<int, long>(out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(ServerUserNotifyMessage), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = null;
				value6 = 0;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.MessageOpcode;
				value5 = value.MessageBytes;
				value6 = value.RpcId;
				value7 = value.ActorId;
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
							reader.ReadUnmanagedArray(ref value5);
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
				goto IL_0153;
			}
		}
		value = new ServerUserNotifyMessage
		{
			IsFromPool = value2,
			UserId = value3,
			MessageOpcode = value4,
			MessageBytes = value5,
			RpcId = value6,
			ActorId = value7
		};
		return;
		IL_0153:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.MessageOpcode = value4;
		value.MessageBytes = value5;
		value.RpcId = value6;
		value.ActorId = value7;
	}
}
