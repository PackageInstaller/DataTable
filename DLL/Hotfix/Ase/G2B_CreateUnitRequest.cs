using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1031)]
[MemoryPackable(GenerateType.Object)]
public class G2B_CreateUnitRequest : MessageObject, IRequest, IMessage, IMemoryPackable<G2B_CreateUnitRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class G2B_CreateUnitRequestFormatter : MemoryPackFormatter<G2B_CreateUnitRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref G2B_CreateUnitRequest value)
		{
			G2B_CreateUnitRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref G2B_CreateUnitRequest value)
		{
			G2B_CreateUnitRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public long GateSessionId { get; set; }

	public static G2B_CreateUnitRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(G2B_CreateUnitRequest)) as G2B_CreateUnitRequest;
		}
		return new G2B_CreateUnitRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			GateSessionId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static G2B_CreateUnitRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<G2B_CreateUnitRequest>())
		{
			MemoryPackFormatterProvider.Register(new G2B_CreateUnitRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<G2B_CreateUnitRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<G2B_CreateUnitRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref G2B_CreateUnitRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, long, int>(4, value.IsFromPool, value.UserId, value.GateSessionId, value.RpcId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref G2B_CreateUnitRequest? value)
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
				value3 = value.UserId;
				value4 = value.GateSessionId;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(G2B_CreateUnitRequest), 4, memberCount);
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
				value3 = value.UserId;
				value4 = value.GateSessionId;
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
		value = new G2B_CreateUnitRequest
		{
			IsFromPool = value2,
			UserId = value3,
			GateSessionId = value4,
			RpcId = value5
		};
		return;
		IL_00eb:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.GateSessionId = value4;
		value.RpcId = value5;
	}
}
