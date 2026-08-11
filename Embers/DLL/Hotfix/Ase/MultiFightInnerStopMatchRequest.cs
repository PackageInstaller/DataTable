using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10458)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightInnerStopMatchRequest : MessageObject, IRequest, IMessage, IMemoryPackable<MultiFightInnerStopMatchRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightInnerStopMatchRequestFormatter : MemoryPackFormatter<MultiFightInnerStopMatchRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightInnerStopMatchRequest value)
		{
			MultiFightInnerStopMatchRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightInnerStopMatchRequest value)
		{
			MultiFightInnerStopMatchRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long RoomId { get; set; }

	[MemoryPackOrder(1)]
	public long UserId { get; set; }

	public static MultiFightInnerStopMatchRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightInnerStopMatchRequest)) as MultiFightInnerStopMatchRequest;
		}
		return new MultiFightInnerStopMatchRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			RoomId = 0L;
			UserId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightInnerStopMatchRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightInnerStopMatchRequest>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightInnerStopMatchRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightInnerStopMatchRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightInnerStopMatchRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightInnerStopMatchRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, long, int, long>(5, value.IsFromPool, value.RoomId, value.UserId, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightInnerStopMatchRequest? value)
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
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoomId;
				value4 = value.UserId;
				value5 = value.RpcId;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_011a;
			}
			reader.ReadUnmanaged<bool, long, long, int, long>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightInnerStopMatchRequest), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoomId;
				value4 = value.UserId;
				value5 = value.RpcId;
				value6 = value.ActorId;
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
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_011a;
			}
		}
		value = new MultiFightInnerStopMatchRequest
		{
			IsFromPool = value2,
			RoomId = value3,
			UserId = value4,
			RpcId = value5,
			ActorId = value6
		};
		return;
		IL_011a:
		value.IsFromPool = value2;
		value.RoomId = value3;
		value.UserId = value4;
		value.RpcId = value5;
		value.ActorId = value6;
	}
}
