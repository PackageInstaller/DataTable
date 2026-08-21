using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1100)]
[MemoryPackable(GenerateType.Object)]
public class InnerModifyUnionInfoRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerModifyUnionInfoRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerModifyUnionInfoRequestFormatter : MemoryPackFormatter<InnerModifyUnionInfoRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerModifyUnionInfoRequest value)
		{
			InnerModifyUnionInfoRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerModifyUnionInfoRequest value)
		{
			InnerModifyUnionInfoRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public long UnionId { get; set; }

	[MemoryPackOrder(1)]
	public ModifyUnionInfoRequest outRequest { get; set; }

	public static InnerModifyUnionInfoRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerModifyUnionInfoRequest)) as InnerModifyUnionInfoRequest;
		}
		return new InnerModifyUnionInfoRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			UnionId = 0L;
			outRequest = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerModifyUnionInfoRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerModifyUnionInfoRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerModifyUnionInfoRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerModifyUnionInfoRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerModifyUnionInfoRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerModifyUnionInfoRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(5, value.IsFromPool, value.UnionId);
		writer.WritePackable<ModifyUnionInfoRequest>(value.outRequest);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.UserId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerModifyUnionInfoRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		ModifyUnionInfoRequest value4;
		int value5;
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
				value4 = value.outRequest;
				value5 = value.RpcId;
				value6 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0124;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			value4 = reader.ReadPackable<ModifyUnionInfoRequest>();
			reader.ReadUnmanaged<int, long>(out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerModifyUnionInfoRequest), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = null;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
				value4 = value.outRequest;
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
						reader.ReadPackable(ref value4);
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
				goto IL_0124;
			}
		}
		value = new InnerModifyUnionInfoRequest
		{
			IsFromPool = value2,
			UnionId = value3,
			outRequest = value4,
			RpcId = value5,
			UserId = value6
		};
		return;
		IL_0124:
		value.IsFromPool = value2;
		value.UnionId = value3;
		value.outRequest = value4;
		value.RpcId = value5;
		value.UserId = value6;
	}
}
