using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10118)]
[MemoryPackable(GenerateType.Object)]
public class C2S_ChatMessage : MessageObject, IRequest, IMessage, IMemoryPackable<C2S_ChatMessage>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2S_ChatMessageFormatter : MemoryPackFormatter<C2S_ChatMessage>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2S_ChatMessage value)
		{
			C2S_ChatMessage.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2S_ChatMessage value)
		{
			C2S_ChatMessage.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int Channel { get; set; }

	[MemoryPackOrder(1)]
	public string Content { get; set; }

	[MemoryPackOrder(2)]
	public PbChatUserInfo UserInfo { get; set; }

	[MemoryPackOrder(3)]
	public int RoomType { get; set; }

	[MemoryPackOrder(4)]
	public int SubChannel { get; set; }

	[MemoryPackOrder(5)]
	public int EmojiId { get; set; }

	[MemoryPackOrder(6)]
	public PbChatShareType ShareInfo { get; set; }

	public static C2S_ChatMessage Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2S_ChatMessage)) as C2S_ChatMessage;
		}
		return new C2S_ChatMessage();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			Channel = 0;
			Content = null;
			UserInfo = null;
			RoomType = 0;
			SubChannel = 0;
			EmojiId = 0;
			ShareInfo = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2S_ChatMessage()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2S_ChatMessage>())
		{
			MemoryPackFormatterProvider.Register(new C2S_ChatMessageFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2S_ChatMessage[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2S_ChatMessage>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2S_ChatMessage? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(10, value.IsFromPool, value.Channel);
		writer.WriteString(value.Content);
		writer.WritePackable<PbChatUserInfo>(value.UserInfo);
		writer.WriteUnmanaged<int, int, int>(value.RoomType, value.SubChannel, value.EmojiId);
		writer.WritePackable<PbChatShareType>(value.ShareInfo);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2S_ChatMessage? value)
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
		int value6;
		int value7;
		PbChatShareType value8;
		int value9;
		long value10;
		string content;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Channel;
				content = value.Content;
				value4 = value.UserInfo;
				value5 = value.RoomType;
				value6 = value.SubChannel;
				value7 = value.EmojiId;
				value8 = value.ShareInfo;
				value9 = value.RpcId;
				value10 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				content = reader.ReadString();
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadPackable(ref value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<long>(out value10);
				goto IL_0212;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			content = reader.ReadString();
			value4 = reader.ReadPackable<PbChatUserInfo>();
			reader.ReadUnmanaged<int, int, int>(out value5, out value6, out value7);
			value8 = reader.ReadPackable<PbChatShareType>();
			reader.ReadUnmanaged<int, long>(out value9, out value10);
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2S_ChatMessage), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				content = null;
				value4 = null;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				value8 = null;
				value9 = 0;
				value10 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Channel;
				content = value.Content;
				value4 = value.UserInfo;
				value5 = value.RoomType;
				value6 = value.SubChannel;
				value7 = value.EmojiId;
				value8 = value.ShareInfo;
				value9 = value.RpcId;
				value10 = value.ActorId;
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
									reader.ReadUnmanaged<int>(out value6);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value7);
										if (memberCount != 7)
										{
											reader.ReadPackable(ref value8);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value9);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<long>(out value10);
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
		value = new C2S_ChatMessage
		{
			IsFromPool = value2,
			Channel = value3,
			Content = content,
			UserInfo = value4,
			RoomType = value5,
			SubChannel = value6,
			EmojiId = value7,
			ShareInfo = value8,
			RpcId = value9,
			ActorId = value10
		};
		return;
		IL_0212:
		value.IsFromPool = value2;
		value.Channel = value3;
		value.Content = content;
		value.UserInfo = value4;
		value.RoomType = value5;
		value.SubChannel = value6;
		value.EmojiId = value7;
		value.ShareInfo = value8;
		value.RpcId = value9;
		value.ActorId = value10;
	}
}
