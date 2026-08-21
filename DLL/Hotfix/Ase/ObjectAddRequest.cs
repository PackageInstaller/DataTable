using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1007)]
[MemoryPackable(GenerateType.Object)]
public class ObjectAddRequest : MessageObject, IRequest, IMessage, IMemoryPackable<ObjectAddRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class ObjectAddRequestFormatter : MemoryPackFormatter<ObjectAddRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref ObjectAddRequest value)
		{
			ObjectAddRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref ObjectAddRequest value)
		{
			ObjectAddRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long Key { get; set; }

	[MemoryPackOrder(1)]
	public long InstanceId { get; set; }

	public static ObjectAddRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(ObjectAddRequest)) as ObjectAddRequest;
		}
		return new ObjectAddRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Key = 0L;
			InstanceId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static ObjectAddRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<ObjectAddRequest>())
		{
			MemoryPackFormatterProvider.Register(new ObjectAddRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<ObjectAddRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<ObjectAddRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref ObjectAddRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, long, int>(4, value.IsFromPool, value.Key, value.InstanceId, value.RpcId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref ObjectAddRequest? value)
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
				value3 = value.Key;
				value4 = value.InstanceId;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(ObjectAddRequest), 4, memberCount);
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
				value3 = value.Key;
				value4 = value.InstanceId;
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
		value = new ObjectAddRequest
		{
			IsFromPool = value2,
			Key = value3,
			InstanceId = value4,
			RpcId = value5
		};
		return;
		IL_00eb:
		value.IsFromPool = value2;
		value.Key = value3;
		value.InstanceId = value4;
		value.RpcId = value5;
	}
}
