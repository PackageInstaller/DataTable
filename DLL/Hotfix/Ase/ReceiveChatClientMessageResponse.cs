using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1043)]
[MemoryPackable(GenerateType.Object)]
public class ReceiveChatClientMessageResponse : MessageObject, IResponse, IMessage, IMemoryPackable<ReceiveChatClientMessageResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class ReceiveChatClientMessageResponseFormatter : MemoryPackFormatter<ReceiveChatClientMessageResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref ReceiveChatClientMessageResponse value)
		{
			ReceiveChatClientMessageResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref ReceiveChatClientMessageResponse value)
		{
			ReceiveChatClientMessageResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(79)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public string Content { get; set; }

	public static ReceiveChatClientMessageResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(ReceiveChatClientMessageResponse)) as ReceiveChatClientMessageResponse;
		}
		return new ReceiveChatClientMessageResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			UserId = 0L;
			Content = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static ReceiveChatClientMessageResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<ReceiveChatClientMessageResponse>())
		{
			MemoryPackFormatterProvider.Register(new ReceiveChatClientMessageResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<ReceiveChatClientMessageResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<ReceiveChatClientMessageResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref ReceiveChatClientMessageResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		writer.WriteString(value.Content);
		writer.WriteUnmanaged<long, int, int>(value.UserId, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref ReceiveChatClientMessageResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		int value5;
		string content;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				content = value.Content;
				value3 = value.UserId;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				content = reader.ReadString();
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				message = reader.ReadString();
				goto IL_0155;
			}
			reader.ReadUnmanaged<bool>(out value2);
			content = reader.ReadString();
			reader.ReadUnmanaged<long, int, int>(out value3, out value4, out value5);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(ReceiveChatClientMessageResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				content = null;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				content = value.Content;
				value3 = value.UserId;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					content = reader.ReadString();
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value3);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								if (memberCount != 5)
								{
									message = reader.ReadString();
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0155;
			}
		}
		value = new ReceiveChatClientMessageResponse
		{
			IsFromPool = value2,
			Content = content,
			UserId = value3,
			RpcId = value4,
			Error = value5,
			Message = message
		};
		return;
		IL_0155:
		value.IsFromPool = value2;
		value.Content = content;
		value.UserId = value3;
		value.RpcId = value4;
		value.Error = value5;
		value.Message = message;
	}
}
