using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1048)]
[MemoryPackable(GenerateType.Object)]
public class InnerTeamChatMessageRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerTeamChatMessageRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerTeamChatMessageRequestFormatter : MemoryPackFormatter<InnerTeamChatMessageRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerTeamChatMessageRequest value)
		{
			InnerTeamChatMessageRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerTeamChatMessageRequest value)
		{
			InnerTeamChatMessageRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public int RoomType { get; set; }

	[MemoryPackOrder(1)]
	public TeamChatMessageRequest message { get; set; }

	public static InnerTeamChatMessageRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerTeamChatMessageRequest)) as InnerTeamChatMessageRequest;
		}
		return new InnerTeamChatMessageRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			RoomType = 0;
			message = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerTeamChatMessageRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerTeamChatMessageRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerTeamChatMessageRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerTeamChatMessageRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerTeamChatMessageRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerTeamChatMessageRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(4, value.IsFromPool, value.RoomType);
		writer.WritePackable<TeamChatMessageRequest>(value.message);
		writer.WriteUnmanaged<int>(value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerTeamChatMessageRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		TeamChatMessageRequest value4;
		int value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoomType;
				value4 = value.message;
				value5 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				goto IL_00f4;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = reader.ReadPackable<TeamChatMessageRequest>();
			reader.ReadUnmanaged<int>(out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerTeamChatMessageRequest), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoomType;
				value4 = value.message;
				value5 = value.RpcId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadPackable(ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f4;
			}
		}
		value = new InnerTeamChatMessageRequest
		{
			IsFromPool = value2,
			RoomType = value3,
			message = value4,
			RpcId = value5
		};
		return;
		IL_00f4:
		value.IsFromPool = value2;
		value.RoomType = value3;
		value.message = value4;
		value.RpcId = value5;
	}
}
