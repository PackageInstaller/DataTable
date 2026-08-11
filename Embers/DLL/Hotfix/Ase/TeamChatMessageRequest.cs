using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1046)]
[MemoryPackable(GenerateType.Object)]
public class TeamChatMessageRequest : MessageObject, IRequest, IMessage, IMemoryPackable<TeamChatMessageRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class TeamChatMessageRequestFormatter : MemoryPackFormatter<TeamChatMessageRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref TeamChatMessageRequest value)
		{
			TeamChatMessageRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref TeamChatMessageRequest value)
		{
			TeamChatMessageRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(79)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public int Channel { get; set; }

	[MemoryPackOrder(1)]
	public string Content { get; set; }

	[MemoryPackOrder(2)]
	public PbChatUserInfo UserInfo { get; set; }

	[MemoryPackOrder(6)]
	public int RoomType { get; set; }

	public static TeamChatMessageRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(TeamChatMessageRequest)) as TeamChatMessageRequest;
		}
		return new TeamChatMessageRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			Channel = 0;
			Content = null;
			UserInfo = null;
			RoomType = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static TeamChatMessageRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<TeamChatMessageRequest>())
		{
			MemoryPackFormatterProvider.Register(new TeamChatMessageRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<TeamChatMessageRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<TeamChatMessageRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref TeamChatMessageRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(8, value.IsFromPool, value.Channel);
		writer.WriteString(value.Content);
		writer.WritePackable<PbChatUserInfo>(value.UserInfo);
		writer.WriteUnmanaged<int, long, int, long>(value.RoomType, value.UserId, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref TeamChatMessageRequest? value)
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
		int value7;
		long value8;
		string content;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Channel;
				content = value.Content;
				value4 = value.UserInfo;
				value5 = value.RoomType;
				value6 = value.UserId;
				value7 = value.RpcId;
				value8 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				content = reader.ReadString();
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				goto IL_01ac;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			content = reader.ReadString();
			value4 = reader.ReadPackable<PbChatUserInfo>();
			reader.ReadUnmanaged<int, long, int, long>(out value5, out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(TeamChatMessageRequest), 8, memberCount);
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
				value7 = 0;
				value8 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Channel;
				content = value.Content;
				value4 = value.UserInfo;
				value5 = value.RoomType;
				value6 = value.UserId;
				value7 = value.RpcId;
				value8 = value.ActorId;
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
				goto IL_01ac;
			}
		}
		value = new TeamChatMessageRequest
		{
			IsFromPool = value2,
			Channel = value3,
			Content = content,
			UserInfo = value4,
			RoomType = value5,
			UserId = value6,
			RpcId = value7,
			ActorId = value8
		};
		return;
		IL_01ac:
		value.IsFromPool = value2;
		value.Channel = value3;
		value.Content = content;
		value.UserInfo = value4;
		value.RoomType = value5;
		value.UserId = value6;
		value.RpcId = value7;
		value.ActorId = value8;
	}
}
