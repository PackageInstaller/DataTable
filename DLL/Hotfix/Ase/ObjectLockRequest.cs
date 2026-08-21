using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1011)]
[MemoryPackable(GenerateType.Object)]
public class ObjectLockRequest : MessageObject, IRequest, IMessage, IMemoryPackable<ObjectLockRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class ObjectLockRequestFormatter : MemoryPackFormatter<ObjectLockRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref ObjectLockRequest value)
		{
			ObjectLockRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref ObjectLockRequest value)
		{
			ObjectLockRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long Key { get; set; }

	[MemoryPackOrder(1)]
	public long InstanceId { get; set; }

	[MemoryPackOrder(2)]
	public int Time { get; set; }

	public static ObjectLockRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(ObjectLockRequest)) as ObjectLockRequest;
		}
		return new ObjectLockRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Key = 0L;
			InstanceId = 0L;
			Time = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static ObjectLockRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<ObjectLockRequest>())
		{
			MemoryPackFormatterProvider.Register(new ObjectLockRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<ObjectLockRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<ObjectLockRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref ObjectLockRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, long, int, int>(5, value.IsFromPool, value.Key, value.InstanceId, value.Time, value.RpcId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref ObjectLockRequest? value)
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
		int value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Key;
				value4 = value.InstanceId;
				value5 = value.Time;
				value6 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				goto IL_0119;
			}
			reader.ReadUnmanaged<bool, long, long, int, int>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(ObjectLockRequest), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = 0;
				value6 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Key;
				value4 = value.InstanceId;
				value5 = value.Time;
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
							reader.ReadUnmanaged<int>(out value5);
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
				goto IL_0119;
			}
		}
		value = new ObjectLockRequest
		{
			IsFromPool = value2,
			Key = value3,
			InstanceId = value4,
			Time = value5,
			RpcId = value6
		};
		return;
		IL_0119:
		value.IsFromPool = value2;
		value.Key = value3;
		value.InstanceId = value4;
		value.Time = value5;
		value.RpcId = value6;
	}
}
