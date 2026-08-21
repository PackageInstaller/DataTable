using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10211)]
[MemoryPackable(GenerateType.Object)]
public class FriendChatMessageNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<FriendChatMessageNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class FriendChatMessageNotifyFormatter : MemoryPackFormatter<FriendChatMessageNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref FriendChatMessageNotify value)
		{
			FriendChatMessageNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref FriendChatMessageNotify value)
		{
			FriendChatMessageNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public string ChatMessage { get; set; }

	[MemoryPackOrder(2)]
	public long SendTime { get; set; }

	[MemoryPackOrder(3)]
	public int Bubble { get; set; }

	[MemoryPackOrder(4)]
	public PbChatShareInfo ShareInfo { get; set; }

	public static FriendChatMessageNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(FriendChatMessageNotify)) as FriendChatMessageNotify;
		}
		return new FriendChatMessageNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			ChatMessage = null;
			SendTime = 0L;
			Bubble = 0;
			ShareInfo = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static FriendChatMessageNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<FriendChatMessageNotify>())
		{
			MemoryPackFormatterProvider.Register(new FriendChatMessageNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<FriendChatMessageNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<FriendChatMessageNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref FriendChatMessageNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(8, value.IsFromPool, value.UserId);
		writer.WriteString(value.ChatMessage);
		writer.WriteUnmanaged<long, int>(value.SendTime, value.Bubble);
		writer.WritePackable<PbChatShareInfo>(value.ShareInfo);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref FriendChatMessageNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		int value5;
		PbChatShareInfo value6;
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
				value4 = value.SendTime;
				value5 = value.Bubble;
				value6 = value.ShareInfo;
				value7 = value.RpcId;
				value8 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				chatMessage = reader.ReadString();
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadPackable(ref value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				goto IL_01b3;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			chatMessage = reader.ReadString();
			reader.ReadUnmanaged<long, int>(out value4, out value5);
			value6 = reader.ReadPackable<PbChatShareInfo>();
			reader.ReadUnmanaged<int, long>(out value7, out value8);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(FriendChatMessageNotify), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				chatMessage = null;
				value4 = 0L;
				value5 = 0;
				value6 = null;
				value7 = 0;
				value8 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				chatMessage = value.ChatMessage;
				value4 = value.SendTime;
				value5 = value.Bubble;
				value6 = value.ShareInfo;
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
							reader.ReadUnmanaged<long>(out value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								if (memberCount != 5)
								{
									reader.ReadPackable(ref value6);
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
				goto IL_01b3;
			}
		}
		value = new FriendChatMessageNotify
		{
			IsFromPool = value2,
			UserId = value3,
			ChatMessage = chatMessage,
			SendTime = value4,
			Bubble = value5,
			ShareInfo = value6,
			RpcId = value7,
			ActorId = value8
		};
		return;
		IL_01b3:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.ChatMessage = chatMessage;
		value.SendTime = value4;
		value.Bubble = value5;
		value.ShareInfo = value6;
		value.RpcId = value7;
		value.ActorId = value8;
	}
}
