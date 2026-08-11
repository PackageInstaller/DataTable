using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1013)]
[MemoryPackable(GenerateType.Object)]
public class ObjectUnLockRequest : MessageObject, IRequest, IMessage, IMemoryPackable<ObjectUnLockRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class ObjectUnLockRequestFormatter : MemoryPackFormatter<ObjectUnLockRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref ObjectUnLockRequest value)
		{
			ObjectUnLockRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref ObjectUnLockRequest value)
		{
			ObjectUnLockRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long Key { get; set; }

	[MemoryPackOrder(1)]
	public long OldInstanceId { get; set; }

	[MemoryPackOrder(2)]
	public long InstanceId { get; set; }

	public static ObjectUnLockRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(ObjectUnLockRequest)) as ObjectUnLockRequest;
		}
		return new ObjectUnLockRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Key = 0L;
			OldInstanceId = 0L;
			InstanceId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static ObjectUnLockRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<ObjectUnLockRequest>())
		{
			MemoryPackFormatterProvider.Register(new ObjectUnLockRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<ObjectUnLockRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<ObjectUnLockRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref ObjectUnLockRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, long, long, int>(5, value.IsFromPool, value.Key, value.OldInstanceId, value.InstanceId, value.RpcId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref ObjectUnLockRequest? value)
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
				value3 = value.Key;
				value4 = value.OldInstanceId;
				value5 = value.InstanceId;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(ObjectUnLockRequest), 5, memberCount);
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
				value3 = value.Key;
				value4 = value.OldInstanceId;
				value5 = value.InstanceId;
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
		value = new ObjectUnLockRequest
		{
			IsFromPool = value2,
			Key = value3,
			OldInstanceId = value4,
			InstanceId = value5,
			RpcId = value6
		};
		return;
		IL_011a:
		value.IsFromPool = value2;
		value.Key = value3;
		value.OldInstanceId = value4;
		value.InstanceId = value5;
		value.RpcId = value6;
	}
}
