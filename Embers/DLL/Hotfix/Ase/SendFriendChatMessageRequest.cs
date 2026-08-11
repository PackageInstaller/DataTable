using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10209)]
[MemoryPackable(GenerateType.Object)]
public class SendFriendChatMessageRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<SendFriendChatMessageRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class SendFriendChatMessageRequestFormatter : MemoryPackFormatter<SendFriendChatMessageRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref SendFriendChatMessageRequest value)
		{
			SendFriendChatMessageRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref SendFriendChatMessageRequest value)
		{
			SendFriendChatMessageRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public string ChatMessage { get; set; }

	[MemoryPackOrder(2)]
	public PbChatShareType ShareInfo { get; set; }

	public static SendFriendChatMessageRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(SendFriendChatMessageRequest)) as SendFriendChatMessageRequest;
		}
		return new SendFriendChatMessageRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			ChatMessage = null;
			ShareInfo = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static SendFriendChatMessageRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<SendFriendChatMessageRequest>())
		{
			MemoryPackFormatterProvider.Register(new SendFriendChatMessageRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<SendFriendChatMessageRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<SendFriendChatMessageRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref SendFriendChatMessageRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(8, value.IsFromPool, value.UserId);
		writer.WriteString(value.ChatMessage);
		writer.WritePackable<PbChatShareType>(value.ShareInfo);
		writer.WriteUnmanaged<int, long, int, long>(value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref SendFriendChatMessageRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		PbChatShareType value4;
		int value5;
		long value6;
		int value7;
		long value8;
		string chatMessage;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				chatMessage = value.ChatMessage;
				value4 = value.ShareInfo;
				value5 = value.LoginServerId;
				value6 = value.LoginSecretKey;
				value7 = value.RpcId;
				value8 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				chatMessage = reader.ReadString();
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				goto IL_01ad;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			chatMessage = reader.ReadString();
			value4 = reader.ReadPackable<PbChatShareType>();
			reader.ReadUnmanaged<int, long, int, long>(out value5, out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(SendFriendChatMessageRequest), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				chatMessage = null;
				value4 = null;
				value5 = 0;
				value6 = 0L;
				value7 = 0;
				value8 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				chatMessage = value.ChatMessage;
				value4 = value.ShareInfo;
				value5 = value.LoginServerId;
				value6 = value.LoginSecretKey;
				value7 = value.RpcId;
				value8 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						chatMessage = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadPackable(ref value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value6);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value7);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value8);
											_ = 8;
										}
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_01ad;
			}
		}
		value = new SendFriendChatMessageRequest
		{
			IsFromPool = value2,
			UserId = value3,
			ChatMessage = chatMessage,
			ShareInfo = value4,
			LoginServerId = value5,
			LoginSecretKey = value6,
			RpcId = value7,
			ActorId = value8
		};
		return;
		IL_01ad:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.ChatMessage = chatMessage;
		value.ShareInfo = value4;
		value.LoginServerId = value5;
		value.LoginSecretKey = value6;
		value.RpcId = value7;
		value.ActorId = value8;
	}
}
