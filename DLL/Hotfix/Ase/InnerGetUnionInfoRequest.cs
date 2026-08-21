using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1084)]
[MemoryPackable(GenerateType.Object)]
public class InnerGetUnionInfoRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerGetUnionInfoRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerGetUnionInfoRequestFormatter : MemoryPackFormatter<InnerGetUnionInfoRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerGetUnionInfoRequest value)
		{
			InnerGetUnionInfoRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerGetUnionInfoRequest value)
		{
			InnerGetUnionInfoRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public long UnionId { get; set; }

	[MemoryPackOrder(2)]
	public bool OblyBase { get; set; }

	public static InnerGetUnionInfoRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerGetUnionInfoRequest)) as InnerGetUnionInfoRequest;
		}
		return new InnerGetUnionInfoRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			UnionId = 0L;
			OblyBase = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerGetUnionInfoRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerGetUnionInfoRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerGetUnionInfoRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerGetUnionInfoRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerGetUnionInfoRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerGetUnionInfoRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, bool, int, long>(5, value.IsFromPool, value.UnionId, value.OblyBase, value.RpcId, value.UserId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerGetUnionInfoRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		bool value4;
		int value5;
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
				value4 = value.OblyBase;
				value5 = value.RpcId;
				value6 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<bool>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0119;
			}
			reader.ReadUnmanaged<bool, long, bool, int, long>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerGetUnionInfoRequest), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = false;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
				value4 = value.OblyBase;
				value5 = value.RpcId;
				value6 = value.UserId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<bool>(out value4);
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
		value = new InnerGetUnionInfoRequest
		{
			IsFromPool = value2,
			UnionId = value3,
			OblyBase = value4,
			RpcId = value5,
			UserId = value6
		};
		return;
		IL_0119:
		value.IsFromPool = value2;
		value.UnionId = value3;
		value.OblyBase = value4;
		value.RpcId = value5;
		value.UserId = value6;
	}
}
