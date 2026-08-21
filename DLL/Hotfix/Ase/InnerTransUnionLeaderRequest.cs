using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1106)]
[MemoryPackable(GenerateType.Object)]
public class InnerTransUnionLeaderRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerTransUnionLeaderRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerTransUnionLeaderRequestFormatter : MemoryPackFormatter<InnerTransUnionLeaderRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerTransUnionLeaderRequest value)
		{
			InnerTransUnionLeaderRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerTransUnionLeaderRequest value)
		{
			InnerTransUnionLeaderRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public long UnionId { get; set; }

	[MemoryPackOrder(1)]
	public long NewLeaderId { get; set; }

	[MemoryPackOrder(2)]
	public PbUnionLeaderInfo NewLeaderInfo { get; set; }

	public static InnerTransUnionLeaderRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerTransUnionLeaderRequest)) as InnerTransUnionLeaderRequest;
		}
		return new InnerTransUnionLeaderRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			UnionId = 0L;
			NewLeaderId = 0L;
			NewLeaderInfo = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerTransUnionLeaderRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerTransUnionLeaderRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerTransUnionLeaderRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerTransUnionLeaderRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerTransUnionLeaderRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerTransUnionLeaderRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, long>(6, value.IsFromPool, value.UnionId, value.NewLeaderId);
		writer.WritePackable<PbUnionLeaderInfo>(value.NewLeaderInfo);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.UserId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerTransUnionLeaderRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		PbUnionLeaderInfo value5;
		int value6;
		long value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
				value4 = value.NewLeaderId;
				value5 = value.NewLeaderInfo;
				value6 = value.RpcId;
				value7 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadPackable(ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0154;
			}
			reader.ReadUnmanaged<bool, long, long>(out value2, out value3, out value4);
			value5 = reader.ReadPackable<PbUnionLeaderInfo>();
			reader.ReadUnmanaged<int, long>(out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerTransUnionLeaderRequest), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = null;
				value6 = 0;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
				value4 = value.NewLeaderId;
				value5 = value.NewLeaderInfo;
				value6 = value.RpcId;
				value7 = value.UserId;
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
							reader.ReadPackable(ref value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0154;
			}
		}
		value = new InnerTransUnionLeaderRequest
		{
			IsFromPool = value2,
			UnionId = value3,
			NewLeaderId = value4,
			NewLeaderInfo = value5,
			RpcId = value6,
			UserId = value7
		};
		return;
		IL_0154:
		value.IsFromPool = value2;
		value.UnionId = value3;
		value.NewLeaderId = value4;
		value.NewLeaderInfo = value5;
		value.RpcId = value6;
		value.UserId = value7;
	}
}
