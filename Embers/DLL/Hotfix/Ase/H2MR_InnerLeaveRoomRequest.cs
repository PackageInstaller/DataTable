using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10016)]
[MemoryPackable(GenerateType.Object)]
public class H2MR_InnerLeaveRoomRequest : MessageObject, IRequest, IMessage, IMemoryPackable<H2MR_InnerLeaveRoomRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2MR_InnerLeaveRoomRequestFormatter : MemoryPackFormatter<H2MR_InnerLeaveRoomRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2MR_InnerLeaveRoomRequest value)
		{
			H2MR_InnerLeaveRoomRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2MR_InnerLeaveRoomRequest value)
		{
			H2MR_InnerLeaveRoomRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	public static H2MR_InnerLeaveRoomRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2MR_InnerLeaveRoomRequest)) as H2MR_InnerLeaveRoomRequest;
		}
		return new H2MR_InnerLeaveRoomRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2MR_InnerLeaveRoomRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2MR_InnerLeaveRoomRequest>())
		{
			MemoryPackFormatterProvider.Register(new H2MR_InnerLeaveRoomRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2MR_InnerLeaveRoomRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2MR_InnerLeaveRoomRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2MR_InnerLeaveRoomRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int, long>(4, value.IsFromPool, value.UserId, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2MR_InnerLeaveRoomRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		long value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RpcId;
				value5 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00eb;
			}
			reader.ReadUnmanaged<bool, long, int, long>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2MR_InnerLeaveRoomRequest), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RpcId;
				value5 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00eb;
			}
		}
		value = new H2MR_InnerLeaveRoomRequest
		{
			IsFromPool = value2,
			UserId = value3,
			RpcId = value4,
			ActorId = value5
		};
		return;
		IL_00eb:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.RpcId = value4;
		value.ActorId = value5;
	}
}
