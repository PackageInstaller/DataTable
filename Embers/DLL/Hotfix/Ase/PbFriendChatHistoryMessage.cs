using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(337)]
[MemoryPackable(GenerateType.Object)]
public class PbFriendChatHistoryMessage : MessageObject, IMemoryPackable<PbFriendChatHistoryMessage>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbFriendChatHistoryMessageFormatter : MemoryPackFormatter<PbFriendChatHistoryMessage>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbFriendChatHistoryMessage value)
		{
			PbFriendChatHistoryMessage.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbFriendChatHistoryMessage value)
		{
			PbFriendChatHistoryMessage.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public List<PbFriendChatMessage> UnreadMessage { get; set; } = new List<PbFriendChatMessage>();

	public static PbFriendChatHistoryMessage Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbFriendChatHistoryMessage)) as PbFriendChatHistoryMessage;
		}
		return new PbFriendChatHistoryMessage();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			UserId = 0L;
			UnreadMessage.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbFriendChatHistoryMessage()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbFriendChatHistoryMessage>())
		{
			MemoryPackFormatterProvider.Register(new PbFriendChatHistoryMessageFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbFriendChatHistoryMessage[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbFriendChatHistoryMessage>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbFriendChatMessage>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbFriendChatMessage>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbFriendChatHistoryMessage? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(3, value.IsFromPool, value.UserId);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbFriendChatMessage>>(value.UnreadMessage));
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbFriendChatHistoryMessage? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		List<PbFriendChatMessage> value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.UnreadMessage;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				goto IL_00c4;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<PbFriendChatMessage>(ref reader);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbFriendChatHistoryMessage), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.UnreadMessage;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						ListFormatter.DeserializePackable(ref reader, ref value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00c4;
			}
		}
		value = new PbFriendChatHistoryMessage
		{
			IsFromPool = value2,
			UserId = value3,
			UnreadMessage = value4
		};
		return;
		IL_00c4:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.UnreadMessage = value4;
	}
}
