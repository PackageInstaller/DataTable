using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1009)]
[MemoryPackable(GenerateType.Object)]
public class ObjectRemoveRequest : MessageObject, IRequest, IMessage, IMemoryPackable<ObjectRemoveRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class ObjectRemoveRequestFormatter : MemoryPackFormatter<ObjectRemoveRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref ObjectRemoveRequest value)
		{
			ObjectRemoveRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref ObjectRemoveRequest value)
		{
			ObjectRemoveRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long Key { get; set; }

	public static ObjectRemoveRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(ObjectRemoveRequest)) as ObjectRemoveRequest;
		}
		return new ObjectRemoveRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Key = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static ObjectRemoveRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<ObjectRemoveRequest>())
		{
			MemoryPackFormatterProvider.Register(new ObjectRemoveRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<ObjectRemoveRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<ObjectRemoveRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref ObjectRemoveRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int>(3, value.IsFromPool, value.Key, value.RpcId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref ObjectRemoveRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Key;
				value4 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				goto IL_00bf;
			}
			reader.ReadUnmanaged<bool, long, int>(out value2, out value3, out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(ObjectRemoveRequest), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Key;
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
						reader.ReadUnmanaged<int>(out value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00bf;
			}
		}
		value = new ObjectRemoveRequest
		{
			IsFromPool = value2,
			Key = value3,
			RpcId = value4
		};
		return;
		IL_00bf:
		value.IsFromPool = value2;
		value.Key = value3;
		value.RpcId = value4;
	}
}
