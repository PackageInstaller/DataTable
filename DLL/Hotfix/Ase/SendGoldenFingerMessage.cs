using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1050)]
[MemoryPackable(GenerateType.Object)]
public class SendGoldenFingerMessage : MessageObject, IActorLocationMessage, IActorRequest, IRequest, IMessage, IMemoryPackable<SendGoldenFingerMessage>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class SendGoldenFingerMessageFormatter : MemoryPackFormatter<SendGoldenFingerMessage>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref SendGoldenFingerMessage value)
		{
			SendGoldenFingerMessage.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref SendGoldenFingerMessage value)
		{
			SendGoldenFingerMessage.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public List<string> Commands { get; set; } = new List<string>();

	public static SendGoldenFingerMessage Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(SendGoldenFingerMessage)) as SendGoldenFingerMessage;
		}
		return new SendGoldenFingerMessage();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			Commands.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static SendGoldenFingerMessage()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<SendGoldenFingerMessage>())
		{
			MemoryPackFormatterProvider.Register(new SendGoldenFingerMessageFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<SendGoldenFingerMessage[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<SendGoldenFingerMessage>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<string>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<string>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref SendGoldenFingerMessage? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(5, value.IsFromPool, value.UserId);
		writer.WriteValue<List<string>>(value.Commands);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref SendGoldenFingerMessage? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		List<string> value4;
		int value5;
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.Commands;
				value5 = value.RpcId;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadValue(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0124;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			value4 = reader.ReadValue<List<string>>();
			reader.ReadUnmanaged<int, long>(out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(SendGoldenFingerMessage), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = null;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.Commands;
				value5 = value.RpcId;
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
						reader.ReadValue(ref value4);
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
				goto IL_0124;
			}
		}
		value = new SendGoldenFingerMessage
		{
			IsFromPool = value2,
			UserId = value3,
			Commands = value4,
			RpcId = value5,
			ActorId = value6
		};
		return;
		IL_0124:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.Commands = value4;
		value.RpcId = value5;
		value.ActorId = value6;
	}
}
