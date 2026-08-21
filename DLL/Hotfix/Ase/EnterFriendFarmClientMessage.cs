using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(40571)]
[MemoryPackable(GenerateType.Object)]
public class EnterFriendFarmClientMessage : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<EnterFriendFarmClientMessage>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class EnterFriendFarmClientMessageFormatter : MemoryPackFormatter<EnterFriendFarmClientMessage>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref EnterFriendFarmClientMessage value)
		{
			EnterFriendFarmClientMessage.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref EnterFriendFarmClientMessage value)
		{
			EnterFriendFarmClientMessage.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long TargetUserId { get; set; }

	public static EnterFriendFarmClientMessage Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(EnterFriendFarmClientMessage)) as EnterFriendFarmClientMessage;
		}
		return new EnterFriendFarmClientMessage();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActorId = 0L;
			TargetUserId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static EnterFriendFarmClientMessage()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<EnterFriendFarmClientMessage>())
		{
			MemoryPackFormatterProvider.Register(new EnterFriendFarmClientMessageFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<EnterFriendFarmClientMessage[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<EnterFriendFarmClientMessage>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref EnterFriendFarmClientMessage? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, long>(3, value.IsFromPool, value.TargetUserId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref EnterFriendFarmClientMessage? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.TargetUserId;
				value4 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				goto IL_00c0;
			}
			reader.ReadUnmanaged<bool, long, long>(out value2, out value3, out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(EnterFriendFarmClientMessage), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.TargetUserId;
				value4 = value.ActorId;
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
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00c0;
			}
		}
		value = new EnterFriendFarmClientMessage
		{
			IsFromPool = value2,
			TargetUserId = value3,
			ActorId = value4
		};
		return;
		IL_00c0:
		value.IsFromPool = value2;
		value.TargetUserId = value3;
		value.ActorId = value4;
	}
}
