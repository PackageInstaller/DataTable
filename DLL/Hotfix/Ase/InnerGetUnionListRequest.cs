using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1088)]
[MemoryPackable(GenerateType.Object)]
public class InnerGetUnionListRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerGetUnionListRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerGetUnionListRequestFormatter : MemoryPackFormatter<InnerGetUnionListRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerGetUnionListRequest value)
		{
			InnerGetUnionListRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerGetUnionListRequest value)
		{
			InnerGetUnionListRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public int Type { get; set; }

	public static InnerGetUnionListRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerGetUnionListRequest)) as InnerGetUnionListRequest;
		}
		return new InnerGetUnionListRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			Type = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerGetUnionListRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerGetUnionListRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerGetUnionListRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerGetUnionListRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerGetUnionListRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerGetUnionListRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, long>(4, value.IsFromPool, value.Type, value.RpcId, value.UserId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerGetUnionListRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		long value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Type;
				value4 = value.RpcId;
				value5 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00ea;
			}
			reader.ReadUnmanaged<bool, int, int, long>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerGetUnionListRequest), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Type;
				value4 = value.RpcId;
				value5 = value.UserId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00ea;
			}
		}
		value = new InnerGetUnionListRequest
		{
			IsFromPool = value2,
			Type = value3,
			RpcId = value4,
			UserId = value5
		};
		return;
		IL_00ea:
		value.IsFromPool = value2;
		value.Type = value3;
		value.RpcId = value4;
		value.UserId = value5;
	}
}
