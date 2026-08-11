using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1003)]
[MemoryPackable(GenerateType.Object)]
public class G2G_LockRequest : MessageObject, IRequest, IMessage, IMemoryPackable<G2G_LockRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class G2G_LockRequestFormatter : MemoryPackFormatter<G2G_LockRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref G2G_LockRequest value)
		{
			G2G_LockRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref G2G_LockRequest value)
		{
			G2G_LockRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long Id { get; set; }

	[MemoryPackOrder(1)]
	public string Address { get; set; }

	public static G2G_LockRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(G2G_LockRequest)) as G2G_LockRequest;
		}
		return new G2G_LockRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Id = 0L;
			Address = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static G2G_LockRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<G2G_LockRequest>())
		{
			MemoryPackFormatterProvider.Register(new G2G_LockRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<G2G_LockRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<G2G_LockRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref G2G_LockRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(4, value.IsFromPool, value.Id);
		writer.WriteString(value.Address);
		writer.WriteUnmanaged<int>(value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref G2G_LockRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		string address;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				address = value.Address;
				value4 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				address = reader.ReadString();
				reader.ReadUnmanaged<int>(out value4);
				goto IL_00f3;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			address = reader.ReadString();
			reader.ReadUnmanaged<int>(out value4);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(G2G_LockRequest), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				address = null;
				value4 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				address = value.Address;
				value4 = value.RpcId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						address = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f3;
			}
		}
		value = new G2G_LockRequest
		{
			IsFromPool = value2,
			Id = value3,
			Address = address,
			RpcId = value4
		};
		return;
		IL_00f3:
		value.IsFromPool = value2;
		value.Id = value3;
		value.Address = address;
		value.RpcId = value4;
	}
}
