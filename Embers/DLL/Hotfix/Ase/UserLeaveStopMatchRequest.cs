using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1056)]
[MemoryPackable(GenerateType.Object)]
public class UserLeaveStopMatchRequest : MessageObject, IRequest, IMessage, IMemoryPackable<UserLeaveStopMatchRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class UserLeaveStopMatchRequestFormatter : MemoryPackFormatter<UserLeaveStopMatchRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref UserLeaveStopMatchRequest value)
		{
			UserLeaveStopMatchRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref UserLeaveStopMatchRequest value)
		{
			UserLeaveStopMatchRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long RoomId { get; set; }

	[MemoryPackOrder(1)]
	public long UserId { get; set; }

	public static UserLeaveStopMatchRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(UserLeaveStopMatchRequest)) as UserLeaveStopMatchRequest;
		}
		return new UserLeaveStopMatchRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			RoomId = 0L;
			UserId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static UserLeaveStopMatchRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<UserLeaveStopMatchRequest>())
		{
			MemoryPackFormatterProvider.Register(new UserLeaveStopMatchRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<UserLeaveStopMatchRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<UserLeaveStopMatchRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref UserLeaveStopMatchRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, long, int>(4, value.IsFromPool, value.RoomId, value.UserId, value.RpcId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref UserLeaveStopMatchRequest? value)
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
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoomId;
				value4 = value.UserId;
				value5 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				goto IL_00eb;
			}
			reader.ReadUnmanaged<bool, long, long, int>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(UserLeaveStopMatchRequest), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoomId;
				value4 = value.UserId;
				value5 = value.RpcId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
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
				goto IL_00eb;
			}
		}
		value = new UserLeaveStopMatchRequest
		{
			IsFromPool = value2,
			RoomId = value3,
			UserId = value4,
			RpcId = value5
		};
		return;
		IL_00eb:
		value.IsFromPool = value2;
		value.RoomId = value3;
		value.UserId = value4;
		value.RpcId = value5;
	}
}
