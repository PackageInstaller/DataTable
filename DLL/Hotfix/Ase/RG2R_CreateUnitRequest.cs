using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1027)]
[MemoryPackable(GenerateType.Object)]
public class RG2R_CreateUnitRequest : MessageObject, IRequest, IMessage, IMemoryPackable<RG2R_CreateUnitRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class RG2R_CreateUnitRequestFormatter : MemoryPackFormatter<RG2R_CreateUnitRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref RG2R_CreateUnitRequest value)
		{
			RG2R_CreateUnitRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref RG2R_CreateUnitRequest value)
		{
			RG2R_CreateUnitRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public long GateSessionId { get; set; }

	[MemoryPackOrder(2)]
	public long RoomId { get; set; }

	public static RG2R_CreateUnitRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(RG2R_CreateUnitRequest)) as RG2R_CreateUnitRequest;
		}
		return new RG2R_CreateUnitRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			GateSessionId = 0L;
			RoomId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static RG2R_CreateUnitRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<RG2R_CreateUnitRequest>())
		{
			MemoryPackFormatterProvider.Register(new RG2R_CreateUnitRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<RG2R_CreateUnitRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<RG2R_CreateUnitRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref RG2R_CreateUnitRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, long, long, int>(5, value.IsFromPool, value.UserId, value.GateSessionId, value.RoomId, value.RpcId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref RG2R_CreateUnitRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		long value5;
		int value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.GateSessionId;
				value5 = value.RoomId;
				value6 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				goto IL_011a;
			}
			reader.ReadUnmanaged<bool, long, long, long, int>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(RG2R_CreateUnitRequest), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = 0L;
				value6 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.GateSessionId;
				value5 = value.RoomId;
				value6 = value.RpcId;
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
							reader.ReadUnmanaged<long>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
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
		value = new RG2R_CreateUnitRequest
		{
			IsFromPool = value2,
			UserId = value3,
			GateSessionId = value4,
			RoomId = value5,
			RpcId = value6
		};
		return;
		IL_011a:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.GateSessionId = value4;
		value.RoomId = value5;
		value.RpcId = value6;
	}
}
