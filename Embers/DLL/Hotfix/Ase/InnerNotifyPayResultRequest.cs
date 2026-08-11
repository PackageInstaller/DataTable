using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1149)]
[MemoryPackable(GenerateType.Object)]
public class InnerNotifyPayResultRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerNotifyPayResultRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerNotifyPayResultRequestFormatter : MemoryPackFormatter<InnerNotifyPayResultRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerNotifyPayResultRequest value)
		{
			InnerNotifyPayResultRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerNotifyPayResultRequest value)
		{
			InnerNotifyPayResultRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public int GoodsId { get; set; }

	public static InnerNotifyPayResultRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerNotifyPayResultRequest)) as InnerNotifyPayResultRequest;
		}
		return new InnerNotifyPayResultRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			GoodsId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerNotifyPayResultRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerNotifyPayResultRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerNotifyPayResultRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerNotifyPayResultRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerNotifyPayResultRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerNotifyPayResultRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int, int, long>(5, value.IsFromPool, value.UserId, value.GoodsId, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerNotifyPayResultRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		int value5;
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.GoodsId;
				value5 = value.RpcId;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0119;
			}
			reader.ReadUnmanaged<bool, long, int, int, long>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerNotifyPayResultRequest), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.GoodsId;
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
						reader.ReadUnmanaged<int>(out value4);
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
				goto IL_0119;
			}
		}
		value = new InnerNotifyPayResultRequest
		{
			IsFromPool = value2,
			UserId = value3,
			GoodsId = value4,
			RpcId = value5,
			ActorId = value6
		};
		return;
		IL_0119:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.GoodsId = value4;
		value.RpcId = value5;
		value.ActorId = value6;
	}
}
