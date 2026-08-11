using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10120)]
[MemoryPackable(GenerateType.Object)]
public class ChatMessageNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<ChatMessageNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class ChatMessageNotifyFormatter : MemoryPackFormatter<ChatMessageNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref ChatMessageNotify value)
		{
			ChatMessageNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref ChatMessageNotify value)
		{
			ChatMessageNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int Channel { get; set; }

	[MemoryPackOrder(1)]
	public string Content { get; set; }

	[MemoryPackOrder(2)]
	public PbChatUserInfo UserInfo { get; set; }

	[MemoryPackOrder(6)]
	public long SendUserId { get; set; }

	[MemoryPackOrder(4)]
	public int SubChannel { get; set; }

	[MemoryPackOrder(5)]
	public int EmojiId { get; set; }

	[MemoryPackOrder(6)]
	public PbChatShareInfo ShareInfo { get; set; }

	public static ChatMessageNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(ChatMessageNotify)) as ChatMessageNotify;
		}
		return new ChatMessageNotify();
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
			SendUserId = 0L;
			SubChannel = 0;
			EmojiId = 0;
			ShareInfo = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static ChatMessageNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<ChatMessageNotify>())
		{
			MemoryPackFormatterProvider.Register(new ChatMessageNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<ChatMessageNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<ChatMessageNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref ChatMessageNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(10, value.IsFromPool, value.Channel);
		writer.WriteString(value.Content);
		writer.WritePackable<PbChatUserInfo>(value.UserInfo);
		writer.WriteUnmanaged<int, int, long>(value.SubChannel, value.EmojiId, value.SendUserId);
		writer.WritePackable<PbChatShareInfo>(value.ShareInfo);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref ChatMessageNotify? value)
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
		long value7;
		PbChatShareInfo value8;
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
				value5 = value.SubChannel;
				value6 = value.EmojiId;
				value7 = value.SendUserId;
				value8 = value.ShareInfo;
				value9 = value.RpcId;
				value10 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				content = reader.ReadString();
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadPackable(ref value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<long>(out value10);
				goto IL_0213;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			content = reader.ReadString();
			value4 = reader.ReadPackable<PbChatUserInfo>();
			reader.ReadUnmanaged<int, int, long>(out value5, out value6, out value7);
			value8 = reader.ReadPackable<PbChatShareInfo>();
			reader.ReadUnmanaged<int, long>(out value9, out value10);
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(ChatMessageNotify), 10, memberCount);
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
				value7 = 0L;
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
				value5 = value.SubChannel;
				value6 = value.EmojiId;
				value7 = value.SendUserId;
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
										reader.ReadUnmanaged<long>(out value7);
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
				goto IL_0213;
			}
		}
		value = new ChatMessageNotify
		{
			IsFromPool = value2,
			Channel = value3,
			Content = content,
			UserInfo = value4,
			SubChannel = value5,
			EmojiId = value6,
			SendUserId = value7,
			ShareInfo = value8,
			RpcId = value9,
			ActorId = value10
		};
		return;
		IL_0213:
		value.IsFromPool = value2;
		value.Channel = value3;
		value.Content = content;
		value.UserInfo = value4;
		value.SubChannel = value5;
		value.EmojiId = value6;
		value.SendUserId = value7;
		value.ShareInfo = value8;
		value.RpcId = value9;
		value.ActorId = value10;
	}
}
