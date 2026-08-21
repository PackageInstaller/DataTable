using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(338)]
[MemoryPackable(GenerateType.Object)]
public class PbFriendChatMessage : MessageObject, IMemoryPackable<PbFriendChatMessage>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbFriendChatMessageFormatter : MemoryPackFormatter<PbFriendChatMessage>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbFriendChatMessage value)
		{
			PbFriendChatMessage.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbFriendChatMessage value)
		{
			PbFriendChatMessage.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public string ChatMessage { get; set; }

	[MemoryPackOrder(1)]
	public long SendTime { get; set; }

	[MemoryPackOrder(2)]
	public PbChatShareInfo ShareInfo { get; set; }

	[MemoryPackOrder(3)]
	public int Bubble { get; set; }

	public static PbFriendChatMessage Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbFriendChatMessage)) as PbFriendChatMessage;
		}
		return new PbFriendChatMessage();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ChatMessage = null;
			SendTime = 0L;
			ShareInfo = null;
			Bubble = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbFriendChatMessage()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbFriendChatMessage>())
		{
			MemoryPackFormatterProvider.Register(new PbFriendChatMessageFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbFriendChatMessage[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbFriendChatMessage>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbFriendChatMessage? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		writer.WriteString(value.ChatMessage);
		writer.WriteUnmanaged<long>(value.SendTime);
		writer.WritePackable<PbChatShareInfo>(value.ShareInfo);
		writer.WriteUnmanaged<int>(value.Bubble);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbFriendChatMessage? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		PbChatShareInfo value4;
		int value5;
		string chatMessage;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				chatMessage = value.ChatMessage;
				value3 = value.SendTime;
				value4 = value.ShareInfo;
				value5 = value.Bubble;
				reader.ReadUnmanaged<bool>(out value2);
				chatMessage = reader.ReadString();
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				goto IL_0130;
			}
			reader.ReadUnmanaged<bool>(out value2);
			chatMessage = reader.ReadString();
			reader.ReadUnmanaged<long>(out value3);
			value4 = reader.ReadPackable<PbChatShareInfo>();
			reader.ReadUnmanaged<int>(out value5);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbFriendChatMessage), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				chatMessage = null;
				value3 = 0L;
				value4 = null;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				chatMessage = value.ChatMessage;
				value3 = value.SendTime;
				value4 = value.ShareInfo;
				value5 = value.Bubble;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					chatMessage = reader.ReadString();
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value3);
						if (memberCount != 3)
						{
							reader.ReadPackable(ref value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0130;
			}
		}
		value = new PbFriendChatMessage
		{
			IsFromPool = value2,
			ChatMessage = chatMessage,
			SendTime = value3,
			ShareInfo = value4,
			Bubble = value5
		};
		return;
		IL_0130:
		value.IsFromPool = value2;
		value.ChatMessage = chatMessage;
		value.SendTime = value3;
		value.ShareInfo = value4;
		value.Bubble = value5;
	}
}
