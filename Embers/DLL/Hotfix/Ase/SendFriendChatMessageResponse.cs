using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10210)]
[MemoryPackable(GenerateType.Object)]
public class SendFriendChatMessageResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<SendFriendChatMessageResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class SendFriendChatMessageResponseFormatter : MemoryPackFormatter<SendFriendChatMessageResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref SendFriendChatMessageResponse value)
		{
			SendFriendChatMessageResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref SendFriendChatMessageResponse value)
		{
			SendFriendChatMessageResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public string ChatMessage { get; set; }

	public static SendFriendChatMessageResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(SendFriendChatMessageResponse)) as SendFriendChatMessageResponse;
		}
		return new SendFriendChatMessageResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			ChatMessage = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static SendFriendChatMessageResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<SendFriendChatMessageResponse>())
		{
			MemoryPackFormatterProvider.Register(new SendFriendChatMessageResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<SendFriendChatMessageResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<SendFriendChatMessageResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref SendFriendChatMessageResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		writer.WriteString(value.ChatMessage);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref SendFriendChatMessageResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		string chatMessage;
		string message;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				chatMessage = value.ChatMessage;
				value3 = value.RpcId;
				value4 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				chatMessage = reader.ReadString();
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				message = reader.ReadString();
				goto IL_0129;
			}
			reader.ReadUnmanaged<bool>(out value2);
			chatMessage = reader.ReadString();
			reader.ReadUnmanaged<int, int>(out value3, out value4);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(SendFriendChatMessageResponse), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				chatMessage = null;
				value3 = 0;
				value4 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				chatMessage = value.ChatMessage;
				value3 = value.RpcId;
				value4 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					chatMessage = reader.ReadString();
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value3);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							if (memberCount != 4)
							{
								message = reader.ReadString();
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0129;
			}
		}
		value = new SendFriendChatMessageResponse
		{
			IsFromPool = value2,
			ChatMessage = chatMessage,
			RpcId = value3,
			Error = value4,
			Message = message
		};
		return;
		IL_0129:
		value.IsFromPool = value2;
		value.ChatMessage = chatMessage;
		value.RpcId = value3;
		value.Error = value4;
		value.Message = message;
	}
}
