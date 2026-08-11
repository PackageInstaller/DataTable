using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10490)]
[MemoryPackable(GenerateType.Object)]
public class H2MR_InnerRecoverUserVitRequest : MessageObject, IRequest, IMessage, IMemoryPackable<H2MR_InnerRecoverUserVitRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2MR_InnerRecoverUserVitRequestFormatter : MemoryPackFormatter<H2MR_InnerRecoverUserVitRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2MR_InnerRecoverUserVitRequest value)
		{
			H2MR_InnerRecoverUserVitRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2MR_InnerRecoverUserVitRequest value)
		{
			H2MR_InnerRecoverUserVitRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public int Vit { get; set; }

	[MemoryPackOrder(2)]
	public long LastVitRecoverTime { get; set; }

	public static H2MR_InnerRecoverUserVitRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2MR_InnerRecoverUserVitRequest)) as H2MR_InnerRecoverUserVitRequest;
		}
		return new H2MR_InnerRecoverUserVitRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			Vit = 0;
			LastVitRecoverTime = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2MR_InnerRecoverUserVitRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2MR_InnerRecoverUserVitRequest>())
		{
			MemoryPackFormatterProvider.Register(new H2MR_InnerRecoverUserVitRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2MR_InnerRecoverUserVitRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2MR_InnerRecoverUserVitRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2MR_InnerRecoverUserVitRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int, long, int>(5, value.IsFromPool, value.UserId, value.Vit, value.LastVitRecoverTime, value.RpcId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2MR_InnerRecoverUserVitRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		long value5;
		int value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.Vit;
				value5 = value.LastVitRecoverTime;
				value6 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				goto IL_0119;
			}
			reader.ReadUnmanaged<bool, long, int, long, int>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2MR_InnerRecoverUserVitRequest), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0L;
				value6 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.Vit;
				value5 = value.LastVitRecoverTime;
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
						reader.ReadUnmanaged<int>(out value4);
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
				goto IL_0119;
			}
		}
		value = new H2MR_InnerRecoverUserVitRequest
		{
			IsFromPool = value2,
			UserId = value3,
			Vit = value4,
			LastVitRecoverTime = value5,
			RpcId = value6
		};
		return;
		IL_0119:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.Vit = value4;
		value.LastVitRecoverTime = value5;
		value.RpcId = value6;
	}
}
