using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1042)]
[MemoryPackable(GenerateType.Object)]
public class ReceiveChatClientMessageRequest : MessageObject, IRequest, IMessage, IMemoryPackable<ReceiveChatClientMessageRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class ReceiveChatClientMessageRequestFormatter : MemoryPackFormatter<ReceiveChatClientMessageRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref ReceiveChatClientMessageRequest value)
		{
			ReceiveChatClientMessageRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref ReceiveChatClientMessageRequest value)
		{
			ReceiveChatClientMessageRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(79)]
	public long UserId { get; set; }

	[MemoryPackOrder(69)]
	public int AreaId { get; set; }

	[MemoryPackOrder(70)]
	public long TeamId { get; set; }

	[MemoryPackOrder(0)]
	public int Channel { get; set; }

	[MemoryPackOrder(1)]
	public string Content { get; set; }

	[MemoryPackOrder(2)]
	public PbChatUserInfo UserInfo { get; set; }

	public static ReceiveChatClientMessageRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(ReceiveChatClientMessageRequest)) as ReceiveChatClientMessageRequest;
		}
		return new ReceiveChatClientMessageRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			AreaId = 0;
			TeamId = 0L;
			Channel = 0;
			Content = null;
			UserInfo = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static ReceiveChatClientMessageRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<ReceiveChatClientMessageRequest>())
		{
			MemoryPackFormatterProvider.Register(new ReceiveChatClientMessageRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<ReceiveChatClientMessageRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<ReceiveChatClientMessageRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref ReceiveChatClientMessageRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(8, value.IsFromPool, value.Channel);
		writer.WriteString(value.Content);
		writer.WritePackable<PbChatUserInfo>(value.UserInfo);
		writer.WriteUnmanaged<int, long, long, int>(value.AreaId, value.TeamId, value.UserId, value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref ReceiveChatClientMessageRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		PbChatUserInfo value4;
		int value5;
		long value6;
		long value7;
		int value8;
		string content;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Channel;
				content = value.Content;
				value4 = value.UserInfo;
				value5 = value.AreaId;
				value6 = value.TeamId;
				value7 = value.UserId;
				value8 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				content = reader.ReadString();
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				goto IL_01ac;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			content = reader.ReadString();
			value4 = reader.ReadPackable<PbChatUserInfo>();
			reader.ReadUnmanaged<int, long, long, int>(out value5, out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(ReceiveChatClientMessageRequest), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				content = null;
				value4 = null;
				value5 = 0;
				value6 = 0L;
				value7 = 0L;
				value8 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Channel;
				content = value.Content;
				value4 = value.UserInfo;
				value5 = value.AreaId;
				value6 = value.TeamId;
				value7 = value.UserId;
				value8 = value.RpcId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						content = reader.ReadString();
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
										reader.ReadUnmanaged<long>(out value7);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value8);
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
				goto IL_01ac;
			}
		}
		value = new ReceiveChatClientMessageRequest
		{
			IsFromPool = value2,
			Channel = value3,
			Content = content,
			UserInfo = value4,
			AreaId = value5,
			TeamId = value6,
			UserId = value7,
			RpcId = value8
		};
		return;
		IL_01ac:
		value.IsFromPool = value2;
		value.Channel = value3;
		value.Content = content;
		value.UserInfo = value4;
		value.AreaId = value5;
		value.TeamId = value6;
		value.UserId = value7;
		value.RpcId = value8;
	}
}
