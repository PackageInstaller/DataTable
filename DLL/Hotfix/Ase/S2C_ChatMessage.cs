using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10119)]
[MemoryPackable(GenerateType.Object)]
public class S2C_ChatMessage : MessageObject, IResponse, IMessage, IMemoryPackable<S2C_ChatMessage>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2C_ChatMessageFormatter : MemoryPackFormatter<S2C_ChatMessage>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2C_ChatMessage value)
		{
			S2C_ChatMessage.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2C_ChatMessage value)
		{
			S2C_ChatMessage.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public int Channel { get; set; }

	[MemoryPackOrder(1)]
	public string Content { get; set; }

	[MemoryPackOrder(2)]
	public bool SendSuccess { get; set; }

	[MemoryPackOrder(3)]
	public long NextCanSendTime { get; set; }

	[MemoryPackOrder(5)]
	public int EmojiId { get; set; }

	[MemoryPackOrder(6)]
	public PbChatShareInfo ShareInfo { get; set; }

	public static S2C_ChatMessage Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2C_ChatMessage)) as S2C_ChatMessage;
		}
		return new S2C_ChatMessage();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Channel = 0;
			Content = null;
			SendSuccess = false;
			NextCanSendTime = 0L;
			EmojiId = 0;
			ShareInfo = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2C_ChatMessage()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_ChatMessage>())
		{
			MemoryPackFormatterProvider.Register(new S2C_ChatMessageFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_ChatMessage[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2C_ChatMessage>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2C_ChatMessage? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(10, value.IsFromPool, value.Channel);
		writer.WriteString(value.Content);
		writer.WriteUnmanaged<bool, long, int>(value.SendSuccess, value.NextCanSendTime, value.EmojiId);
		writer.WritePackable<PbChatShareInfo>(value.ShareInfo);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2C_ChatMessage? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		bool value4;
		long value5;
		int value6;
		PbChatShareInfo value7;
		int value8;
		int value9;
		string content;
		string message;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Channel;
				content = value.Content;
				value4 = value.SendSuccess;
				value5 = value.NextCanSendTime;
				value6 = value.EmojiId;
				value7 = value.ShareInfo;
				value8 = value.RpcId;
				value9 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				content = reader.ReadString();
				reader.ReadUnmanaged<bool>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadPackable(ref value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				message = reader.ReadString();
				goto IL_0212;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			content = reader.ReadString();
			reader.ReadUnmanaged<bool, long, int>(out value4, out value5, out value6);
			value7 = reader.ReadPackable<PbChatShareInfo>();
			reader.ReadUnmanaged<int, int>(out value8, out value9);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2C_ChatMessage), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				content = null;
				value4 = false;
				value5 = 0L;
				value6 = 0;
				value7 = null;
				value8 = 0;
				value9 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Channel;
				content = value.Content;
				value4 = value.SendSuccess;
				value5 = value.NextCanSendTime;
				value6 = value.EmojiId;
				value7 = value.ShareInfo;
				value8 = value.RpcId;
				value9 = value.Error;
				message = value.Message;
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
							reader.ReadUnmanaged<bool>(out value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value5);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value6);
									if (memberCount != 6)
									{
										reader.ReadPackable(ref value7);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value8);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value9);
												if (memberCount != 9)
												{
													message = reader.ReadString();
													_ = 10;
												}
											}
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
				goto IL_0212;
			}
		}
		value = new S2C_ChatMessage
		{
			IsFromPool = value2,
			Channel = value3,
			Content = content,
			SendSuccess = value4,
			NextCanSendTime = value5,
			EmojiId = value6,
			ShareInfo = value7,
			RpcId = value8,
			Error = value9,
			Message = message
		};
		return;
		IL_0212:
		value.IsFromPool = value2;
		value.Channel = value3;
		value.Content = content;
		value.SendSuccess = value4;
		value.NextCanSendTime = value5;
		value.EmojiId = value6;
		value.ShareInfo = value7;
		value.RpcId = value8;
		value.Error = value9;
		value.Message = message;
	}
}
